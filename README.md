<!-- >>>>>> BEGIN GENERATED FILE (include): SOURCE readme_files/README.md -->
<!-- >>>>>> BEGIN GENERATED FILE (resolve): SOURCE readme_files/README.template.md -->
# Structured Log

<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/structured.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/structured.png" alt="Structured Log" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Structured Log](images/structured.png | height=70)
' -->

Class <code>StructuredLog</code> offers structured (as opposed to flat) logging.  Nested sections (blocks) in Ruby code become nested XML elements in the log.

This sectioning allows you to group actions in your program, and that grouping carries over into the log.

Optionally, each section may include:
<ul>
<li>A timestamp.
<li>A duration.
<li>The ability to rescue and log an exception.
</ul>

And of course the class offers many ways to log data.

## About the Examples

A working example is worth a thousand words (maybe).

Each of the following sections features an example Ruby program, followed by its output log.


## Sections

### Nested Sections
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Nesting](images/nesting.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/nesting.jpg" alt="Nesting" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Nesting](images/nesting.jpg | height=70)
' -->

Use nested sections to give structure to your log.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/sections.rb -->
<code>sections.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('sections.xml') do |log|
  # Any code can be here.
  log.section('Outer') do
    # Any code can be here.
    log.section('Mid') do
      # Any code can be here.
      log.section('Inner') do
        # Any code can be here.
      end
      # Any code can be here.
    end
    # Any code can be here.
  end
  # Any code can be here.
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/sections.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/sections.xml -->
<code>sections.xml</code>
```xml
<log>
  <section name='Outer'>
    <section name='Mid'>
      <section name='Inner'/>
    </section>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/sections.xml -->

### Text
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Text](images/text.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/text.jpg" alt="Text" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Text](images/text.jpg | height=70)
' -->

Add text to a <code>section</code> element by passing a string argument.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/text.rb -->
<code>text.rb</code>
```ruby
require 'structured_log'

text = 'This section has text.'
StructuredLog.open('text.xml') do |log|
  log.section('with_text', text) do
    # Any code can be here.
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/text.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/text.xml -->
<code>text.xml</code>
```xml
<log>
  <section name='with_text'>
    This section has text.
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/text.xml -->

### Attributes
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Attributes](images/attributes.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/attributes.png" alt="Attributes" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Attributes](images/attributes.png | height=70)
' -->

Add attributes to a <code>section</code> element by passing a hash argument.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/attributes.rb -->
<code>attributes.rb</code>
```ruby
require 'structured_log'

attributes = {:a => 0, :b => 1}
StructuredLog.open('attributes.xml') do |log|
  log.section('with_attributes', attributes) do
    log.comment('This section has attributes a and b.')
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/attributes.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/attributes.xml -->
<code>attributes.xml</code>
```xml
<log>
  <section name='with_attributes' a='0' b='1'>
    <comment>
      This section has attributes a and b.
    </comment>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/attributes.xml -->

### Timestamps and Durations
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Time](images/time.ico | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/time.ico" alt="Time" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Time](images/time.ico | height=70)
' -->

Add a timestamp or duration to a <code>section</code> element by passing a special symbol argument.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/time.rb -->
<code>time.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('time.xml') do |log|
  log.section('Section with timestamp', :timestamp) do
    log.comment('This section has a timestamp.')
  end
  log.section('Section with duration', :duration) do
    log.comment('This section has a duration.')
    sleep 1
  end
  log.section('Section with both', :duration, :timestamp) do
    log.comment('This section has both.')
    sleep 1
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/time.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/time.xml -->
<code>time.xml</code>
```xml
<log>
  <section name='Section with timestamp' timestamp='2018-03-28-Wed-14.27.32.362'>
    <comment>
      This section has a timestamp.
    </comment>
  </section>
  <section name='Section with duration' duration_seconds='1.014'>
    <comment>
      This section has a duration.
    </comment>
  </section>
  <section name='Section with both' timestamp='2018-03-28-Wed-14.27.33.376' duration_seconds='1.014'>
    <comment>
      This section has both.
    </comment>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/time.xml -->

### Rescued Section
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Rescue](images/rescue.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/rescue.jpg" alt="Rescue" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Rescue](images/rescue.jpg | height=70)
' -->

Add rescuing to a <code>section</code> element by passing a special symbol argument.

For the rescued exception, the class, message, and backtrace are logged.

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
    </comment>
    <rescued_exception timestamp='2018-03-28-Wed-14.27.31.567' class='RuntimeError'>
      <message>
        This exception will be rescued and logged.
      </message>
      <backtrace>
        <![CDATA[
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:6:in `block (2 levels) in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:59:in `block in section'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:117:in `put_element'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:58:in `section'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/rescue.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
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

### Potpourri
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Potpourri](images/potpourri.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/potpourri.png" alt="Potpourri" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Potpourri](images/potpourri.png | height=70)
' -->

Pass any mixture of arguments to method <code>section</code>.

The section name must be first; after that, anything goes.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/potpourri.rb -->
<code>potpourri.rb</code>
```ruby
require 'structured_log'

attributes = {:a => 0, :b => 1}
more_attributes = {:c => 2, :d => 3}
text = 'This section has a potpourri.'
float = 3.14159
boolean = false
fixnum = 1066
time = Time.new
exception = RuntimeError.new('Oops!')

StructuredLog.open('potpourri.xml') do |log|
  log.section('All together now', 'Order does not matter except in aggregating text and attributes.')  do
    args = [attributes, :rescue, text, float, :duration, more_attributes, boolean, :timestamp, fixnum, time, exception]
    log.section('Potpourri', *args) do
    end
    log.section('Reverse potpourri', *args.reverse) do
    end
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/potpourri.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/potpourri.xml -->
<code>potpourri.xml</code>
```xml
<log>
  <section name='All together now'>
    Order does not matter except in aggregating text and attributes.
    <section name='Potpourri' a='0' b='1' c='2' d='3' timestamp='2018-03-28-Wed-14.27.29.757' duration_seconds='0.000'>
      This section has a potpourri.3.14159false10662018-03-28 14:27:29
      -0500#&lt;RuntimeError: Oops!&gt;
    </section>
    <section name='Reverse potpourri' timestamp='2018-03-28-Wed-14.27.29.757' c='2' d='3' a='0' b='1' duration_seconds='0.000'>
      #&lt;RuntimeError: Oops!&gt;2018-03-28 14:27:29 -05001066false3.14159This
      section has a potpourri.
    </section>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/potpourri.xml -->

## Data

### Hash-LIke Objects
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Hash](images/hash.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/hash.png" alt="Hash" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Hash](images/hash.png | height=70)
' -->

Use method <code>put_each_pair</code>, or its alias <code>put_hash</code>, to log an object that <code>respond_to?(:each_pair)</code>.

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
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Array](images/array.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/array.jpg" alt="Array" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Array](images/array.jpg | height=70)
' -->

Use method <code>put_each_with_index</code>, or its aliases <code>put_array</code> and <code>put_set</code>, to log an object that <code>respond_to?(:each_with_index)</code>.

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
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Data](images/data.png | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/data.png" alt="Data" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Data](images/data.png | height=70)
' -->

Use method <code>put_data</code> to log any object.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/data.rb -->
<code>data.rb</code>
```ruby
require 'structured_log'

data = {
    :float => 3.14,
    :fixnum => 1066,
    :false => false,
    :time => Time.new,
    :exception => RuntimeError.new('Oops!'),
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
  <data name='my_float' class='Float'>
    <![CDATA[3.14]]>
  </data>
  <data name='my_fixnum' class='Fixnum'>
    <![CDATA[1066]]>
  </data>
  <data name='my_false' class='FalseClass'>
    <![CDATA[false]]>
  </data>
  <data name='my_time' class='Time'>
    <![CDATA[2018-03-28 14:27:28 -0500]]>
  </data>
  <data name='my_exception' class='RuntimeError'>
    <![CDATA[#<RuntimeError: Oops!>]]>
  </data>
  <data name='my_nil' class='NilClass'>
    <![CDATA[nil]]>
  </data>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/data.xml -->

### Formatted Text

Use method <code>put_cdata</code> to log a string (possibly multi-line) as CDATA.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/cdata.rb -->
<code>cdata.rb</code>
```ruby
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
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/cdata.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/cdata.xml -->
<code>cdata.xml</code>
```xml
<log>
  <![CDATA[
Method put_cdata puts the data verbatim:

* Nothing is added or subtracted.
* Not even whitespace.

So you can use the method to log a formatted string.

(You'll need to add your own leading and trailing newlines, if desired.)
]]>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/cdata.xml -->

### Comment
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Comment](images/comment.jpg | height=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/comment.jpg" alt="Comment" height="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Comment](images/comment.jpg | height=70)
' -->

Use method <code>comment</code> to log a comment.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/comment.rb -->
<code>comment.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('comment.xml') do |log|
  log.comment('My comment can be any text.')
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/comment.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/comment.xml -->
<code>comment.xml</code>
```xml
<log>
  <comment>
    My comment can be any text.
  </comment>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/comment.xml -->

## Custom Logging
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Custom](images/custom.png | width=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/custom.png" alt="Custom" width="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Custom](images/custom.png | width=70)
' -->

At the heart of class <code>StructuredLog</code> is method <code>put_element</code>.  It logs an element, possibly with children, attributes, and text.  Several methods call it, and you can too.

Basically, it's just like method <code>section</code>, except that you choose the element name (instead of the fixed name <code>section</code>).

Otherwise, it handles a block and all the same arguments as <code>section</code>.

### Section

Create a custom section by calling method <code>put_element</code> with a block.  The custom section will have children if you call logging methods within the block.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/custom_section.rb -->
<code>custom_section.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('custom_section.xml') do |log|
  log.section('With blocks') do
    log.put_element('section_with_children') do
      log.put_element('child', :rank => 'Older')
      log.put_element('child', :rank => 'Younger')
    end
    log.put_element('section_with_duration', :duration, 'Block contains timed code to be timed.') do
      sleep 1
    end
    log.put_element('section_with_rescue', :rescue, 'Block contains code to be rescued if necessary.') do
    end
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/custom_section.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/custom_section.xml -->
<code>custom_section.xml</code>
```xml
<log>
  <section name='With blocks'>
    <section_with_children>
      <child rank='Older'/>
      <child rank='Younger'/>
    </section_with_children>
    <section_with_duration duration_seconds='1.014'>
      Block contains timed code to be timed.
    </section_with_duration>
    <section_with_rescue>
      Block contains code to be rescued if necessary.
    </section_with_rescue>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/custom_section.xml -->

### Entry

Create a custom entry by calling method <code>put_element</code> without a block.  The custom entry will not have children.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/custom_entry.rb -->
<code>custom_entry.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('custom_entry.xml') do |log|
  log.section('Without blocks') do
    log.put_element('element_with_text', 'No child elements, just this text.')
    log.put_element('element_with_attributes', {:a => 0, :b => 1})
    log.put_element('element_with_timestamp', :timestamp)
    log.put_element('element_with_data', 3.14159)
  end
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/custom_entry.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/custom_entry.xml -->
<code>custom_entry.xml</code>
```xml
<log>
  <section name='Without blocks'>
    <element_with_text>
      No child elements, just this text.
    </element_with_text>
    <element_with_attributes a='0' b='1'/>
    <element_with_timestamp timestamp='2018-03-28-Wed-14.27.27.433'/>
    <element_with_data>
      3.14159
    </element_with_data>
  </section>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/custom_entry.xml -->

## Uncaught Exception
<!-- >>>>>> BEGIN RESOLVED IMAGES: INPUT-LINE '![Exception](images/exception.png | width=70)
' -->
<img src="https://raw.githubusercontent.com/BurdetteLamar/structured_log/master/images/exception.png" alt="Exception" width="70">
<!-- <<<<<< END RESOLVED IMAGES: INPUT-LINE '![Exception](images/exception.png | width=70)
' -->

Finally, what about an uncaught exception, one not rescued by <code>:rescue</code>?

When an exception is raised in a section that does not have <code>:rescue</code>, the logger rescues and logs it anyway, just as if there were an invisible "outermost section" with <code>:rescue</code> (which, in fact, there is).

Just as for a rescued exception, the log includes the exception's class, message, and backtrace.

<!-- >>>>>> BEGIN INCLUDED FILE (ruby): SOURCE readme_files/scripts/exception.rb -->
<code>exception.rb</code>
```ruby
require 'structured_log'

StructuredLog.open('exception.xml') do |log|
  fail('Oops!')
end
```
<!-- <<<<<< END INCLUDED FILE (ruby): SOURCE readme_files/scripts/exception.rb -->

<!-- >>>>>> BEGIN INCLUDED FILE (xml): SOURCE readme_files/logs/exception.xml -->
<code>exception.xml</code>
```xml
<log>
  <uncaught_exception timestamp='2018-03-28-Wed-14.27.29.242' class='RuntimeError'>
    <message>
      Oops!
    </message>
    <backtrace>
      <![CDATA[
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/exception.rb:4:in `block in <main>'
C:/Ruby22/lib/ruby/gems/2.2.0/gems/structured_log-0.1.0/lib/structured_log.rb:39:in `open'
C:/Users/Burdette/Documents/GitHub/structured_log/readme_files/scripts/exception.rb:3:in `<main>'
]]>
    </backtrace>
  </uncaught_exception>
</log>
```
<!-- <<<<<< END INCLUDED FILE (xml): SOURCE readme_files/logs/exception.xml -->
<!-- <<<<<< END GENERATED FILE (resolve): SOURCE readme_files/README.template.md -->
<!-- <<<<<< END GENERATED FILE (include): SOURCE readme_files/README.md -->
