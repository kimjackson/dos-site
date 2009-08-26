<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<!--FIXME: this should be factored a bit -->
	<xsl:template match="/">

		<xsl:variable name="record" select="export/references/reference"/>

		<xsl:apply-templates select="$record">
			<xsl:with-param name="type">
				<xsl:call-template name="getRecordTypeClassName">
					<xsl:with-param name="record" select="$record"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:apply-templates>

	</xsl:template>


	<xsl:template match="reference[reftype/@id=74][starts-with(detail[@id=289], 'image')]">
		<xsl:param name="type"/>

		<div class="picbox-container">
			<div class="picbox-top"/>
			<div class="picbox-middle">
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
				<div class="picbox-heading balloon-{$type}">
					<h2><xsl:value-of select="detail[@id=160]"/></h2>
				</div>
				<div class="picbox-content">
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
						<a href="{id}">full record &#187;</a>
					</p>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="picbox-bottom"/>
		</div>
	</xsl:template>


	<xsl:template match="reference[reftype/@id=74][starts-with(detail[@id=289], 'audio')]">
		<xsl:param name="type"/>

		<div class="balloon-container">
			<div class="balloon-top"/>
			<div class="balloon-middle">
				<div class="balloon-heading balloon-{$type}">
					<h2><xsl:value-of select="detail[@id=160]"/></h2>
				</div>
				<div class="balloon-content">
					<div class="balloon-flash">
						<div id="media"></div>
						<script type="text/javascript">
							DOS.Media.playAudio(
								"<xsl:call-template name="getFileURL">
									<xsl:with-param name="file" select="detail[@id=221]"/>
								</xsl:call-template>"
							);
						</script>
					</div>
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
						<a href="{id}">full record &#187;</a>
					</p>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="balloon-bottom"/>
		</div>
	</xsl:template>


	<xsl:template match="reference[reftype/@id=74][starts-with(detail[@id=289], 'video')]">
		<xsl:param name="type"/>

		<div class="video-container">
			<div class="video-top"/>
			<div class="video-middle">
				<div class="video-heading balloon-{$type}">
					<h2><xsl:value-of select="detail[@id=160]"/></h2>
				</div>
				<div class="video-content">
					<div class="balloon-flash">
						<div id="media"></div>
						<script type="text/javascript">
							DOS.Media.playVideo(
								"<xsl:call-template name="getFileURL">
									<xsl:with-param name="file" select="detail[@id=221]"/>
								</xsl:call-template>"
							);
						</script>
					</div>
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
						<a href="{id}">full record &#187;</a>
					</p>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="video-bottom"/>
		</div>
	</xsl:template>


</xsl:stylesheet>
