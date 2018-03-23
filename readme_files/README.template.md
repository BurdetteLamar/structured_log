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

## Data

Add data to your log.

### Array-Like Objects

@[ruby](scripts/array.rb)

@[xml](logs/array.xml)

### Hash-LIke Objects

@[ruby](scripts/hash.rb)

@[xml](logs/hash.xml)

### Other Objects

@[ruby](scripts/data.rb)

@[xml](logs/data.xml)

### CData

@[ruby](scripts/cdata.rb)

@[xml](logs/cdata.xml)

## Comments

## Custom

### Entries

### Sections

