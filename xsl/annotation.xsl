<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="reverse-pointer[@id=199][reftype/@id=99]">
		<xsl:param name="matches"/>
		<xsl:for-each select="$matches">
			<xsl:sort select="pointer[@id=322]/detail[@id=160]"/>
			<li>
				<a href="{pointer[@id=322]/id}#ref={id}" class="preview-{pointer[@id=322]/id}c{id}">
					<xsl:value-of select="pointer[@id=322]/detail[@id=160]"/>
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
