<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="//div[@id='entry-index']">
		<xsl:copy>
			<xsl:copy-of select="@*|node()"/>
			<xsl:for-each select="//div[@id='tei']/div">
				<div>
					<a href="#" onclick="showSection({position()}); return false;"><xsl:value-of select="h2"/></a>
				</div>
			</xsl:for-each>
			<div>
				<br/>
				<a href="#" onclick="showSection('all'); return false;"><xsl:value-of select="h2"/>Show all</a>
			</div>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
