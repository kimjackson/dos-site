<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<!--FIXME: this should be factored a bit -->
	<xsl:template match="/">

		<xsl:variable name="record" select="hml/records/record"/>

		<xsl:apply-templates select="$record">
			<xsl:with-param name="type">
				<xsl:call-template name="getRecordTypeClassName">
					<xsl:with-param name="record" select="$record"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:apply-templates>

	</xsl:template>


	<xsl:template match="record[type/@id=74] |
	                     record[type/@id=168][detail[@id=618] = 'image']">
		<xsl:param name="type"/>

		<div class="picbox-container">

			<div class="picbox-close">
				<a href="#" onclick="Boxy.get(this).hide(); return false;">[close]</a>
			</div>
			<div class="clearfix"/>

			<xsl:if test="starts-with(detail[@id=289], 'image') or type/@id = 168">
				<div class="picbox-image">
					<img>
						<xsl:attribute name="src">
							<xsl:call-template name="getFileURL">
								<xsl:with-param name="file" select="detail[@id=221]"/>
								<xsl:with-param name="size" select="'wide'"/>
							</xsl:call-template>
						</xsl:attribute>
					</img>
				</div>
			</xsl:if>

			<div class="picbox-heading balloon-{$type}">
				<h2><xsl:value-of select="detail[@id=160]"/></h2>
			</div>

			<div class="picbox-content">

				<xsl:if test="starts-with(detail[@id=289], 'audio') or starts-with(detail[@id=289], 'video')">

					<xsl:variable name="elem">
						<xsl:choose>
							<xsl:when test="starts-with(detail[@id=289], 'audio')">
								<xsl:text>audio</xsl:text>
							</xsl:when>
							<xsl:when test="starts-with(detail[@id=289], 'video')">
								<xsl:text>video</xsl:text>
							</xsl:when>
						</xsl:choose>
					</xsl:variable>

					<div class="picbox-flash">
						<div id="{$elem}">
							<a>
								<xsl:attribute name="href">
									<xsl:call-template name="getFileURL">
										<xsl:with-param name="file" select="detail[@id=221]"/>
									</xsl:call-template>
								</xsl:attribute>
							</a>
						</div>
					</div>
				</xsl:if>

				<xsl:if test="detail[@id=191]">
					<p>
						<xsl:value-of select="detail[@id=191]"/>
					</p>
				</xsl:if>
				<p class="attribution">
					<xsl:call-template name="makeMediaAttributionStatement">
						<xsl:with-param name="record" select="."/>
					</xsl:call-template>
				</p>
				<p>
					<xsl:if test="type/@id = 168">
						<xsl:text>This is a high-resolution image - to view in more detail, go to the </xsl:text>
					</xsl:if>
					<a href="{id}">full record &#187;</a>
				</p>
				<div class="clearfix"></div>
			</div>
		</div>
	</xsl:template>


</xsl:stylesheet>
