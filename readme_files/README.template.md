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

@[ruby](scripts/sections.rb)

@[xml](logs/sections.xml)

## Section Attributes

Pass hashes to method <code>section</code> to add the name/value pairs as attributes.

TODO:

## Section CDATA

Pass strings to method <code>section</code> to log them as CDATA.

TODO:

## Section Timestamps and Durations
![Time](images/time.ico | height=70)

Add timestamps and durations to your log sections.

@[ruby](scripts/time.rb)

@[xml](logs/time.xml)

## Rescued Sections
![Rescue](images/rescue.jpg | height=70)

Add rescuing to your log sections.

@[ruby](scripts/rescue.rb)

@[xml](logs/rescue.xml)

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

@[ruby](scripts/hash.rb)

@[xml](logs/hash.xml)

### Array-Like Objects

Use method <code>put_each_with_index</clde>, or its aliases <code>put_array</code> and <code>put_set</code>, to log an object that <code>respond_to?(:each_with_index)</code>.

@[ruby](scripts/array.rb)

@[xml](logs/array.xml)

### Other Objects

Use method <code>put_data</code> to log any object.

@[ruby](scripts/data.rb)

@[xml](logs/data.xml)

### CData

Use method <code>put_cdata</code> to log a string (possibly multi-line) as CDATA.

@[ruby](scripts/cdata.rb)

@[xml](logs/cdata.xml)

## Comments

TODO:

## Custom Logging

TODO:

### Sections

TODO:

### Entries
