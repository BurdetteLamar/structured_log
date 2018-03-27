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

And of course the class offers many ways to log data.

## About the Examples

A working example is worth a thousand words (maybe).

Each of the following sections features an example Ruby program, followed by its output log.


## Sections

### Nested Sections
![Nesting](images/nesting.jpg | height=70)

Use nested sections to give structure to your log.

@[ruby](scripts/sections.rb)

@[xml](logs/sections.xml)

### Text
![Text](images/text.jpg | height=70)

Add text to a <code>section</code> element by passing a string argument.

@[ruby](scripts/text.rb)

@[xml](logs/text.xml)

### Attributes
![Attributes](images/attributes.png | height=70)

Add attributes to a <code>section</code> element by passing a hash argument.

@[ruby](scripts/attributes.rb)

@[xml](logs/attributes.xml)

### Timestamps and Durations
![Time](images/time.ico | height=70)

Add a timestamp or duration to a <code>section</code> element by passing a special symbol argument.

@[ruby](scripts/time.rb)

@[xml](logs/time.xml)

### Rescued Section
![Rescue](images/rescue.jpg | height=70)

Add rescuing to a <code>section</code> element by passing a special symbol argument.

For the rescued exception, the class, message, and backtrace are logged.

@[ruby](scripts/rescue.rb)

@[xml](logs/rescue.xml)

### Potpourri
![Potpourri](images/potpourri.png | height=70)

Pass any mixture of arguments to method <code>section</code>.

The section name must be first; after that, anything goes.

@[ruby](scripts/potpourri.rb)

@[xml](logs/potpourri.xml)

## Data

### Hash-LIke Objects
![Hash](images/hash.png | height=70)

Use method <code>put_each_pair</code>, or its alias <code>put_hash</code>, to log an object that <code>respond_to?(:each_pair)</code>.

@[ruby](scripts/hash.rb)

@[xml](logs/hash.xml)

### Array-Like Objects
![Array](images/array.jpg | height=70)

Use method <code>put_each_with_index</code>, or its aliases <code>put_array</code> and <code>put_set</code>, to log an object that <code>respond_to?(:each_with_index)</code>.

@[ruby](scripts/array.rb)

@[xml](logs/array.xml)

### Other Objects
![Data](images/data.png | height=70)

Use method <code>put_data</code> to log any object.

@[ruby](scripts/data.rb)

@[xml](logs/data.xml)

### CData

Use method <code>put_cdata</code> to log a string (possibly multi-line) as CDATA.

@[ruby](scripts/cdata.rb)

@[xml](logs/cdata.xml)

### Comment
![Comment](images/comment.jpg | height=70)

Use method <code>comment</code> to log a comment.

@[ruby](scripts/comment.rb)

@[xml](logs/comment.xml)

## Custom Logging
![Custom](images/custom.png | width=70)

TODO:  script and log.

### Section

TODO:  script and log.

### Entry

## Uncaught Exception
![Exception](images/exception.png | width=70)

Finally, what about an uncaught exception, one not rescued by <code>:rescue</code>?

When an exception is raised in a section that does not have <code>:rescue</code>, the logger rescues and logs it anyway, just as if there were an invisible "outermost section" with <code>:rescue</code>.

TODO:  script and log.
