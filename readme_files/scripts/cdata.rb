require 'structured_log'

text = <<EOT

Method put_cdata puts the data verbatim:

* Nothing is added or subtracted.
* Not even whitespace.

So you can use the method to log a formatted string.

(You'll need to add your own leading and trailing newlines, if desired.)

EOT
StructuredLog.open('cdata.xml') do |log|
  log.put_cdata(text)
end
