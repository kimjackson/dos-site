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

		<img src="{$urlbase}/images/{$name}-{$pixels}.jpg"/>
	</xsl:template>

</xsl:stylesheet>
