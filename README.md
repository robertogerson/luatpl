luatpl (Lua Inline Template Specification)
=========================================
This project enables Lua to be used as a imperative template specification
language. This is similar to how PHP, ASP, JSP, etc. are integrated to HTML. 

In special, the use of Lua as base for imperative template specification
and processing allowed us to use our solution to develop iDTV application
based on  <a href="http://www.ginga.org.br">Ginga middleware</a>, even that
live generated ones.

luatpl embeds Lua code inside any document. In our case, we have used it to
embed Lua code inside an NCL document. Additionally, we have developed a
script that receives a template file (with mixed some language and Lua code)
and a filling file (also a Lua script) and results in a final and complete
document.

Every code inside a [! and !] is treated as a Lua code. Also, if we want just
print a value of a string we can use the notation [!=variable!].

### Usage
In order to use the luatpl-imp you just need to run lua as following:

	$ lua luatpl.lua template.ncl template.in

### Slides Show Example

The slides show example is an NCL document with inlined Lua code that after
processed will presents a media after another (in sequence). The template user
must inform only the list of medias that must be played in sequence.

#### Template File
	
	<body>
		<port id="port1" component="[!=medias[1].id!]" />
		<media id="[!=medias[1].id!]" src="[!=medias[1].src!]"/>
		
		[!for i=2,#medias do!]
		<media id="[!=medias[i].id!]" src="[!=medias[i].src!]"/>
		<link id="[!= !]" xconnector="onEndStart">
			<bind component="[!=medias[i-1].id!]" role="onEnd"/>
			<bind component="[!=medias[i].id!]" role="start"/>
		</link>
		[!end!]
	</body>


#### Filling file example
	
	medias = {
		{ id = "media1", src="media/media1.mp4" },
		{ id = "media2", src="media/media2.mp4"},
		{ id = "media3", src="media/media3.mp4" },
		{ id = "media4", src="media/media3.mp4" }
	};

