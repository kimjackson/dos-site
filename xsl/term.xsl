<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="term" match="reference[reftype/@id=152]">

		<div id="subject-list">
			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p>
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<xsl:if test="related[@type='HasBroaderTerm']">
				<h2>Broader subjects</h2>
				<ul class="subject-list">
					<xsl:for-each select="related[@type='HasBroaderTerm']">
						<li><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></li>
					</xsl:for-each>
				</ul>
			</xsl:if>

			<xsl:if test="related[@type='HasNarrowerTerm']">
				<h2>Narrower subjects</h2>
				<ul class="subject-list">
					<xsl:for-each select="related[@type='HasNarrowerTerm']">
						<li><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></li>
					</xsl:for-each>
				</ul>
			</xsl:if>
		</div>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=152]" mode="sidebar">
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="related_items">
				<xsl:with-param name="label">Entries</xsl:with-param>
				<xsl:with-param name="items" select="related[reftype/@id=98]"/>
			</xsl:call-template>
		</div>
	</xsl:template>

</xsl:stylesheet>
