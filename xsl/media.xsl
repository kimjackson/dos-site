<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="media" match="reference[reftype/@id=74]">

		<div>

			<!-- dc.title -->
			<h1>
				<xsl:value-of select="detail[@id=160]"/>
			</h1>

			<!-- dc.type -->
			<p>
				<xsl:value-of select="detail[@id=289]"/>
			</p>

			<!-- dc.description -->
			<xsl:if test="detail[@id=303]">
				<p>
					<xsl:value-of select="detail[@id=303]"/>
				</p>
			</xsl:if>

			<!-- dc.coverage.start - dc.coverage.finish -->
			<xsl:if test="detail[@id=177]">
				<p>
					<xsl:value-of select="detail[@id=177]"/>
					<xsl:if test="detail[@id=178]"> - <xsl:value-of select="detail[@id=178]"/></xsl:if>
				</p>
			</xsl:if>

			<xsl:if test="starts-with(detail[@id=289], 'image')">
				<img src="{detail/file_fetch_url}"/>
			</xsl:if>

			<xsl:for-each select="pointer[@id=538]">
				<p>
				<xsl:choose>
					<xsl:when test="detail[@id=569]">
						<xsl:value-of select="detail[@id=569]"/>
					</xsl:when>
					<xsl:otherwise>
						Contributed by: <xsl:value-of select="detail[@id=160]"/>
					</xsl:otherwise>
				</xsl:choose>
				</p>
			</xsl:for-each>

		</div>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=74]" mode="sidebar">

		<xsl:variable name="items" select="related"/>

		<xsl:call-template name="related_items">
			<xsl:with-param name="label">This item is of:</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='isOf'][reftype/@id=151]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">This item is related to:</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=151]"/>
		</xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
