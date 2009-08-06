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

			<p class="attribution">
				<xsl:call-template name="makeMediaAttributionStatement">
					<xsl:with-param name="record" select="."/>
				</xsl:call-template>
			</p>

			<xsl:choose>
				<xsl:when test="detail[@id=590] = 'CC-Generic'">
					<p class="license">
						<a rel="license" href="http://creativecommons.org/licenses/by/2.5/au/">
							<img alt="Creative Commons License" src="http://i.creativecommons.org/l/by/2.5/au/80x15.png"/>
						</a>
					</p>
				</xsl:when>
				<xsl:when test="detail[@id=590] = 'CC-SA'">
					<p class="license">
						<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.5/au/">
							<img alt="Creative Commons License" src="http://i.creativecommons.org/l/by-sa/2.5/au/80x15.png"/>
						</a>
					</p>
				</xsl:when>
			</xsl:choose>

			<p>
				<a target="_blank">
					<xsl:attribute name="href">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=221]"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:text>View full size</xsl:text>
				</a>
			</p>

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
