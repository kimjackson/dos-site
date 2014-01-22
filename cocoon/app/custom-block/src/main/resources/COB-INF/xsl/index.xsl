<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:param name="target1"/>
	<xsl:param name="target2"/>
	<xsl:param name="target3"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Dictionary of Sydney</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS"/>
	<xsl:template name="extraScripts"/>
	<xsl:template name="previewStubs"/>

	<xsl:template name="content">

		<div id="home-heading">
			<div id="browser"/>
			<script type="text/javascript">
				$(function () { DOS.Media.embedBrowser("browser"); });
			</script>
			<h1>The Dictionary of Sydney - Sydney's history online and connected</h1>
		</div>

		<div class="teaser">
			<a href="about.html">
			</a>
		</div>

		<div class="teaser">
			<a href="item/{$target1}">
				<img>
					<xsl:attribute name="src">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="data/hml[2]/records/record/detail[@id=221]"/>
							<xsl:with-param name="size" select="'thumbnail'"/>
						</xsl:call-template>
					</xsl:attribute>
				</img>
			</a>
		</div>

		<div class="teaser">
			<a href="item/{$target2}">
				<img>
					<xsl:attribute name="src">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="data/hml[4]/records/record/detail[@id=221]"/>
							<xsl:with-param name="size" select="'thumbnail'"/>
						</xsl:call-template>
					</xsl:attribute>
				</img>
			</a>
		</div>

		<div class="teaser teaser-end">
			<a href="item/{$target3}">
				<img>
					<xsl:attribute name="src">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="data/hml[6]/records/record/detail[@id=221]"/>
							<xsl:with-param name="size" select="'thumbnail'"/>
						</xsl:call-template>
					</xsl:attribute>
				</img>
			</a>
		</div>
		<div class="clearfix"/>

		<div class="teaser">
			<h2>About us</h2>
			<p>Find out more about this growing online history project and the partners and supporters who make it possible.</p>
		</div>

		<div class="teaser">
			<h2>Sydney suburbs</h2>
			<p><xsl:value-of select="data/hml[1]/records/record/detail[@id=191]"/></p>
		</div>

		<div class="teaser">
			<h2>Sydney people</h2>
			<p><xsl:value-of select="data/hml[3]/records/record/detail[@id=191]"/></p>
		</div>

		<div class="teaser teaser-end">
			<h2>Sydney cultures</h2>
			<p><xsl:value-of select="data/hml[5]/records/record/detail[@id=191]"/></p>
		</div>
		<div class="clearfix"/>

		<div class="teaser">
			<a href="about.html">more &#187;</a>
		</div>
		<div class="teaser">
			<a href="item/{$target1}">more &#187;</a>
		</div>
		<div class="teaser">
			<a href="item/{$target2}">more &#187;</a>
		</div>
		<div class="teaser teaser-end">
			<a href="item/{$target3}">more &#187;</a>
		</div>
		<div class="clearfix"/>

	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
