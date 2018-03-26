<!-- >>>>>> BEGIN GENERATED FILE (include): SOURCE readme_files/README.md -->
<!-- >>>>>> BEGIN GENERATED FILE (include): SOURCE readme_files/README.template.md -->
# Structured Log

![Structured Log](images/structured.png | height=70)

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
![Nesting](images/nesting.jpg | height=70)

Use nested sections to give structure to your log.

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
          <uncaught_exception timestamp='2018-03-26-Mon-14.34.06.902' class='LocalJumpError'>
            <message>
              no block given (yield)
            </message>
            <backtrace>
              <![CDATA[
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:66:in `block in comment'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:65:in `comment'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/sections.rb:7:in `block (4 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/sections.rb:6:in `block (3 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/sections.rb:5:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/sections.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/sections.rb:3:in `<main>'
]]>
            </backtrace>
          </uncaught_exception>
        </comment>
      </section>
    </section>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/sections.xml -->

## Section Attributes

Pass hashes to method <code>section</code> to add the name/value pairs as attributes.

TODO:

## Section CDATA

Pass strings to method <code>section</code> to log them as CDATA.

TODO:

## Section Timestamps and Durations
![Time](images/time.ico | height=70)

Add timestamps and durations to your log sections.

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
  <section name='Section with timestamp' timestamp='2018-03-26-Mon-14.34.07.152'>
    <comment>
      I have a timestamp
      <uncaught_exception timestamp='2018-03-26-Mon-14.34.07.152' class='LocalJumpError'>
        <message>
          no block given (yield)
        </message>
        <backtrace>
          <![CDATA[
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:66:in `block in comment'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:65:in `comment'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/time.rb:5:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/time.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/time.rb:3:in `<main>'
]]>
        </backtrace>
      </uncaught_exception>
    </comment>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/time.xml -->

## Rescued Sections
![Rescue](images/rescue.jpg | height=70)

Add rescuing to your log sections.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/rescue.rb -->
<code>rescue.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('rescue.xml') do |log|
  log.section('Section with rescue', :rescue) do
    log.comment('This section will terminate because of the failure.')
    fail 'This exception will be rescued and logged.'
    log.comment('This comment will not be reached.')
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
      <rescued_exception timestamp='2018-03-26-Mon-14.34.06.512' class='LocalJumpError'>
        <message>
          no block given (yield)
        </message>
        <backtrace>
          <![CDATA[
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:66:in `block in comment'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:65:in `comment'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:5:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:119:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:3:in `<main>'
]]>
        </backtrace>
      </rescued_exception>
    </comment>
    <section name='Another section'>
      <comment>
        This comment will be reached and logged, because of rescue above.
        <uncaught_exception timestamp='2018-03-26-Mon-14.34.06.512' class='LocalJumpError'>
          <message>
            no block given (yield)
          </message>
          <backtrace>
            <![CDATA[
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:66:in `block in comment'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:65:in `comment'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:10:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:129:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:9:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:3:in `<main>'
]]>
          </backtrace>
        </uncaught_exception>
      </comment>
    </section>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/rescue.xml -->

## Sections with Lots of Stuff

Pass lots of stuff to method <code>section</code>.

Except that the (required) section name must be first, the arguments can be in any order.

TODO:

## Uncaught Exceptions

TODO:  script and log.

## Data

Add data to your log.

### Hash-LIke Objects

Use method <code>put_each_pair</clde>, or its alias <code>put_hash</code>, to log an object that <code>respond_to?(:each_pair)</code>.

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

### Array-Like Objects

Use method <code>put_each_with_index</clde>, or its aliases <code>put_array</code> and <code>put_set</code>, to log an object that <code>respond_to?(:each_with_index)</code>.

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

### Other Objects

Use method <code>put_data</code> to log any object.

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
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/data.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/data.xml -->
<code>data.xml</code>
```xml
<log>
  <data name='my_array' class='Array'>
    <![CDATA[["foo", "bar", "baz", "bat"]]]>
  </data>
  <data name='my_hash' class='Hash'>
    <![CDATA[{:a=>"z", :aa=>"zz", :aaa=>"zzz", :aaaa=>"zzzz"}]]>
  </data>
  <data name='my_set' class='Set'>
    <![CDATA[#<Set: {"foo", "bar", "baz"}>]]>
  </data>
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
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/data.xml -->

### CData

Use method <code>put_cdata</code> to log a string (possibly multi-line) as CDATA.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/cdata.rb -->
<code>cdata.rb</code>
```ruby
require 'structured_log'

text = <<EOT
Method put_cdata puts the data verbatim.
Nothing is added or subtracted.
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
Nothing is added or subtracted.
Not even whitespace.]]>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/cdata.xml -->

## Comments

TODO:

## Custom Logging

TODO:

### Sections

TODO:

### Entries
<!-- <<<<<< END GENERATED FILE (include): SOURCE readme_files/README.template.md -->
<!-- <<<<<< END GENERATED FILE (include): SOURCE readme_files/README.md -->
