<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="entity" match="record[reftype/@id=151]">

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

			<!-- default image: dos.main_image -->
			<xsl:if test="pointer[@id=508]">
				<xsl:variable name="main_img" select="pointer[@id=508][1]"/>
				<a class="popup preview-{$main_img/id}" href="{$main_img/id}">
					<img class="entity-picture">
						<xsl:attribute name="alt"/><!-- FIXME -->
						<xsl:attribute name="src">
							<xsl:call-template name="getFileURL">
								<xsl:with-param name="file" select="$main_img/detail[@id=221]"/>
								<xsl:with-param name="size" select="'medium'"/>
							</xsl:call-template>
						</xsl:attribute>
					</img>
				</a>
			</xsl:if>

			<!-- map -->
			<xsl:if test="reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]">
				<div id="map">
					<xsl:attribute name="class">
						<xsl:text>entity-map</xsl:text>
						<xsl:if test="not(reverse-pointer[reftype/@id=150]/detail[@id=230])">
							<xsl:text> hide</xsl:text>
						</xsl:if>
					</xsl:attribute>
				</div>
				<div class="clearfix"/>
				<div id="timeline-zoom">
					<xsl:if test="not(reverse-pointer[reftype/@id=150]/detail[@id=177])">
						<xsl:attribute name="class">hide</xsl:attribute>
					</xsl:if>
				</div>
				<div id="timeline">
					<xsl:attribute name="class">
						<xsl:text>entity-timeline</xsl:text>
						<xsl:if test="not(reverse-pointer[reftype/@id=150]/detail[@id=177])">
							<xsl:text> hide</xsl:text>
						</xsl:if>
					</xsl:attribute>
				</div>
				<script type="text/javascript">
					RelBrowser.Mapping.mapdata = {
						mini: true,
						timemap: [ {
							type: "kml",
							options: {
								url: "../kml/full/rename/<xsl:value-of select="id"/>"
								//url: "<xsl:value-of select="$urlbase"/>kml/full/<xsl:value-of select="id"/>.kml"
							}
						} ]
					};
				</script>
			</xsl:if>

			<div class="clearfix"/>

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
			<div class="list-left-col list-entry" title="Entries"/>
			<div class="list-right-col">
				<div class="entity-entry">
					<div class="list-right-col-heading">
						<h2>
							<xsl:value-of select="detail[@id=160]"/>
						</h2>
						<xsl:if test="pointer[@id=538]">
							<span class="contributor">
								<xsl:text>by </xsl:text>
								<xsl:call-template name="makeAuthorList">
									<xsl:with-param name="authors" select="pointer[@id=538]"/>
								</xsl:call-template>
							</span>
						</xsl:if>
						<span class="copyright">
							<xsl:call-template name="makeLicenseIcon">
								<xsl:with-param name="record" select="."/>
							</xsl:call-template>
						</span>
					</div>
					<div class="{$content_class}">
						<p>
							<xsl:value-of select="detail[@id=191]"/>
							<br/><a href="{id}">more &#187;</a>
						</p>
					</div>
				</div>
			</div>
		</xsl:for-each>
		<div class="clearfix"/>

		<!-- images of this entity -->
		<xsl:variable name="images_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'image')][not(id = current()/pointer[@id=508]/id)]"/>
		<xsl:if test="$images_of">
			<div class="list-left-col list-image" title="Pictures"></div>
			<div class="list-right-col">
				<div class="list-right-col-content entity-thumbnail">
					<xsl:for-each select="$images_of">
						<xsl:if test="position() > 4 and position() mod 4 = 1">
							<div class="clearfix"/>
						</xsl:if>
						<div>
							<xsl:if test="position() > 3">
								<xsl:attribute name="class">
									<xsl:choose>
										<xsl:when test="position() = 4">no-right-margin</xsl:when>
										<xsl:when test="position() > 4 and position() mod 4 = 0">top-margin no-right-margin</xsl:when>
										<xsl:otherwise>top-margin</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
							</xsl:if>
							<a href="{id}" class="popup preview-{id}c{@id}">
								<img>
									<xsl:attribute name="alt"/><!-- FIXME -->
									<xsl:attribute name="src">
										<xsl:call-template name="getFileURL">
											<xsl:with-param name="file" select="detail[@id=221]"/>
											<xsl:with-param name="size" select="'thumbnail'"/>
										</xsl:call-template>
									</xsl:attribute>
								</img>
							</a>
						</div>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- audio of this entity -->
		<xsl:variable name="audio_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'audio')]"/>
		<xsl:if test="$audio_of">
			<div class="list-left-col list-audio" title="Sound"></div>
			<div class="list-right-col">
				<div class="list-right-col-audio">
					<xsl:for-each select="$audio_of">
						<a href="{id}" class="popup preview-{id}c{@id}">
							<img src="{$urlbase}images/img-entity-audio.jpg" alt=""/><!-- FIXME -->
						</a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- videos of this entity -->
		<xsl:variable name="video_of" select="related[@type='IsInMM'][starts-with(detail[@id=289], 'video')]"/>
		<xsl:if test="$video_of">
			<div class="list-left-col list-video" title="Video"></div>
			<div class="list-right-col">
				<div class="list-right-col-content entity-thumbnail">
					<xsl:for-each select="$video_of">
						<a href="{id}" class="popup preview-{id}c{@id}">
							<xsl:value-of select="detail[@id=160]"/>
						</a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

		<!-- maps of this entity -->
		<xsl:variable name="maps_of" select="related[@type='IsIn'][reftype/@id=103]"/>
		<xsl:if test="$maps_of">
			<div class="list-left-col list-map" title="Maps"></div>
			<div class="list-right-col">
				<div class="list-right-col-content"><!-- FIXME -->
					<xsl:for-each select="$maps_of">
						<a href="{id}" class="preview-{id}c{@id}">
							<xsl:value-of select="detail[@id=160]"/>
						</a>
					</xsl:for-each>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>

	</xsl:template>


	<xsl:template match="record[reftype/@id=151]" mode="sidebar">
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedEntitiesByType"/>
			<xsl:call-template name="connections"/>
		</div>
	</xsl:template>


	<xsl:template name="relatedEntitiesByType">

		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">People</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Person']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Artefacts</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Artefact']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Buildings</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Building']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Events</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Event']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Natural features</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Natural feature']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Organisations</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Organisation']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Places</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Place']"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Structures</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=151][detail[@id=523] = 'Structure']"/>
		</xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
