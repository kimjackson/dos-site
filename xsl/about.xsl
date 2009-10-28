<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">About Us - Dictionary of Sydney</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS"/>
	<xsl:template name="extraScripts"/>
	<xsl:template name="previewStubs"/>

	<xsl:template name="content">

<div id="block-heading">

<img src="{$urlbase}images/pictures/img-about-us.jpg" width="698" height="186"/>

<h1>The Dictionary of Sydney project</h1>

<p>
You can find out a lot more about the Dictionary of Sydney Trust and the
progress of the project at our
<a href="http://trust.dictionaryofsydney.org/">trust site</a>, including
information about the many
<a href="http://trust.dictionaryofsydney.org/www/html/93-partners-and-supporters.asp">Partners and Supporters</a>
who have made the project possible.
</p>

<p>
The Dictionary of Sydney is a groundbreaking project to produce a new kind of
history of Sydney: online, growing and changing, covering every aspect of human
life in this place. This website is the first window into the Dictionary but,
over time, it will also be accessible through other technologies, including
mobile delivery, print-on-demand and others yet to be developed.
</p>

<p>
Geographically, the Dictionary of Sydney includes the whole Sydney basin and
spans the years from the earliest human habitation to the present.
</p>

<p>
The project welcomes all kinds of history &#8211; engineering history, social
and cultural history, economic history and so on. We are also interested in
historical contributions from neighbouring disciplines such as archaeology,
sociology, literary studies, historical geography and cultural studies. This
will not be purely an 'urban history' site.
</p>

<p>
The Dictionary contains new historical writing enriched with other resources
&#8211; images, maps, sound, music, oral history, film, documents and pointers
to important objects in Sydney collections. New material will be added
regularly, and linked to what is already there. At the start, there will be
large gaps &#8211; they'll get smaller with time.
</p>

<p>
Contributors include academics, professional historians, heritage
specialists, local studies experts, genealogists, enthusiasts, volunteers and
readers. We can't possibly know all the experts we need, so we welcome help in
finding them. Readers are encouraged to contribute by suggesting topics,
authors, images, multimedia and more, using the Contribute link found on every
page.
</p>

</div>

	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
