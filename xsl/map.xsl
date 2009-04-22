<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="reference[reftype/@id=103]">

		<div>

			<!-- dc.title -->
			<h1>
				<xsl:value-of select="detail[@id=160]"/>
			</h1>

			<!-- dc.description -->
			<xsl:if test="detail[@id=303]">
				<p>
					<xsl:value-of select="detail[@id=303]"/>
				</p>
			</xsl:if>

			<div id="map" style="width: 400px; height: 300px;"></div>
			<div id="timeline" style="width: 400px; height: 200px;"></div>
			<div id="timeline-scales"></div>
			<script>
				var units_top, unit_bottom = null;
				<xsl:if test="detail[@id=565]">
					units_top = Timeline.DateTime.<xsl:value-of select="detail[@id=565]"/>;
				</xsl:if>
				<xsl:if test="detail[@id=566]">
					units_bottom = Timeline.DateTime.<xsl:value-of select="detail[@id=566]"/>;
				</xsl:if>

				window.mapdata = {
					timemap: [
						<xsl:for-each select="pointer[@id=564]">
						{
							title: "<xsl:value-of select="detail[@id=160]"/>",
							data: {
								type: "kml",
								<!--url: "<xsl:value-of select="$urlbase"/>kml/<xsl:value-of select="id"/>.kml"-->
								url: "<xsl:call-template name="file_url"><xsl:with-param name="file" select="detail[@id=221]"/></xsl:call-template>"
							}
						}<xsl:if test="position() != last()">,</xsl:if>
						</xsl:for-each>
					],
					layers: [
						<xsl:for-each select="pointer[@id=588]">
						{
							title: "<xsl:value-of select="detail[@id=160]"/>",
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

				$(function() {
					initTMap(units_top, units_bottom);
				});
			</script>

		</div>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=103]" mode="sidebar">
		<xsl:call-template name="related_entities_by_type"/>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Related Terms</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=152]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Referenced in</xsl:with-param>
			<xsl:with-param name="items" select="reverse-pointer[@id=199][reftype/@id=99]"/>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
