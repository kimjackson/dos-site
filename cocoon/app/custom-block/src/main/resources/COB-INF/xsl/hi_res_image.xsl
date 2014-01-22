<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

	<xsl:template match="record[type/@id=168][detail[@id=618] = 'image']">

		<div>

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p class="map-description">
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<div id="map" class="image"/>

			<script type="text/javascript">
				$(function () { RelBrowser.GMapImage.init(<xsl:value-of select="id"/>, <xsl:value-of select="detail[@id=587]"/>); });
			</script>

			<p class="attribution">
				<xsl:call-template name="makeMediaAttributionStatement">
					<xsl:with-param name="record" select="."/>
				</xsl:call-template>
			</p>

			<xsl:if test="detail[@id=590]">
				<p class="license">
					<xsl:call-template name="makeLicenseIcon">
						<xsl:with-param name="record" select="."/>
					</xsl:call-template>
				</p>
			</xsl:if>

		</div>

	</xsl:template>


	<xsl:template match="record[type/@id=168][detail[@id=618] = 'image']" mode="sidebar">
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedEntitiesByType"/>
			<xsl:call-template name="connections"/>
		</div>
	</xsl:template>

</xsl:stylesheet>
