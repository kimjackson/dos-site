<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:variable name="urlbase"/>
	<xsl:variable name="fullurlbase"/>

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
		</div>

		<div class="clearfix"/>

		<div>
			<h2>Click one of the images above or the links on the side</h2>
			<h2>or Search to enter the Dictionary</h2>
		</div>

		<div class="clearfix"/>


	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu">
			<xsl:with-param name="base" select="''"/>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>
