require 'rexml/document'
require 'nokogiri'

class StructuredLog

  attr_accessor \
    :file,
    :file_path,
    :backtrace_filter,
    :root_name,
    :xml_indentation

  include REXML

  DEFAULT_FILE_NAME = 'log.xml'
  DEFAULT_DIR_PATH = '.'
  DEFAULT_XML_ROOT_TAG_NAME = 'log'
  DEFAULT_XML_INDENTATION = 2

  # Message for no block error.
  NO_BLOCK_GIVEN_MSG = 'No block given'
  # Message for calling-new error.
  NO_NEW_MSG = format('Please use %s.open, not %s.new.', self.class.name, self.class.name)

  # Callers should call this method, not method +new+.
  # Options can include:
  # - :file_path => _path_.
  # - :root_name => _root-xml-tag-name_.
  # - :xml_indentation => Integer:  indentation for nesting XML sub-elements.
  def self.open(options=Hash.new)
    raise NO_BLOCK_GIVEN_MSG unless (block_given?)
    default_options = Hash[
        :file_path => File.join(DEFAULT_DIR_PATH, DEFAULT_FILE_NAME),
        :root_name => DEFAULT_XML_ROOT_TAG_NAME,
        :xml_indentation => DEFAULT_XML_INDENTATION
    ]
    options = default_options.merge(options)
    log = self.new(options, im_ok_youre_not_ok = true)
    yield log
    log.send(:dispose)
    log.file_path
  end

  # Log an XML element.
  # - +element_name+:  Element name for logged element.
  # - *+args+:  Anything;  processed left to right;  for each _arg_:
  #   - +Hash+:  becomes element attributes.
  #   - +String+:  appended to PCDATA.
  #   - +:timestamp+:  causes a timestamp to be added to the element.
  #   - +:duration+:  causes block's duration to be added to the element.
  #   - +:rescue+:  causes any exception in block to be rescued and logged.
  #   - else:  _arg_.inspect is appended to PCDATA.
  def put_element(element_name = 'element', *args)
    attributes = {}
    pcdata = ''
    start_time = nil
    duration_to_be_included = false
    block_to_be_rescued = false
    args.each do |arg|
      case
        when arg.kind_of?(Hash)
          attributes.merge!(arg)
        when arg.kind_of?(String)
          pcdata += arg
        when arg == :timestamp
          attributes[:timestamp] = StructuredLog.timestamp
        when arg == :duration
          duration_to_be_included = true
        when arg == :rescue
          block_to_be_rescued = true
        else
          pcdata = pcdata + arg.inspect
      end
    end
    log_puts("BEGIN\t#{element_name}")
    put_attributes(attributes)
    unless pcdata.empty?
      # Guard against using a terminator that's a substring of pcdata.
      s = 'EOT'
      terminator = s
      while pcdata.match(terminator) do
        terminator += s
      end
      log_puts("PCDATA\t<<#{terminator}")
      log_puts(pcdata)
      log_puts(terminator)
    end
    start_time = Time.new if duration_to_be_included
    if block_given?
      if block_to_be_rescued
        begin
          yield
        rescue Exception => x
          put_element('uncaught_exception') do
            put_element('class', x.class)
            put_element('message', x.message)
            put_element('backtrace') do
              cdata(filter_backtrace(x.backtrace))
            end
          end
        end
      else
        yield
      end
    end
    if start_time
      end_time = Time.now
      duration_f = end_time.to_f - start_time.to_f
      duration_s = format('%.3f', duration_f)
      put_attributes({:duration_seconds => duration_s})
    end
    log_puts("END\t#{element_name}")
    nil
  end

  def put_each_with_index(name, obj)
    lines = ['']
    obj.each_with_index do |item, i|
      lines.push(format('%6d %s', i, item.to_s))
    end
    lines.push('')
    lines.push('')
    put_element('each_with_index', :name => name, :class => obj.class) do
      cdata(lines.join("\n"))
    end
    nil
  end

  def put_each_pair(name, obj)
    lines = ['']
    max_key_size = obj.keys.max_by(&:size).size
    max_val_size = obj.values.max_by(&:size).size
    obj.each_pair do |key, value|
      lines.push(format('%s => %s', key.to_s.rjust(max_key_size), value.to_s.ljust(max_val_size)))
    end
    lines.push('')
    lines.push('')
    put_element('each_', :name => name, :class => obj.class) do
      cdata(lines.join("\n"))
    end
    nil
  end

  def put_data(name, obj)
    put_element('data', :name => name, :class => obj.class) do
      cdata(obj.inspect)
    end
  end

  # Start a new section, within the current section.
  # Sections may be nested.
  def section(name, *args)
    put_element('section', {:name => name}, *args) do
      yield
    end
    nil
  end

  def comment(text, *args)
    put_element('comment', text, *args)
    nil
  end

  private

  def initialize(options=Hash.new, im_ok_youre_not_ok = false)
    unless im_ok_youre_not_ok
      # Caller should call StructuredLog.open, not StructuredLog.new.
      raise RuntimeError.new(NO_NEW_MSG)
    end
    self.file_path = options[:file_path]
    self.root_name = options[:root_name]
    self.xml_indentation = options[:xml_indentation]
    self.backtrace_filter = options[:backtrace_filter] || /log|ruby/
    self.file = File.open(self.file_path, 'w')
    log_puts("REMARK\tThis text log is the precursor for an XML log.")
    log_puts("REMARK\tIf the logged process completes, this text will be converted to XML.")
    log_puts("BEGIN\t#{self.root_name}")
    nil
  end

  def dispose

    # Close the text log.
    log_puts("END\t#{self.root_name}")
    self.file.close

    # Create the xml log.
    document = REXML::Document.new
    File.open(self.file_path, 'r') do |file|
      element = document
      stack = Array.new
      data_a = nil
      terminator = nil
      file.each_line do |line|
        line.chomp!
        line_type, text = line.split("\t", 2)
        case line_type
          when 'REMARK'
            next
          when 'BEGIN'
            element_name = text
            element = element.add_element(element_name)
            stack.push(element)
          when 'END'
            stack.pop
            element = stack.last
          when 'ATTRIBUTE'
            attr_name, attr_value = text.split("\t", 2)
            element.add_attribute(attr_name, attr_value)
          when 'CDATA'
            stack.push(:cdata)
            data_a = Array.new
            terminator = text.split('<<', 2).last
          when 'PCDATA'
            stack.push(:pcdata)
            data_a = Array.new
            terminator = text.split('<<', 2).last
          when terminator
            data_s = data_a.join("\n")
            data_a = nil
            terminator = nil
            data_type = stack.last
            case data_type
              when :cdata
                cdata = CData.new(data_s)
                element.add(cdata)
              when :pcdata
                element.add_text(data_s)
              else
                # Don't want to raise an exception and spoil the run
            end
            stack.pop
          else
            data_a.push(line) if (terminator)
        end
      end
      document << XMLDecl.default
    end

    File.open(self.file_path, 'w') do |file|
      document.write(file, self.xml_indentation)
      file.puts('')
    end
    nil
  end

  def put_attributes(attributes)
    attributes.each_pair do |name, value|
      value = case
                when value.is_a?(String)
                  value
                when value.is_a?(Symbol)
                  value.to_s
                else
                  value.inspect
              end
      log_puts("ATTRIBUTE\t#{name}\t#{value}")
    end
    nil
  end

  def log_puts(text)
    self.file.puts(text)
    self.file.flush
    nil
  end

  def cdata(text)
    # Guard against using a terminator that's a substring of the cdata.
    s = 'EOT'
    terminator = s
    while text.match(terminator) do
      terminator += s
    end
    log_puts("CDATA\t<<#{terminator}")
    log_puts(text)
    log_puts(terminator)
    nil
  end

  # Filters lines that are from ruby or log, to make the backtrace more readable.
  def filter_backtrace(lines)
    filtered = ['']
    lines.each do |line|
      unless line.match(self.backtrace_filter)
        filtered.push(line)
      end
    end
    filtered.join("\n")
  end

  # Return a timestamp string.
  # The important property of this string
  # is that it can be incorporated into a legal directory path
  # (i.e., has no colons, etc.).
  def self.timestamp
    now = Time.now
    ts = now.strftime('%Y-%m-%d-%a-%H.%M.%S')
    usec_s = (now.usec / 1000).to_s
    while usec_s.length < 3 do
      usec_s = '0' + usec_s
    end
    # noinspection RubyUnusedLocalVariable
    ts += ".#{usec_s}"
  end

end
