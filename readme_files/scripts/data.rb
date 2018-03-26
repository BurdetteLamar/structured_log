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
}
StructuredLog.open('data.xml') do |log|
  data.each_pair do |type, datum|
    name = "my_#{type}"
    log.put_data(name, datum)
  end
end
