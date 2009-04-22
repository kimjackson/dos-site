<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="entity" match="reference[reftype/@id=151 or reftype/@id=91]">

		<div class="line-box">

			<!-- dc.description -->
			<p>
				<xsl:value-of select="detail[@id=191]"/>
			</p>


			<!-- default image: dos.main_image -->
			<xsl:if test="pointer[@id=508]">
				<img>
					<xsl:attribute name="src">
						<xsl:call-template name="file_url">
							<xsl:with-param name="file" select="pointer[@id=508][1]/detail[@id=221]"/>
							<xsl:with-param name="size" select="'medium'"/>
						</xsl:call-template>
					</xsl:attribute>
				</img>
			</xsl:if>

			<!-- default map -->
			<xsl:if test="reverse-pointer[reftype/@id=150][detail/@id=230]">
				<div id="map" style="width: 400px; height: 300px;"></div>
				<div id="timeline" style="width: 400px; height: 200px;"></div>
				<div id="timeline-scales"></div>
				<script>
					window.mapdata = {
						timemap: [ {
							data: {
								type: "kml",
								url: "http://heuristscholar.org<xsl:value-of select="$urlbase"/>kml/<xsl:value-of select="id"/>.kml"
							}
						} ]
					};
					$(initTMap);
				</script>
			</xsl:if>

			<!-- factoids -->
			<xsl:if test="reverse-pointer[reftype/@id=150]">
				<xsl:call-template name="factoids"/>
			</xsl:if>

		</div>

		<!-- related entries -->
		<xsl:for-each select="related[reftype/@id=98]">
			<div class="line-box">
				<a href="{id}">
					<h1>
						<xsl:call-template name="icon">
							<xsl:with-param name="record" select="."/>
							<xsl:with-param name="size" select="'medium'"/>
						</xsl:call-template>
						<xsl:value-of select="detail[@id=160]"/>
					</h1>
				</a>
				<p>Author: <xsl:value-of select="pointer[@id=538]/title"/></p>
				<p><xsl:value-of select="detail[@id=191]"/></p>
			</div>
		</xsl:for-each>

		<!-- images of this entity -->
		<xsl:variable name="images_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'image')]"/>
		<xsl:if test="$images_of">
			<div class="line-box big-thumb-gap">
				<h1>
					<xsl:call-template name="icon">
						<xsl:with-param name="record" select="$images_of[1]"/>
						<xsl:with-param name="size" select="'medium'"/>
					</xsl:call-template>
					Images of <xsl:value-of select="detail[@id=160]"/>
				</h1>
				<xsl:for-each select="$images_of">
					<a href="{id}">
						<img>
							<xsl:attribute name="src">
								<xsl:call-template name="file_url">
									<xsl:with-param name="file" select="detail[@id=221]"/>
									<xsl:with-param name="size" select="'small'"/>
								</xsl:call-template>
							</xsl:attribute>
						</img>
					</a>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- audio of this entity -->
		<xsl:variable name="audio_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'audio')]"/>
		<xsl:if test="$audio_of">
			<div class="line-box">
				<h1>
					<xsl:call-template name="icon">
						<xsl:with-param name="record" select="$audio_of[1]"/>
						<xsl:with-param name="size" select="'medium'"/>
					</xsl:call-template>
					Audio of <xsl:value-of select="detail[@id=160]"/>
				</h1>
				<xsl:for-each select="$audio_of">
					<p><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- videos of this entity -->
		<xsl:variable name="video_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'video')]"/>
		<xsl:if test="$video_of">
			<div class="line-box">
				<h1>
					<xsl:call-template name="icon">
						<xsl:with-param name="record" select="$video_of[1]"/>
						<xsl:with-param name="size" select="'medium'"/>
					</xsl:call-template>
					Video of <xsl:value-of select="detail[@id=160]"/>
				</h1>
				<xsl:for-each select="$video_of">
					<p><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
				</xsl:for-each>
			</div>
		</xsl:if>

		<!-- maps of this entity -->
		<xsl:variable name="maps_of" select="related[@type='IsIn'][reftype/@id=103]"/>
		<xsl:if test="$maps_of">
			<div class="line-box">
				<h1>
					<xsl:call-template name="icon">
						<xsl:with-param name="record" select="$maps_of[1]"/>
						<xsl:with-param name="size" select="'medium'"/>
					</xsl:call-template>
					Maps of <xsl:value-of select="detail[@id=160]"/>
				</h1>
				<xsl:for-each select="$maps_of">
					<p><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
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
