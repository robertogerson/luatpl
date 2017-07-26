luatpl
======

luatpl enables Lua to be used as an imperative template specification language.
This is similar to how PHP, ASP, JSP, etc. are integrated to HTML. 

Every code inside a `[!` and `!]` is handled as a Lua code.  If we just want to
print a value of a string we can use the notation `[!=variable!]`.

In particular, the use of Lua as basis for template specification and
processing allowed us to use our solution to develop iDTV application based on
<a href="http://www.ginga.org.br">Ginga middleware</a>, even that live
generated ones.

### Usage
In order to use the luatpl you just need to run lua as follows:

	$ ./luatpl TEMPLATE DATAMODEL

in which `TEMPLATE` is the path for a luatpl template file and `DATAMODEL` is
the data model specification file (any .lua program can be used as a data
model).  The next section shows a simple example of a luatpl template and a
data model file.

### Slides Show Example

The slides show example is an NCL document with inlined Lua code that after
processed will presents a media after another (in sequence). The template user
must inform only the list of media objects that must be played in sequence.

#### Template File
	
	<body>
	  <port id="port1" component="[!=media[1].id!]" />
	  <media id="[!=media[1].id!]" src="[!=media[1].src!]"/>
		
	  [!for i=2,#media do!]
	  <media id="[!=media[i].id!]" src="[!=media[i].src!]"/>
	  <link xconnector="onEndStart">
	    <bind component="[!=media[i-1].id!]" role="onEnd"/>
	    <bind component="[!=media[i].id!]" role="start"/>
	  </link>
	  [!end!]
	</body>


#### The data model file example
	
	media = {
	  { id = "media1", src="media/media1.mp4" },
	  { id = "media2", src="media/media2.mp4"},
	  { id = "media3", src="media/media3.mp4" },
	  { id = "media4", src="media/media3.mp4" }
	};

