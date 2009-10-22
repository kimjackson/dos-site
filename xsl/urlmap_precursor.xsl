<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                exclude-result-prefixes="exsl xi"
                version="1.0">

	<xsl:variable name="urlmap">
		<xi:include href="urlmap.xml"/>
	</xsl:variable>

	<xsl:variable name="map" select="exsl:node-set($urlmap)/map"/>

	<xsl:template name="getPath">
		<xsl:param name="id"/>
		<xsl:value-of select="$map/record[id=$id]/path"/>
	</xsl:template>

</xsl:stylesheet>
