require 'structured_log'

float = 3.14159
boolean = false
fixnum = 1066
time = Time.new
exception = RuntimeError.new('Oops!')

StructuredLog.open('potpourri_other.xml') do |log|
  log.section('Others', 'Other values are logged as the string returned by value.inspect.')do
    [float, boolean, fixnum, time, exception].each do |value|
      element_name = "Log instance of #{value.class}"
      log.section(element_name, value) do
      end
    end
  end
end
