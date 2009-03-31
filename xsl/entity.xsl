<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="entity" match="reference[reftype/@id=151]">

		<div class="line-box">

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

		</div>

		<!-- related entries -->
		<xsl:for-each select="related[reftype/@id=98]">
			<div class="line-box">
				<a href="../{id}"><h1><xsl:value-of select="detail[@id=160]"/></h1></a>
				<p>Author: <xsl:value-of select="pointer[@id=538]/title"/></p>
				<p><xsl:value-of select="detail[@id=191]"/></p>
			</div>
		</xsl:for-each>

		<!-- images of this entity -->
		<xsl:variable name="images_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'image')]"/>
		<xsl:if test="$images_of">
			<div class="line-box big-thumb-gap">
				<h1>Images of <xsl:value-of select="detail[@id=160]"/></h1>
				<xsl:for-each select="$images_of">
					<a href="../{id}"><img src="{detail[@id=221]/file_thumb_url}"/></a>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- audio of this entity -->
		<xsl:variable name="audio_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'audio')]"/>
		<xsl:if test="$audio_of">
			<div class="line-box">
				<h1>Audio of <xsl:value-of select="detail[@id=160]"/></h1>
				<xsl:for-each select="$audio_of">
					<p><a href="../{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- videos of this entity -->
		<xsl:variable name="video_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'video')]"/>
		<xsl:if test="$video_of">
			<div class="line-box">
				<h1>Video of <xsl:value-of select="detail[@id=160]"/></h1>
				<xsl:for-each select="$video_of">
					<p><a href="../{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- maps of this entity -->
		<xsl:variable name="maps_of" select="related[@type='IsIn'][reftype/@id=103]"/>
		<xsl:if test="$maps_of">
			<div class="line-box">
				<h1>Maps of <xsl:value-of select="detail[@id=160]"/></h1>
				<xsl:for-each select="$maps_of">
					<p><a href="../{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
				</xsl:for-each>
			</div>
		</xsl:if>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=151]" mode="sidebar">

		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Pictures</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'image')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Sound</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'audio')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Video</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'video')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Maps and Timelines</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=103]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Subjects</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=152]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Mentioned in</xsl:with-param>
			<xsl:with-param name="items" select="reverse-pointer[@id=199][reftype/@id=99]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Other sites</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='hasExternalLink'][reftype/@id=1]"/>
		</xsl:call-template>

	</xsl:template>


	<xsl:template name="related_entities_by_type">

		<xsl:call-template name="related_items">
			<xsl:with-param name="label">People</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Person')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Artefacts</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Artefact')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Buildings</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Building')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Events</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Event')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Natural objects</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Natural')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Organisations</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Organisation')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Places</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Place')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Structures</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][starts-with(detail[@id=523], 'Structure')]"/>
		</xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
