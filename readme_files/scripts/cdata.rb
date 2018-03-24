require 'structured_log'

text = <<EOT
Method put_cdata puts the data verbatim.
Nothing is added or subtracted.
Not even whitespace.
EOT
StructuredLog.open('cdata.xml') do |log|
  log.put_cdata(text)
end
