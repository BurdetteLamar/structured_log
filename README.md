<!-- >>>>>> BEGIN GENERATED FILE (include): SOURCE readme_files/README.md -->
<!-- >>>>>> BEGIN GENERATED FILE (resolve): SOURCE readme_files/README.template.md -->
# Structured Log

<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/structured.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/structured.png" alt="Structured Log" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/structured.png | height=70)
' -->

<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '<!-- [![Gem Version](https://badge.fury.io/rb/structured_log.svg)](https://badge.fury.io/rb/structured_log) -->
' -->
<!-- [<img src="https://badge.fury.io/rb/structured_log" alt="Gem Version](https://badge.fury.io/rb/structured_log.svg)"> -->
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '<!-- [![Gem Version](https://badge.fury.io/rb/structured_log.svg)](https://badge.fury.io/rb/structured_log) -->
' -->

Class <code>StructuredLog</code> offers structured (as opposed to flat) logging.  Nested sections (blocks) in Ruby code become nested XML elements in the log.

This sectioning allows you to group actions in your program, and that grouping carries over into the log.

Optionally, each section may include:
<ul>
<li>A timestamp.
<li>A duration.
<li>The ability to rescue and log an exception.
</ul>

And of course the logger offers many ways to log data.

## About the Examples

A working example is worth a thousand words (maybe).

Each of the following sections features an example Ruby program, followed by its output log.

## Nested Sections
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/nesting.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/nesting.jpg" alt="Structured Log" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/nesting.jpg | height=70)
' -->

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/sections.rb -->
<code>sections.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('sections.xml') do |log|
  log.section('Outer') do
    log.section('Mid') do
      log.section('Inner') do
        log.comment('I am nested.')
      end
    end
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/sections.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/sections.xml -->
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
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/sections.xml -->

## Timestamp and Duration
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/time.ico | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/time.ico" alt="Structured Log" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/time.ico | height=70)
' -->

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/time.rb -->
<code>time.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('time.xml') do |log|
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
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/time.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/time.xml -->
<code>time.xml</code>
```xml
<log>
  <section name='Section with timestamp' timestamp='2018-03-05-Mon-15.58.21.555'>
    <comment>
      I have a timestamp
    </comment>
  </section>
  <section name='Section with duration' duration_seconds='1.014'>
    <comment>
      I have a duration
    </comment>
  </section>
  <section name='Section with both' timestamp='2018-03-05-Mon-15.58.22.569' duration_seconds='1.014'>
    <comment>
      I have a both
    </comment>
  </section>
  <section name='Order does not matter' timestamp='2018-03-05-Mon-15.58.23.583' duration_seconds='1.014'>
    <comment>
      I have a both
    </comment>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/time.xml -->

## Rescue
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/rescue.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/rescue.jpg" alt="Structured Log" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/rescue.jpg | height=70)
' -->

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/rescue.rb -->
<code>rescue.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('rescue.xml') do |log|
  log.section('Section with rescue', :rescue) do
    log.comment('This section will terminate because of the failure.')
    fail 'This exception will be rescued and logged.'
    log.comment('This comment will not be in the log.')
  end
  log.section('Another section') do
    log.comment('This comment will be reached and logged, because of rescue above.')
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/rescue.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/rescue.xml -->
<code>rescue.xml</code>
```xml
<log>
  <section name='Section with rescue'>
    <comment>
      This section will terminate because of the failure.
    </comment>
    <rescued_exception timestamp='2018-03-05-Mon-15.58.21.055' class='RuntimeError'>
      <message>
        This exception will be rescued and logged.
      </message>
      <backtrace>
        <![CDATA[
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:6:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:169:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:91:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:168:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:38:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:3:in `<main>'
]]>
      </backtrace>
    </rescued_exception>
  </section>
  <section name='Another section'>
    <comment>
      This comment will be reached and logged, because of rescue above.
    </comment>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/rescue.xml -->

## Array

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/array.rb -->
<code>array.rb</code>
```ruby
require 'structured_log'

array = %w/foo bar baz bat/
StructuredLog.open('array.xml') do |log|
  log.put_array('my_array', array)
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/array.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/array.xml -->
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
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/array.xml -->

## Hash

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/hash.rb -->
<code>hash.rb</code>
```ruby
require 'structured_log'

hash = {
    :a => 'z',
    :aa => 'zz',
    :aaa => 'zzz',
    :aaaa => 'zzzz',
}
StructuredLog.open('hash.xml') do |log|
  log.put_hash('my_hash', hash)
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/hash.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/hash.xml -->
<code>hash.xml</code>
```xml
<log>
  <each_pair name='my_hash' class='Hash'>
    <![CDATA[
   a => z   
  aa => zz  
 aaa => zzz 
aaaa => zzzz
]]>
  </each_pair>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/hash.xml -->

## Data

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/data.rb -->
<code>data.rb</code>
```ruby
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
  # Log the return value for a particular method.
  file = File.new(__FILE__)
  log.put_method_return_value('my_file_path', file, :path)
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/data.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/data.xml -->
<code>data.xml</code>
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
  <each_pair name='my_hash' class='Hash'>
    <![CDATA[
   a => z   
  aa => zz  
 aaa => zzz 
aaaa => zzzz
]]>
  </each_pair>
  <each_with_index name='my_set' class='Set'>
    <![CDATA[
     0 foo
     1 bar
     2 baz
]]>
  </each_with_index>
  <data name='my_float' class='Float'>
    <![CDATA[3.14]]>
  </data>
  <data name='my_fixnum' class='Fixnum'>
    <![CDATA[1066]]>
  </data>
  <data name='my_false' class='FalseClass'>
    <![CDATA[false]]>
  </data>
  <data name='my_string' class='String'>
    <![CDATA["Hello"]]>
  </data>
  <data name='my_nil' class='NilClass'>
    <![CDATA[nil]]>
  </data>
  <method_return_value name='my_file_path' class='File' method='path'>
    <![CDATA[C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/data.rb]]>
  </method_return_value>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/data.xml -->

## CData

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/cdata.rb -->
<code>cdata.rb</code>
```ruby
require 'structured_log'

text = <<EOT
Method put_cdata puts the data verbatim.
Nothing is added or detracted.
Not even whitespace.
EOT
StructuredLog.open('cdata.xml') do |log|
  log.put_cdata(text)
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/cdata.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/cdata.xml -->
<code>cdata.xml</code>
```xml
<log>
  <![CDATA[Method put_cdata puts the data verbatim.
Nothing is added or detracted.
Not even whitespace.]]>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/cdata.xml -->
<!-- <<<<<< END GENERATED FILE (resolve): SOURCE readme_files/README.template.md -->
<!-- <<<<<< END GENERATED FILE (include): SOURCE readme_files/README.md -->
