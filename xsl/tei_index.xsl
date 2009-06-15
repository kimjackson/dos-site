<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="//div[@id='chapters']">
		<xsl:copy>
			<xsl:copy-of select="@*|node()"/>
			<ul>
				<xsl:for-each select="//div[@id='tei']/div">
					<li>
						<a href="#" onclick="showSection({position()}); return false;"><xsl:value-of select="h2"/></a>
					</li>
				</xsl:for-each>
			</ul>
			<ul class="extra">
				<li>
					<a href="#" onclick="showSection('all'); return false;"><xsl:value-of select="h2"/>Show all</a>
				</li>
			</ul>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
