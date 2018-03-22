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

@[ruby](scripts/sections.rb)

@[xml](logs/sections.xml)

## Timestamp and Duration
![Time](images/time.ico | height=70)

@[ruby](scripts/time.rb)

@[xml](logs/time.xml)

## Rescue
![Rescue](images/rescue.jpg | height=70)

@[ruby](scripts/rescue.rb)

@[xml](logs/rescue.xml)

## Array

@[ruby](scripts/array.rb)

@[xml](logs/array.xml)

## Hash

@[ruby](scripts/hash.rb)

@[xml](logs/hash.xml)

## Data

@[ruby](scripts/data.rb)

@[xml](logs/data.xml)

## CData

@[ruby](scripts/cdata.rb)

@[xml](logs/cdata.xml)
