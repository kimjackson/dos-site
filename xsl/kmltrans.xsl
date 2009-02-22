<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kml="http://earth.google.com/kml/2.0" version="1.0">

	<xsl:template match="kml:kml">
		<kml xmlns="http://earth.google.com/kml/2.0">
			<!-- the following removes all placemark nodes other than the first -->
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
		<xsl:choose>
			<xsl:when test="position() = 1">
				<Placemark>
					<description>
						<xsl:apply-templates select="kml:description/kml:a">
							<xsl:with-param name="itemname" select="kml:name"/>
						</xsl:apply-templates>
					</description>
					<TimeSpan>
						<begin><xsl:value-of select="../kml:TimeSpan/kml:begin"/></begin>
						<end><xsl:value-of select="../kml:TimeSpan/kml:end"/></end>
					</TimeSpan>
					<!-- would be great to control style here -->
					<Style>
						<LineStyle>
							<color>ff0000cc</color>
							<width>4</width>
						</LineStyle>
					</Style>
					<xsl:copy-of select="kml:Point | kml:LineString | kml:MultiGeometry"/>
				</Placemark>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="kml:a">
		<xsl:param name="itemname"/>&lt;a href=http://heuristscholar.org/cocoon/dos/sandbox/item/<xsl:value-of select="substring-after(@href,'resource/')"/>&gt;<xsl:value-of select="$itemname"/>&lt;/a&gt;
	</xsl:template>

</xsl:stylesheet>
