<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="media" match="reference[reftype/@id=74]">

		<div id="resource">

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p>
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<!-- dc.coverage.start - dc.coverage.finish>
			<xsl:if test="detail[@id=177]">
				<p>
					<xsl:value-of select="detail[@id=177]"/>
					<xsl:if test="detail[@id=178]"> - <xsl:value-of select="detail[@id=178]"/></xsl:if>
				</p>
			</xsl:if-->

			<xsl:if test="starts-with(detail[@id=289], 'image')">
				<img class="resource-image">
					<xsl:attribute name="src">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=221]"/>
							<xsl:with-param name="size" select="'large'"/>
						</xsl:call-template>
					</xsl:attribute>
				</img>
			</xsl:if>

			<xsl:if test="starts-with(detail[@id=289], 'audio')">
				<div id="media"></div>
				<script type="text/javascript">
					DOS.Media.playAudio(
						"media",
						"<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=221]"/>
						</xsl:call-template>"
					);
				</script>
			</xsl:if>

			<xsl:if test="starts-with(detail[@id=289], 'video')">
				<div id="media"></div>
				<script type="text/javascript">
					DOS.Media.playVideo(
						"media",
						"<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=221]"/>
						</xsl:call-template>",
						"<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=223]"/>
						</xsl:call-template>"
					);
				</script>
			</xsl:if>

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


	<xsl:template match="reference[reftype/@id=74]" mode="sidebar">
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedEntitiesByType"/>
			<xsl:call-template name="connections"/>
		</div>
	</xsl:template>

</xsl:stylesheet>
