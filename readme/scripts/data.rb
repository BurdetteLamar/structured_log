require 'structured_log'

data = {
    :array => %w/foo bar baz bat/,
    :hash => {
        :a => 'z',
        :aa => 'zz',
        :aaa => 'zzz',
        :aaaa => 'zzzz',
    },
    :set => Set.new(%w/foo bar baz/),
    :float => 3.14,
    :fixnum => 1066,
    :false => false,
    :string => 'Hello',
    :nil => nil,
    :dir => Dir.new(File.dirname(__FILE__)),
    :file => File.new(__FILE__)
}
StructuredLog.open('data.xml') do |log|
  data.each_pair do |type, datum|
    name = "my_#{type}"
    log.put_data(name, datum)
    # case
    #   when datum.respond_to?(:each_pair)
    #     log.put_each_pair(name, datum)
    #   when datum.respond_to?(:each_with_index)
    #     log.put_each_with_index(name, datum)
    #   when datum.respond_to?(:path)
    #     log.put_path(name, datum)
    #   else
    #     log.put_data(name, datum)
    # end
  end
end
