# <img src="images/structured.png" width="50"> Structured Log  

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

## <img src="images/nesting.jpg" width="50"> Nested Sections
