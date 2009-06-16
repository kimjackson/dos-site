<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:kml="http://www.opengis.net/kml/2.2"
                version="1.0">

	<xsl:variable name="record" select="/data/export/references/reference"/>

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="/data">
		<xsl:apply-templates select="kml:kml"/>
	</xsl:template>

	<xsl:template match="kml:kml">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="kml:Placemark/kml:name">
		<name>
			<xsl:value-of select="$record/detail[@id=160]"/>
		</name>

	</xsl:template>

</xsl:stylesheet>
