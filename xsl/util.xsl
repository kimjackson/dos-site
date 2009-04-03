<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="paragraphise">
		<xsl:param name="text"/>
		<xsl:for-each select="str:split($text, '&#xa;&#xa;')">
			<p>
				<xsl:value-of select="."/>
			</p>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="cleanQuote">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string, '&#x22;')">
				<xsl:value-of select="substring-before($string, '&#x22;')"/>
				<xsl:text>\"</xsl:text>
				<xsl:call-template name="cleanQuote">
					<xsl:with-param name="string" select="substring-after($string, '&#x22;')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="format_date">
		<xsl:param name="date"/>
		<xsl:if test="$date/year"><xsl:value-of select="$date/year"/></xsl:if>
		<xsl:if test="$date/month">/<xsl:value-of select="$date/month"/></xsl:if>
		<xsl:if test="$date/day">/<xsl:value-of select="$date/day"/></xsl:if>
	</xsl:template>


	<xsl:template name="icon">
		<xsl:param name="record"/>
		<xsl:param name="size"/>

		<xsl:variable name="name">
			<xsl:choose>
				<xsl:when test="$record[reftype/@id=151][starts-with(detail[@id=523], 'Person')]">people</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'image')]">video</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'audio')]">video</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'video')]">video</xsl:when>
				<xsl:otherwise>people</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="pixels">
			<xsl:choose>
				<xsl:when test="$size = 'small'">16</xsl:when>
				<xsl:when test="$size = 'medium'">32</xsl:when>
				<xsl:when test="$size = 'big'">64</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<img src="{$urlbase}images/{$name}-{$pixels}.jpg"/>
	</xsl:template>


	<xsl:template name="file_url">
		<xsl:param name="file"/>
		<xsl:param name="size"/>
		<xsl:variable name="dir">
			<xsl:choose>
				<xsl:when test="$size = 'small'">100</xsl:when>
				<xsl:when test="$size = 'medium'">300</xsl:when>
				<xsl:when test="$size = 'full'">full</xsl:when>
				<xsl:otherwise>full</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$urlbase"/>
		<xsl:text>files/</xsl:text>
		<xsl:value-of select="$dir"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$file/file_id"/>

	</xsl:template>

</xsl:stylesheet>
