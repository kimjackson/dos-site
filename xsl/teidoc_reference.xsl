<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" xmlns:xi="http://www.w3.org/2001/XInclude" version="1.0">

	<xsl:template match="reverse-pointer[@id=199][reftype/@id=99]">
		<xsl:param name="matches"/>
		<xsl:choose>
			<xsl:when test="$matches">
				<xsl:apply-templates select="$matches">
					<xsl:sort select="pointer[@id=322]/detail[@id=160]"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<a href="{$cocoonbase}/item/{pointer[@id=322]/id}/#ref{id}">
						<xsl:value-of select="pointer[@id=322]/title"/>
					</a>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
