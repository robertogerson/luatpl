<!--
Description: ...

@author: Roberto Azevedo 2008-03-28 10:45
More information: robertogerson@telemidia.puc-rio.br
-->

[!
-- vocabulary
vocabulary = {
  {
    name = "mainvideo",
    min = 1,
    max = 1,
    attrs = {
      { name = "id" }, 
      { name = "src" }
    }
  },
  {
    name = "subtitle",
    min = 1,
    max = "unbounded",
    attrs = {
      { name = "id", mandatory = true },
      { name = "src", mandatory = true },
      { name = "begin", mandatory = true },
      { name = "end", mandatory = true }
    }
  }
}

--validate
-- checkTemplateIn();
!]

<ncl id="luatpl-imp-example-seq">
  <head>
    <regionBase>
      <region id="region01"/>
    </regionBase>
    <descriptorBase>
      <descriptor id="descriptor01" region="region01"/>
    </descriptorBase>
    <connectorBase>
      <connector id="onBeginStart">
      ...
      </connector>
    </connectorBase>
  </head>
	
  <body>
    <media id="[!=mainvideo.id!]" src="[!=mainvideo.src!]">
    [!for i=1,#subtitle do!]
      <area id="area[!=i!]" begin="[!=subtitle[i].begin!]" end="[!=subtitle[i].ends!]"/>
    [!end!]
    </media>

    [!for i=1,#subtitle do!]
    <media id="[!=subtitle[i].id!]" src="[!=subtitle[i].src!]" descriptor="descriptor01"/>
    [!end!]

    [!for i=1,#subtitle do!]
    <link xconnector="onBeginStart">
      <bind component="area[!=i!]" role="onBegin"/>
      <bind component="[!=subtitle[i].id!]" role="start"/>
    </link>
    <link xconnector="onEndStop">
      <bind component="area[!=i!]" role="onEnd"/>
      <bind component="[!=subtitle[i].id!]" role="end"/>
    </link>
    [!end!]
  </body>
</ncl>

