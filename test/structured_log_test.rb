require 'test_helper'

class StructuredLogTest < Minitest::Test
  def test_version_exist
    refute_nil ::StructuredLog::VERSION
  end

  # Create a temporary logfile.
  # Caller should provide a block to be executed using the log.
  # Returns the file path to the closed log.
  def create_temp_log
    dir_path = Dir.mktmpdir
    file_path = File.join(dir_path, 'log.xml')
    # Suppress all added whitespace, even newline, to facilitate text comparison.
    StructuredLog.open(file_path, {:xml_indentation => -1}) do |log|
      yield log
    end
    file_path
  end

  # Helper class for checking logged output.
  class Checker

    attr_accessor \
      :exceptions,
      :file_path,
      :root,
      :test

    # - +test+:  +MiniTest::Test+ object, to make assertions available.
    # - +file_path+:  Path to log file.
    def initialize(test, file_path)
      # Needs the test object for accessing assertions.
      self.test = test
      self.file_path = file_path
      # Clean up after.
      ObjectSpace.define_finalizer(self, method(:finalize))
      File.open(file_path, 'r') do |file|
        self.root = REXML::Document.new(file).root
      end
      nil
    end

    # To clean up the temporary directory.
    # - +object_id+:  Id of temp directory.
    def finalize(object_id)
      file_path = ObjectSpace._id2ref(object_id).file_path
      File.delete(file_path)
      Dir.delete(File.dirname(file_path))
      nil
    end

    def assert_root_name(name)
      test.assert_equal(name, self.root.name)
    end

    def assert_xml_indentation(indentation)
      File.open(file_path) do |file|
        lines = file.readlines
        case indentation
          when -1
            # Should all be on one line; no whitespace.
            test.assert_equal(1, lines.size)
          when 0
            # Should be multiple lines, but no indentation.
            test.assert_operator(1, :<, lines.size)
            test.refute_match(/^ /, lines[1])
          when 2
            # Should be multiple lines, with 2-space indentation.
            test.assert_operator(1, :<, lines.size)
            test.assert_match(/^ {2}\S/, lines[1])
          else
            raise NotImplementedError(indentation)
        end
      end
    end

    # Verify text in element.
    def assert_element_match(ele_xpath, expected_value)
      actual_value = assert_element_exist(ele_xpath).first.text
      self.test.assert_match(expected_value, actual_value)
    end

    # Verify text in element.
    def assert_element_text(ele_xpath, expected_value)
      actual_value = assert_element_exist(ele_xpath).first.text
      self.test.assert_equal(expected_value, actual_value)
    end

    # Verify attribute match.
    def assert_attribute_match(ele_xpath, attr_name, expected_value)
      attr_xpath = format('%s/@%s', ele_xpath, attr_name)
      actual_value = assert_element_exist(attr_xpath).first.value
      self.test.assert_match(expected_value, actual_value, attr_name)
    end

    # Verify attribute value.
    def assert_attribute_value(ele_xpath, attr_name, expected_value)
      attr_xpath = format('%s/@%s', ele_xpath, attr_name)
      actual_value = assert_element_exist(attr_xpath).first.value
      self.test.assert_equal(expected_value, actual_value, attr_name)
    end

    # Verify attribute values.
    def assert_attribute_values(ele_xpath, attributes)
      attributes.each_pair do |name, value|
        assert_attribute_value(ele_xpath, name, value)
      end
    end

    # Verify element existence.
    def assert_element_exist(ele_path)
      elements = match(ele_path)
      self.test.assert_operator(elements.size, :>, 0, "No elements at xpath #{ele_path}")
      elements
    end

    def match(xpath)
      REXML::XPath.match(root, xpath)
    end

  end

  def args_common_test(log_method, element_name, &block)

    # When log_method is :section we need a block.

    # Hashes.
    h0 = {:a => '0', :b => '1'}
    h1 = {:c => '2', :b => '3'}
    h = h0.merge(h1)
    file_path = create_temp_log do |log|
      log.send(log_method, element_name, h0, h1) do
        block
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_attribute_values(ele_xpath, h)

    # Strings.
    s0 = 'foo'
    s1 = 'bar'
    s = format('%s%s',s0, s1)
    file_path = create_temp_log do |log|
      log.send(log_method, element_name, s0, s1) do
        block
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_text(ele_xpath, s)

    # Timestamp.
    file_path = create_temp_log do |log|
      log.send(log_method, element_name, :timestamp) do
        block
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_attribute_match(ele_xpath, :timestamp, /\d{4}-\d{2}-\d{2}-\w{3}-\d{2}\.\d{2}\.\d{2}\.\d{3}/)

    # Duration.
    file_path = create_temp_log do |log|
      log.send(log_method, element_name, :duration) do
        block
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_attribute_match(ele_xpath, :duration_seconds, /\d+\.\d{3}/)

    # Rescue.
    exception_message = 'Wrong'
    file_path = create_temp_log do |log|
      log.send(log_method, element_name, :rescue) do
        raise RuntimeError.new(exception_message)
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}/rescued_exception"
    checker.assert_attribute_value(ele_xpath, 'class', RuntimeError.name)
    ele_xpath = "//#{element_name}/rescued_exception/message"
    checker.assert_element_text(ele_xpath, exception_message)
    ele_xpath = "//#{element_name}/rescued_exception/backtrace"
    checker.assert_element_match(ele_xpath, __method__.to_s)

    # Others.
    [
        0,
        0.0,
        :symbol,
        true,
        Array,
        [0, 1],
    ].each do |other|
      file_path = create_temp_log do |log|
        log.send(log_method, element_name, other) do
          block
        end
      end
      checker = Checker.new(self, file_path)
      ele_xpath = "//#{element_name}"
      checker.assert_element_text(ele_xpath, other.inspect)
    end

  end

  def test_new
    exception = assert_raises(RuntimeError) do
      StructuredLog.new
    end
    assert_equal(StructuredLog::NO_NEW_MSG, exception.message)
  end

  def test_open_no_block
    exception = assert_raises(RuntimeError) do
      StructuredLog.open
    end
    assert_equal(StructuredLog::NO_BLOCK_GIVEN_MSG, exception.message)
  end

  def test_open_block
    file_path = StructuredLog.open do |_|
    end
    Checker.new(self, file_path)
  end

  def test_open_default_file_path
    file_path = StructuredLog.open do |log|
      assert_equal('./log.xml', log.file_path)
    end
    Checker.new(self, file_path)
  end

  def test_open_file_path
    file_name = 'foo.xml'
    file_path = StructuredLog.open(file_name) do |log|
      assert_equal(file_name, log.file_path)
    end
    Checker.new(self, file_path)
  end

  def test_open_root_name
    root_name = 'foo'
    file_path = StructuredLog.open('foo.xml', :root_name => root_name) do |_|
    end
    checker = Checker.new(self, file_path)
    checker.assert_root_name(root_name)
  end

  def test_open_xml_indentation
    [-1, 0, 2].each do |indentation|
      file_path = StructuredLog.open('foo.xml', :xml_indentation => indentation) do |log|
        log.section('Section') do
        end
      end
      checker = Checker.new(self, file_path)
      checker.assert_xml_indentation(indentation)
    end

  end

  def test_section
    method = :section
    # Section names.
    file_path = create_temp_log do |log|
      log.send(method, 'outer') do
        log.send(method, 'inner') do
          log.put_element('tag', 'text')
        end
      end
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//section[@name='outer']/section[@name='inner']/tag"
    checker.assert_element_text(ele_xpath, 'text')
    args_common_test(method, 'section') do
      # Will need a block for calling :section.
    end
  end

  def test_comment
    method = :comment
    comment = 'My comment'
    file_path = create_temp_log do |log|
      log.send(method, comment)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = '//comment'
    checker.assert_element_text(ele_xpath, comment)
  end

  def test_uncaught_exception
    exception_message = 'Wrong'
    file_path = StructuredLog.open('foo.xml', :xml_indentation => -1) do |_|
      raise RuntimeError.new(exception_message)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//uncaught_exception"
    checker.assert_attribute_value(ele_xpath, 'class', RuntimeError.name)
    ele_xpath = '//uncaught_exception/message'
    checker.assert_element_text(ele_xpath, exception_message)
    ele_xpath = '//uncaught_exception/backtrace'
    checker.assert_element_match(ele_xpath, __method__.to_s)
  end

  def test_put_element
    method = :put_element
    element_name = 'my_element'
    file_path = create_temp_log do |log|
      log.send(method, element_name)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_exist(ele_xpath)
    args_common_test(method, element_name)
  end

  def _test_put_each_with_index(method, arg)
    element_name = 'each_with_index'
    file_path = create_temp_log do |log|
      log.send(method, element_name, arg)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_exist(ele_xpath)
  end

  def test_put_each_with_index
    method = :put_each_with_index
    arg = [:a, :aa, :aaa]
    _test_put_each_with_index(method, arg)
  end

  def test_put_array
    method = :put_array
    arg = [:a, :aa, :aaa]
    _test_put_each_with_index(method, arg)
  end

  def test_put_set
    method = :put_set
    arg = Set.new([:a, :aa, :aaa])
    _test_put_each_with_index(method, arg)
  end

  def _test_put_each_pair(method, arg)
    element_name = 'each_pair'
    file_path = create_temp_log do |log|
      log.send(method, element_name, arg)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_exist(ele_xpath)
  end

  def test_put_each_pair
    method = :put_each_pair
    arg = {:a => 0, :b => 1}
    _test_put_each_pair(method, arg)
  end

  def test_put_hash
    method = :put_each_pair
    arg = {:a => 0, :b => 1}
    _test_put_each_pair(method, arg)
  end

  def test_put_data
    method = :put_data
    element_name = 'data'
    arg = [:a, :aa, :aaa]
    file_path = create_temp_log do |log|
      log.send(method, element_name, arg)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_exist(ele_xpath)
    arg = {:a => 0, :aa => 1, :aaa => 2}
    file_path = create_temp_log do |log|
      log.send(method, element_name, arg)
    end
    checker = Checker.new(self, file_path)
    ele_xpath = "//#{element_name}"
    checker.assert_element_exist(ele_xpath)
  end

  def test_put_method_return_value

  end

end
