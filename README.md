# Structured Log
<img src="images/structured.png" height="70"> 

<!-- [![Gem Version](https://badge.fury.io/rb/structured_log.svg)](https://badge.fury.io/rb/structured_log) -->

Class <code>StructuredLog</code> offers structured (as opposed to flat) logging.

<ul>
<li>Nested sections (blocks) in Ruby code become nested XML elements in the log.
<li>Optionally, each section may include:
<ul>
<li>A timestamp.
<li>A duration.
<li>The ability to rescue and log an exception.
</ul>
</ul>

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
  <section name='Section with timestamp' timestamp='2018-02-23-Fri-09.53.28.015'>
    <comment>
      I have a timestamp
    </comment>
  </section>
  <section name='Section with duration' duration_seconds='1.014'>
    <comment>
      I have a duration
    </comment>
  </section>
  <section name='Section with both' timestamp='2018-02-23-Fri-09.53.29.029' duration_seconds='1.014'>
    <comment>
      I have a both
    </comment>
  </section>
  <section name='Order does not matter' timestamp='2018-02-23-Fri-09.53.30.043' duration_seconds='1.015'>
    <comment>
      I have a both
    </comment>
  </section>
</log>
```

## Rescues
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
