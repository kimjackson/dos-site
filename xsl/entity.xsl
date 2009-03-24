<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="entity" match="reference[reftype/@id=151]">

		<!-- dc.title -->
		<h1>
			<xsl:value-of select="detail[@id=160]"/>
		</h1>

		<!-- dc.type -->
		<p>
			<xsl:value-of select="detail[@id=523]"/>
		</p>

		<!-- dc.gender -->
		<xsl:if test="detail[@id=399]">
			<p>
				<xsl:choose>
					<xsl:when test="detail[@id=399] = 'Male'">Male</xsl:when>
					<xsl:when test="detail[@id=399] = 'Female'">Female</xsl:when>
					<xsl:otherwise>Unknown</xsl:otherwise>
				</xsl:choose>
			</p>
		</xsl:if>

		<!-- dos.real -->
		<xsl:if test="detail[@id=524]">
			<p>
				<xsl:choose>
					<xsl:when test="detail[@id=524] = 'true'">Real</xsl:when>
					<xsl:otherwise>Fictional</xsl:otherwise>
				</xsl:choose>
			</p>
		</xsl:if>

		<!-- dc.description -->
		<p>
			<xsl:value-of select="detail[@id=191]"/>
		</p>


		<!-- default image: dos.main_image -->
		<xsl:if test="pointer[@id=508]">
			<img src="pointer[@id=508][1]/detail[@id=221]/file_fetch_url"/>
		</xsl:if>

		<!-- default map -->
		<xsl:if test="reverse-pointer[reftype/@id=150][detail/@id=230]">
			<div id="map"></div>
		</xsl:if>

		<!-- factoids -->
		<xsl:if test="reverse-pointer[reftype/@id=150]">
			<table class="factoids" border="0" cellpadding="2" width="100%" align="center">
				<tr>
					<th>Type</th>
					<th>Source</th>
					<th>Related</th>
					<th>Start</th>
					<th>End</th>
					<th>Place</th>
				</tr>
				<xsl:apply-templates select="reverse-pointer[reftype/@id=150]">
					<xsl:sort select="detail[@id=526]"/>
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
				</xsl:apply-templates>
			</table>
		</xsl:if>

	</xsl:template>


</xsl:stylesheet>
