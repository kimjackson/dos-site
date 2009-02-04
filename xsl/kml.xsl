<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="kml" match="reference[reftype/@id=103]">
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
		<script type="text/javascript">
			window.onload = function() {
				if (GBrowserIsCompatible()) {
					var gx;
					var map = new GMap2(document.getElementById("map_canvas"));
					map.setCenter(new GLatLng(<xsl:value-of select="detail[@id=211]"/>, <xsl:value-of select="detail[@id=210]"/>), <xsl:value-of select="detail[@id=491]"/>);
					map.addControl(new GLargeMapControl());
					map.addControl(new GMapTypeControl());

					//map.addMapType(G_PHYSICAL_MAP);
					//map.setCenter(mapCenter, mapZoom, G_PHYSICAL_MAP);

					<xsl:for-each select="detail[@id=221]">
						gx = new GGeoXml("<xsl:value-of select="file_fetch_url"/>");
						map.addOverlay(gx);
					</xsl:for-each>

					<xsl:for-each select="detail[@id=551]">
						gx = new GGeoXml("<xsl:value-of select="."/>");
						map.addOverlay(gx);
					</xsl:for-each>

					<xsl:for-each select="pointer[@id=564]">
						<!-- a kml reference -->
						<xsl:variable name="kmlurl">http://dos-sandbox.heuristscholar.org/heurist-test/php/kml.php?id=<xsl:value-of select="id"/></xsl:variable>
						gx = new GGeoXml("<xsl:value-of select="$kmlurl"/>");
						map.addOverlay(gx);
					</xsl:for-each>

					gx = new GGeoXml("http://heuristscholar.org/cocoon/dos/sandbox/kmltrans/<xsl:value-of select="id"/>?dummy=moo");
					map.addOverlay(gx);
				}
			}

		</script>

		<div id="map_canvas" style="width: 800px; height: 800px"></div>

		[<xsl:value-of select="detail[@id=221]/file_fetch_url"/>]

	</xsl:template>


	<xsl:template match="related[reftype/@id=103] | pointer[reftype/@id=103] | reverse-pointer[reftype/@id=103]">
		<!-- the following template determines how kml records will be rendered in the related section of the page -->
		<xsl:param name="matches"/>

		<tr>
			<td>
				<a href="../{id}" class="sb_two"><xsl:value-of select="detail[@id=160]"/>, </a>
			</td>
			<td align="right">
				<img style="vertical-align: middle;horizontal-align: right" src="{$hbase}/img/reftype/{reftype/@id}.gif"/>
			</td>
		</tr>

	</xsl:template>

</xsl:stylesheet>
