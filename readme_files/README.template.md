# Structured Log

[![Gem](https://img.shields.io/gem/v/structured_log.svg?style=flat)](http://rubygems.org/gems/structured_log "View this project in Rubygems")

<img src="images/structured.png" height="70" alt="Structured Log">

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
<img src="images/nesting.jpg" height="70" alt="Nesting">

Use nested sections to give structure to your log.

@[ruby](scripts/sections.rb)

@[xml](logs/sections.xml)

### Text
<img src="images/text.jpg" height="70" alt="Text">

Add text to a <code>section</code> element by passing a string argument.

@[ruby](scripts/text.rb)

@[xml](logs/text.xml)

### Attributes
<img src="images/attributes.png" height="70" alt="Attributes">

Add attributes to a <code>section</code> element by passing a hash argument.

@[ruby](scripts/attributes.rb)

@[xml](logs/attributes.xml)

### Timestamps and Durations
<img src="images/time.png" height="70" alt="Time">

Add a timestamp or duration to a <code>section</code> element by passing a special symbol argument.

@[ruby](scripts/time.rb)

@[xml](logs/time.xml)

### Rescued Section
<img src="images/rescue.jpg" height="70" alt="Rescue">

Add rescuing to a <code>section</code> element by passing a special symbol argument.

For the rescued exception, the class, message, and backtrace are logged.

@[ruby](scripts/rescue.rb)

@[xml](logs/rescue.xml)

### Potpourri
<img src="images/potpourri.png" height="70" alt="Potpourri">

Pass any mixture of arguments to method <code>section</code>.

The section name must be first; after that, anything goes.

@[ruby](scripts/potpourri.rb)

@[xml](logs/potpourri.xml)

## Data

### Hash-LIke Objects
<img src="images/hash.png" height="30" alt="Hash">

Use method <code>put_each_pair</code>, or its alias <code>put_hash</code>, to log an object that <code>respond_to?(:each_pair)</code>.

@[ruby](scripts/hash.rb)

@[xml](logs/hash.xml)

### Array-Like Objects
<img src="images/array.jpg" height="30" alt="Array">

Use method <code>put_each_with_index</code>, or its aliases <code>put_array</code> and <code>put_set</code>, to log an object that <code>respond_to?(:each_with_index)</code>.

@[ruby](scripts/array.rb)

@[xml](logs/array.xml)

### Other Objects
<img src="images/data.png" height="70" alt="Data">

Use method <code>put_data</code> to log any object.

@[ruby](scripts/data.rb)

@[xml](logs/data.xml)

### Formatted Text

Use method <code>put_cdata</code> to log a string (possibly multi-line) as CDATA.

@[ruby](scripts/cdata.rb)

@[xml](logs/cdata.xml)

### Comment
<img src="images/comment.png" height="70" alt="Comment">

Use method <code>comment</code> to log a comment.

@[ruby](scripts/comment.rb)

@[xml](logs/comment.xml)

## Custom Logging
<img src="images/custom.png" width="70" alt="Custom">

At the heart of class <code>StructuredLog</code> is method <code>put_element</code>.  It logs an element, possibly with children, attributes, and text.  Several methods call it, and you can too.

Basically, it's just like method <code>section</code>, except that you choose the element name (instead of the fixed name <code>section</code>).

Otherwise, it handles a block and all the same arguments as <code>section</code>.

### Section

Create a custom section by calling method <code>put_element</code> with a block.  The custom section will have children if you call logging methods within the block.

@[ruby](scripts/custom_section.rb)

@[xml](logs/custom_section.xml)

### Entry

Create a custom entry by calling method <code>put_element</code> without a block.  The custom entry will not have children.

@[ruby](scripts/custom_entry.rb)

@[xml](logs/custom_entry.xml)

## Uncaught Exception
<img src="images/exception.png" width="70" alt="Exception">

Finally, what about an uncaught exception, one not rescued by <code>:rescue</code>?

When an exception is raised in a section that does not have <code>:rescue</code>, the logger rescues and logs it anyway, just as if there were an invisible "outermost section" with <code>:rescue</code> (which, in fact, there is).

Just as for a rescued exception, the log includes the exception's class, message, and backtrace.

@[ruby](scripts/exception.rb)

@[xml](logs/exception.xml)
