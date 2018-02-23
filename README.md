# Structured Log
<img src="images/structured.png" height="70"> 

<!-- [![Gem Version](https://badge.fury.io/rb/structured_log.svg)](https://badge.fury.io/rb/structured_log) -->

Class <code>StructuredLog</code> offers structured (as opposed to flat) logging.  Nested sections (blocks) in Ruby code become nested XML elements in the log.

This sectioning allows you to group actions in your program, and that grouping carries over into the log.

Optionally, each section may include:
<ul>
<li>A timestamp.
<li>A duration.
<li>The ability to rescue and log an exception.
</ul>

And of course the logger offers many ways to log data.

## Nested Sections
<img src="images/nesting.jpg" height="70">

<code>sections.rb</code>
```ruby
require 'structured_log'

StructuredLog.open(:file_path => 'sections.xml') do |log|
  log.section('Outer') do
    log.section('Mid') do
      log.section('Inner') do
        log.comment('I am nested.')
      end
    end
  end
end
```

<code>sections.xml</code>
```xml
<log>
  <section name='Outer'>
    <section name='Mid'>
      <section name='Inner'>
        <comment>
          I am nested.
        </comment>
      </section>
    </section>
  </section>
</log>
```

## Timestamp and Duration
<img src="images/time.ico" height="70">

<code>time.rb</code>
```ruby
require 'structured_log'

StructuredLog.open(:file_path => 'time.xml') do |log|
  log.section('Section with timestamp', :timestamp) do
    log.comment('I have a timestamp')
  end
  log.section('Section with duration', :duration) do
    log.comment('I have a duration')
    sleep 1
  end
  log.section('Section with both', :duration, :timestamp) do
    log.comment('I have a both')
    sleep 1
  end
  log.section('Order does not matter', :timestamp, :duration) do
    log.comment('I have a both')
    sleep 1
  end
end
```

<code>time.xml</code>
```xml
<log>
  <section name='Section with timestamp' timestamp='2018-02-23-Fri-17.02.20.733'>
    <comment>
      I have a timestamp
    </comment>
  </section>
  <section name='Section with duration' duration_seconds='1.010'>
    <comment>
      I have a duration
    </comment>
  </section>
  <section name='Section with both' timestamp='2018-02-23-Fri-17.02.21.743' duration_seconds='1.010'>
    <comment>
      I have a both
    </comment>
  </section>
  <section name='Order does not matter' timestamp='2018-02-23-Fri-17.02.22.753' duration_seconds='1.000'>
    <comment>
      I have a both
    </comment>
  </section>
</log>
```

## Rescue
<img src="images/rescue.jpg" height="120">

<code>rescue.rb</code>
```ruby
require 'structured_log'

StructuredLog.open(:file_path => 'rescue.xml') do |log|
  log.section('Section with rescue', :rescue) do
    fail 'Boo!'
    # Section ends after logging the exception.
  end
  log.section('Another section') do
    log.comment('This section is ok.')
  end
end```

<code>rescue.xml</code>
```xml
<log>
  <section name='Section with rescue'>
    <uncaught_exception>
      <class>
        RuntimeError
      </class>
      <message>
        Boo!
      </message>
      <backtrace>
        <![CDATA[
rescue.rb:5:in `block (2 levels) in <main>'
rescue.rb:4:in `block in <main>'
rescue.rb:3:in `<main>']]>
      </backtrace>
    </uncaught_exception>
  </section>
  <section name='Another section'>
    <comment>
      This section is ok.
    </comment>
  </section>
</log>
```

## Array

<code>array.rb</code>
```ruby
require 'structured_log'

array = %w/foo bar baz bat/
StructuredLog.open(:file_path => 'array.xml') do |log|
  log.put_each_with_index('my_array', array)
end
```

<code>array.xml</code>
```xml
<log>
  <each_with_index name='my_array' class='Array'>
    <![CDATA[
     0 foo
     1 bar
     2 baz
     3 bat
]]>
  </each_with_index>
</log>
```

## Hash

<code>hash.rb</code>
```ruby
require 'structured_log'

hash = {
    :a => 'z',
    :aa => 'zz',
    :aaa => 'zzz',
    :aaaa => 'zzzz',
}
StructuredLog.open(:file_path => 'hash.xml') do |log|
  log.put_each_pair('my_hash', hash)
end
```

<code>hash.xml</code>
```xml
<log>
  <each_ name='my_hash' class='Hash'>
    <![CDATA[
   a => z   
  aa => zz  
 aaa => zzz 
aaaa => zzzz
]]>
  </each_>
</log>
```

## Data

<code>data.rb</code>
```ruby
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
```

<code>data.xml</code>
```xml
<log>
  <data name='my_data' class='Array'>
    <![CDATA[[0, 1, 2]]]>
  </data>
  <data name='my_data' class='Hash'>
    <![CDATA[{:a=>0, :b=>1}]]>
  </data>
  <data name='my_data' class='Set'>
    <![CDATA[#<Set: {"foo", "bar", "baz"}>]]>
  </data>
  <data name='my_data' class='Float'>
    <![CDATA[3.14]]>
  </data>
  <data name='my_data' class='Fixnum'>
    <![CDATA[1066]]>
  </data>
  <data name='my_data' class='FalseClass'>
    <![CDATA[false]]>
  </data>
  <data name='my_data' class='String'>
    <![CDATA["Hello"]]>
  </data>
  <data name='my_data' class='NilClass'>
    <![CDATA[nil]]>
  </data>
</log>
```
