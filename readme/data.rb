require 'structured_log'

data = [
    [0, 1, 2],
    {:a => 0, :b => 1},
    Set.new(%w/foo bar baz/),
    3.14,
    1066,
    false,
    'Hello',
    nil,
]
StructuredLog.open(:file_path => 'data.xml') do |log|
  data.each do |datum|
    log.put_data('my_data', datum)
  end
end
