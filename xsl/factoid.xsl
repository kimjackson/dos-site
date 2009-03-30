<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template match="reverse-pointer[reftype/@id=150]">
		<tr>
			<td><!-- Type -->
				<xsl:value-of select="detail[@id=526]"/>
			</td>

			<td><!-- Source -->
				<xsl:choose>
					<xsl:when test="pointer[@id=528]/id  and  ../id != pointer[@id=528]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=528]/id}">
							<xsl:value-of select="pointer[@id=528]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=528]/id  and  ../id = pointer[@id=528]/id">
						<em>self</em>
					</xsl:when>
				</xsl:choose>
			</td>

			<td><!-- Related -->
				<xsl:choose>
					<xsl:when test="pointer[@id=529]/id  and  ../id != pointer[@id=529]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=529]/id}">
							<xsl:value-of select="pointer[@id=529]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=529]/id  and  ../id = pointer[@id=529]/id">
						<em>self</em>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="detail[@id=160]"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>

			<td><!-- Start -->
				<xsl:call-template name="format_date">
					<xsl:with-param name="date" select="detail[@id=177]"/>
				</xsl:call-template>
			</td>

			<td><!-- End -->
				<xsl:call-template name="format_date">
					<xsl:with-param name="date" select="detail[@id=178]"/>
				</xsl:call-template>
			</td>

			<td><!-- Place -->
				<xsl:choose>
					<xsl:when test="pointer[@id=528] and detail/@id=230">
						see map
					</xsl:when>
					<xsl:when test="pointer[@id=527]/id  and  ../id != pointer[@id=527]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=527]/id}">
							<xsl:value-of select="pointer[@id=527]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=527]/id  and  ../id = pointer[@id=527]/id">
						<em>self</em>
					</xsl:when>
				</xsl:choose>
			</td>
		</tr>

	</xsl:template>


</xsl:stylesheet>
