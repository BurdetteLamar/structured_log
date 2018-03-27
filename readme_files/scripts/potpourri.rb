require 'structured_log'

attributes = {:a => 0, :b => 1}
text = 'This section has a potpourri.'
array = [:a, :b]
float = 3.14159

StructuredLog.open('potpourri.xml') do |log|
  log.section('my_potpourri', attributes, text, :timestamp, :duration, :rescue) do
    log.comment('Hash, string, and special symbols are logged as usual.')
  end
  # Anything else has its inspect value logged as text.
  log.section('my_array', array) do
    log.comment('The value of array.inspect is logged as text.')
  end
  log.section('my_boolean', false) do
    log.comment('The value of boolean.inspect is logged as text.')
  end
  log.section('my_float', float) do
    log.comment('The value of float.inspect is logged as text.')
  end
  log.section('my_true_potpourri', array, false, float) do
    log.comment('The values of inspect are concatenated and logged as text.')
  end
end
