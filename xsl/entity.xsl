<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                version="1.0">

	<xsl:template name="entity" match="reference[reftype/@id=151]">

		<div class="list-left-col"/>
		<div class="list-right-col">

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<div class="list-right-col-content">
					<div class="entity-content">
						<p>
							<xsl:value-of select="detail[@id=191]"/>
						</p>
					</div>
				</div>
			</xsl:if>

			<xsl:variable name="mapclass">
				<xsl:choose>
					<xsl:when test="pointer[@id=508]">
						<xsl:text>entity-map</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>entity-map wide</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!-- default image: dos.main_image -->
			<xsl:if test="pointer[@id=508]">
				<div class="entity-picture">
					<img>
						<xsl:attribute name="alt"/><!-- FIXME -->
						<xsl:attribute name="src">
							<xsl:call-template name="getFileURL">
								<xsl:with-param name="file" select="pointer[@id=508][1]/detail[@id=221]"/>
								<xsl:with-param name="size" select="'medium'"/>
							</xsl:call-template>
						</xsl:attribute>
					</img>
				</div>
			</xsl:if>

			<!-- map -->
			<xsl:if test="reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]">
				<style>#map { display: none; }</style>
				<div id="map" class="{$mapclass}"/>
				<div class="clearfix"/>
				<div id="timeline-zoom"/>
				<div id="timeline" class="entity-timeline"/>
				<script>
					window.mapdata = {
						timemap: [ {
							data: {
								type: "kml",
								url: "../kml/full/<xsl:value-of select="id"/>"
								//url: "<xsl:value-of select="$urlbase"/>kml/full/<xsl:value-of select="id"/>.kml"
							}
						} ]
					};
					$(function () {
						initTMap(true);
					});
				</script>
				<xsl:if test="reverse-pointer[reftype/@id=150]/detail[@id=230]">
					<style>#map { display: block; }</style>
				</xsl:if>
			</xsl:if>

			<!-- factoids -->
			<xsl:if test="reverse-pointer[reftype/@id=150]">
				<xsl:call-template name="factoids"/>
			</xsl:if>

		</div>
		<div class="clearfix"/>

		<!-- related entries -->
		<xsl:for-each select="related[reftype/@id=98]">
			<xsl:variable name="content_class">
				<xsl:choose>
					<xsl:when test="position() = last()">list-right-col-content</xsl:when>
					<xsl:otherwise>list-right-col-content margin</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<div class="list-left-col list-entry" title="Entry"/>
			<div class="list-right-col">
				<div class="list-right-col-heading">
					<h2>
						<xsl:value-of select="detail[@id=160]"/>
					</h2>
					<span class="contributor">
						by: <a href="{pointer[@id=538]/id}"><xsl:value-of select="pointer[@id=538]/title"/></a>
					</span>
					<span class="copyright"><!-- FIXME --></span>
				</div>
				<div class="{$content_class}">
					<p>
						<xsl:value-of select="detail[@id=191]"/>
						<br/><a href="{id}">&gt; more</a>
					</p>
				</div>
			</div>
		</xsl:for-each>
		<div class="clearfix"/>

		<!-- images of this entity -->
		<xsl:variable name="images_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'image')]"/>
		<xsl:if test="$images_of">
			<div class="list-left-col list-picture"></div>
			<div class="list-right-col">
				<div class="list-right-col-content entity-thumbnail">
					<xsl:for-each select="$images_of">
						<a href="{id}">
							<img>
								<xsl:attribute name="alt"/><!-- FIXME -->
								<xsl:attribute name="src">
									<xsl:call-template name="getFileURL">
										<xsl:with-param name="file" select="detail[@id=221]"/>
										<xsl:with-param name="size" select="'small'"/>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:if test="position() = last()">
									<xsl:attribute name="class">entity-thumbnail-no-margin</xsl:attribute>
								</xsl:if>
							</img>
						</a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- audio of this entity -->
		<xsl:variable name="audio_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'audio')]"/>
		<xsl:if test="$audio_of">
			<div class="list-left-col list-sound"></div>
			<div class="list-right-col">
				<div class="list-right-col-content entity-audio">
					<xsl:for-each select="$audio_of">
						<a href="{id}"><xsl:value-of select="detail[@id=160]"/></a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- videos of this entity -->
		<xsl:variable name="video_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'video')]"/>
		<xsl:if test="$video_of">
			<div class="list-left-col list-video"></div>
			<div class="list-right-col">
				<div class="list-right-col-content"><!-- FIXME -->
					<xsl:for-each select="$video_of">
						<a href="{id}"><xsl:value-of select="detail[@id=160]"/></a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- maps of this entity -->
		<xsl:variable name="maps_of" select="related[@type='IsIn'][reftype/@id=103]"/>
		<xsl:if test="$maps_of">
			<div class="list-left-col list-map"></div>
			<div class="list-right-col">
				<div class="list-right-col-content"><!-- FIXME -->
					<xsl:for-each select="$maps_of">
						<p><a href="{id}"><xsl:value-of select="detail[@id=160]"/></a></p>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
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
			<xsl:with-param name="label">Maps</xsl:with-param>
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
			<xsl:with-param name="label">External links</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='hasExternalLink'][reftype/@id=1]"/>
		</xsl:call-template>

	</xsl:template>


	<xsl:template name="related_entities_by_type">

		<xsl:call-template name="related_items">
			<xsl:with-param name="label">People</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Person']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Artefacts</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Artefact']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Buildings</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Building']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Events</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Event']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Natural features</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Natural feature']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Organisations</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Organisation']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Places</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Place']"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Structures</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Structure']"/>
		</xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
