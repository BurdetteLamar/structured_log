require 'structured_log'

data = {
    :float => 3.14,
    :fixnum => 1066,
    :false => false,
    :time => Time.new,
    :exception => RuntimeError.new('Oops!'),
    :nil => nil,
}
StructuredLog.open('data.xml') do |log|
  data.each_pair do |type, datum|
    name = "my_#{type}"
    log.put_data(name, datum)
  end
end
