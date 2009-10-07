<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="contributor" match="reference[reftype/@id=153]">

		<xsl:variable name="entries" select="
			reverse-pointer[@id=538][reftype/@id=98]
		"/>
		<xsl:variable name="images" select="
			reverse-pointer[@id=538][reftype/@id=74][starts-with(detail[@id=289], 'image')] |
			reverse-pointer[@id=538][reftype/@id=168][detail[@id=618] = 'image']
		"/>
		<xsl:variable name="audio" select="
			reverse-pointer[@id=538][reftype/@id=74][starts-with(detail[@id=289], 'audio')]
		"/>
		<xsl:variable name="video" select="
			reverse-pointer[@id=538][reftype/@id=74][starts-with(detail[@id=289], 'video')]
		"/>

		<div id="subject-list">
			<!-- contributor.link -->
			<xsl:variable name="link" select="detail[@id=256]"/>
			<xsl:if test="$link">
				<p>
					<xsl:call-template name="linkify">
						<xsl:with-param name="string" select="$link"/>
					</xsl:call-template>
				</p>
			</xsl:if>

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p>
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<xsl:if test="$entries">
				<div class="list-left-col list-entry" title="Entries"></div>
				<div class="list-right-col">
					<div class="list-right-col-browse">
						<ul>
							<xsl:for-each select="$entries">
								<xsl:sort select="detail[@id=160]"/>
								<li>
									<a href="{id}" class="preview-{id}">
										<xsl:value-of select="detail[@id=160]"/>
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</div>
				<div class="clearfix"/>
			</xsl:if>

			<xsl:if test="$images">
				<div class="list-left-col list-image" title="Pictures"></div>
				<div class="list-right-col">
					<div class="list-right-col-browse">
						<ul>
							<xsl:for-each select="$images">
								<xsl:sort select="detail[@id=160]"/>
								<li>
									<a href="{id}" class="preview-{id}">
										<xsl:value-of select="detail[@id=160]"/>
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</div>
				<div class="clearfix"/>
			</xsl:if>

			<xsl:if test="$audio">
				<div class="list-left-col list-audio" title="Sound"></div>
				<div class="list-right-col">
					<div class="list-right-col-browse">
						<ul>
							<xsl:for-each select="$audio">
								<xsl:sort select="detail[@id=160]"/>
								<li>
									<a href="{id}" class="preview-{id}">
										<xsl:value-of select="detail[@id=160]"/>
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</div>
				<div class="clearfix"/>
			</xsl:if>

			<xsl:if test="$video">
				<div class="list-left-col list-video" title="Video"></div>
				<div class="list-right-col">
					<div class="list-right-col-browse">
						<ul>
							<xsl:for-each select="$video">
								<xsl:sort select="detail[@id=160]"/>
								<li>
									<a href="{id}" class="preview-{id}">
										<xsl:value-of select="detail[@id=160]"/>
									</a>
								</li>
							</xsl:for-each>
						</ul>
					</div>
				</div>
				<div class="clearfix"/>
			</xsl:if>
		</div>

	</xsl:template>

</xsl:stylesheet>
