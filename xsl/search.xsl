<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title">Search</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS">
		<link rel="stylesheet" href="{$urlbase}search.css" type="text/css"/>
	</xsl:template>

	<xsl:template name="extraScripts">
		<script src="{$urlbase}js/search.js" type="text/javascript"/>
	</xsl:template>

	<xsl:template name="previewStubs"/>


	<xsl:template name="content">

		<div id="heading" class="title-search">
			<h1>Search</h1>
		</div>

		<xsl:comment>ZOOM_SHOW_SUMMARY</xsl:comment>
		<xsl:comment>ZOOM_SHOW_HEADING</xsl:comment>
		<xsl:comment>ZOOM_SHOW_SUGGESTION</xsl:comment>
		<xsl:comment>ZOOM_SHOW_RECOMMENDED</xsl:comment>
		<xsl:comment>ZOOM_SHOW_RESULTS</xsl:comment>
		<xsl:comment>ZOOM_SHOW_PAGENUMBERS</xsl:comment>

	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:call-template name="makeBrowseMenu"/>
	</xsl:template>


</xsl:stylesheet>
