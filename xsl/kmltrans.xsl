<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kml="http://earth.google.com/kml/2.0" version="1.0">

	<xsl:template match="kml:kml">
		<kml xmlns="http://earth.google.com/kml/2.0">
			<xsl:apply-templates select="kml:Document"/>
		</kml>
	</xsl:template>

	<xsl:template match="kml:Document">
		<Document>
			<xsl:apply-templates select="kml:Folder"/>
		</Document>
	</xsl:template>

	<xsl:template match="kml:Folder">
		<Folder>
			<name><xsl:value-of select="kml:name"/></name>
			<description><xsl:value-of select="kml:description"/></description>
			<xsl:apply-templates select="kml:Placemark"/>
		</Folder>
	</xsl:template>

	<xsl:template match="kml:Placemark">
		<Placemark>
			<description>
				<xsl:apply-templates select="../kml:description/kml:a">
					<xsl:with-param name="itemname" select="kml:name"/>
				</xsl:apply-templates>
			</description>
			<xsl:copy-of select="../kml:TimeStamp | ../kml:TimeSpan"/>
			<xsl:copy-of select="kml:Point | kml:LineString | kml:MultiGeometry"/>
		</Placemark>
	</xsl:template>

	<xsl:template match="kml:a">
		<xsl:param name="itemname"/>
		[&lt;a<xsl:value-of select="@href"/>&gt;<xsl:value-of select="$itemname"/>&lt;/a&gt;] [<xsl:value-of select="@href"/>]
	</xsl:template>

</xsl:stylesheet>
