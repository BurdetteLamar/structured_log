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

## About the Examples

A working example is worth a thousand words (maybe).

Each of the following sections features an example Ruby program, followed by its output log.

## Nested Sections
<img src="images/nesting.jpg" height="70">

@[ruby](sections.rb)

@[xml](sections.xml)

## Timestamp and Duration
<img src="images/time.ico" height="70">

@[ruby](time.rb)

@[xml](time.xml)

## Rescue
<img src="images/rescue.jpg" height="120">

@[ruby](rescue.rb)

@[xml](rescue.xml)

## Array

@[ruby](array.rb)

@[xml](array.xml)

## Hash

@[ruby](hash.rb)

@[xml](hash.xml)

## Data

@[ruby](data.rb)

@[xml](data.xml)

## CData

@[ruby](cdata.rb)

@[xml](cdata.xml)
