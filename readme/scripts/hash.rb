require 'structured_log'

hash = {
    :a => 'z',
    :aa => 'zz',
    :aaa => 'zzz',
    :aaaa => 'zzzz',
}
StructuredLog.open(:file_path => 'hash.xml') do |log|
  log.put_hash('my_hash', hash)
end
