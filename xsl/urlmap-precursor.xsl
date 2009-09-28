<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                exclude-result-prefixes="exsl xi"
                version="1.0">

	<xsl:include href="myvariables.xsl"/>

	<xsl:variable name="urlmap">
		<xi:include href="urlmap.xml"/>
	</xsl:variable>

	<xsl:variable name="map" select="exsl:node-set($urlmap)/map"/>

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="a/@href">

		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(., '#')">
					<xsl:value-of select="substring-before(., '#')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="suffix">
			<xsl:if test="contains(., '#')">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="substring-after(., '#')"/>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="path" select="$map/record[id=$id]/path"/>

		<xsl:attribute name="href">
			<xsl:choose>
				<xsl:when test="$path">
					<xsl:text>../</xsl:text>
					<xsl:value-of select="$path"/>
					<xsl:value-of select="$suffix"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

	</xsl:template>

</xsl:stylesheet>
