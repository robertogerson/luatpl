<!--
Description: This templates shows how is possible to create a presentation
where the media objects are presented sequentiatly.

@author: Roberto Azevedo 2008-03-28 10:45
More informations: robertogerson@telemidia.puc-rio.br
-->

[!
-- vocabulary
vocabulary = {
  medias = {		
    min = 1,
    max = "unbounded",
    attrs = {
      { name = "id", type = "ID" },
      { name = "src", type = "URI" }
    }
  }
}

-- validate
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
    <port id="port1" component="[!=medias[1].id!]" />
    <media id="[!=medias[1].id!]" src="[!=medias[1].src!]"/>

    [!for i=2,#medias do!]
    <media id="[!=medias[i].id!]" src="[!=medias[i].src!]"/>
    <link xconnector="onEndStart">
      <bind component="[!=medias[i-1].id!]" role="onEnd"/>
      <bind component="[!=medias[i].id!]" role="start"/>
    </link>
    [!end!]
  </body>
</ncl>

