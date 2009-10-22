<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

	<xsl:template match="reference[reftype/@id=103]">

		<div>

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p class="map-description">
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<div id="map" class="full"/>
			<div id="timeline-zoom">
				<xsl:if test="not(related/reverse-pointer[reftype/@id=150]/detail[@id=177])">
					<xsl:attribute name="class">hide</xsl:attribute>
				</xsl:if>
			</div>
			<div id="timeline">
				<xsl:if test="not(related/reverse-pointer[reftype/@id=150]/detail[@id=177])">
					<xsl:attribute name="class">hide</xsl:attribute>
				</xsl:if>
			</div>
			<script type="text/javascript">
				<xsl:variable name="sources">
					<!-- kml references -->
					<xsl:for-each select="pointer[@id=564]">
						<source>
							<title><xsl:value-of select="detail[@id=160]"/></title>
							<!--url><xsl:call-template name="getFileURL">
									<xsl:with-param name="file" select="detail[@id=221]"/>
								</xsl:call-template></url-->
							<url>../kmlfile/<xsl:value-of select="id"/></url>
						</source>
					</xsl:for-each>
					<!-- related entities that have a TimePlace factoid -->
					<xsl:for-each select="related[reftype/@id=151]
					                             [reverse-pointer[@id=528]
					                                             [detail[@id=526]='TimePlace']]">
						<source>
							<title><xsl:value-of select="detail[@id=160]"/></title>
							<!--url><xsl:value-of select="$urlbase"/>kml/summary/<xsl:value-of select="id"/>.kml</url-->
							<url>../kml/summary/rename/<xsl:value-of select="id"/></url>
							<target><xsl:value-of select="id"/></target>
							<preview><xsl:value-of select="id"/>c<xsl:value-of select="@id"/></preview>
						</source>
					</xsl:for-each>
				</xsl:variable>

				RelBrowser.Mapping.mapdata = {
					<xsl:if test="detail[@id=230]">
					focus: "<xsl:value-of select="detail[@id=230]/geo/wkt"/>",
					</xsl:if>
					timemap: [
						<xsl:for-each select="exsl:node-set($sources)/source">
						{
							title: "<xsl:value-of select="title"/>",
							type: "kml",
							options: {
								<xsl:if test="target">target: "<xsl:value-of select="target"/>",</xsl:if>
								<xsl:if test="preview">preview: "<xsl:value-of select="preview"/>",</xsl:if>
								url: "<xsl:value-of select="url"/>"
							}
						}<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					],
					layers: [
						<xsl:for-each select="pointer[@id=588]">
						{
							title: "<xsl:value-of select="detail[@id=173]"/>",
							type: "<xsl:value-of select="detail[@id=585]"/>",
							url: "<xsl:value-of select="detail[@id=339]"/>",
							mime_type: "<xsl:value-of select="detail[@id=289]"/>",
							min_zoom: "<xsl:value-of select="detail[@id=586]"/>",
							max_zoom: "<xsl:value-of select="detail[@id=587]"/>",
							copyright: "<xsl:value-of select="detail[@id=311]"/>"
						}<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					]
				};
			</script>

		</div>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=103]" mode="sidebar">
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedEntitiesByType"/>
			<xsl:call-template name="connections"/>
		</div>
	</xsl:template>

</xsl:stylesheet>
