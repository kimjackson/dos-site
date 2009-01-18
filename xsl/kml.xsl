<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="kml" match="reference[reftype/@id=103]">
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
		<script type="text/javascript">
			window.onload = function() {
				var gx;
				if (GBrowserIsCompatible()) {
					var map = new GMap2(document.getElementById("map_canvas"));
					map.setCenter(new GLatLng(<xsl:value-of select="detail[@id=211]"/>, <xsl:value-of select="detail[@id=210]"/>), <xsl:value-of select="detail[@id=491]"/>);
					//map.addMapType(G_PHYSICAL_MAP);
					//map.setCenter(mapCenter, mapZoom, G_PHYSICAL_MAP);

					<xsl:for-each select="detail[@id=221]">
					gx = new GGeoXml("<xsl:value-of select="file_fetch_url"/>");
					map.addOverlay(gx);
					</xsl:for-each>

					gx = new GGeoXml("http://heuristscholar.org/cocoon/dos/sandbox/kmltrans/<xsl:value-of select="id"/>");
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
