<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="urlmap.xsl"/>

	<xsl:param name="base">../</xsl:param>

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match="a/@href">
		
		<!-- this template looks for a href elements only -->

		<!-- this presumably finds the id number with two cases - one with a hash after it one not  -->
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(., '#')">
					<xsl:value-of select="substring-before(., '#')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- this preserves hash endings of urls - I think for the internal doc refs in entries -->
		<xsl:variable name="suffix">
			<xsl:if test="contains(., '#')">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="substring-after(., '#')"/>
			</xsl:if>
		</xsl:variable>


		<!-- getPath template lives in urlmap.xsl - links ids to names -->
		<xsl:variable name="path">
			<xsl:call-template name="getPath">
				<xsl:with-param name="id" select="$id"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:attribute name="href">
			<xsl:choose>
				<xsl:when test="$path != ''">
					<xsl:value-of select="$base"/>
					<xsl:value-of select="$path"/>
					<xsl:value-of select="$suffix"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>

	</xsl:template>

</xsl:stylesheet>
