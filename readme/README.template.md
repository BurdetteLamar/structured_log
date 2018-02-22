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

@[ruby](sections.rb)
@[xml](sections.xml)

## Timestamp and Duration
<img src="images/time.ico" height="70">

@[ruby](time.rb)
@[xml](time.xml)

## Rescues
<img src="images/rescue.jpg" height="70">

@[ruby](rescue.rb)
@[xml](rescue.xml)
