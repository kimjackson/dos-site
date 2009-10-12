<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="framework.xsl"/>
	<xsl:include href="util.xsl"/>

	<xsl:include href="factoid.xsl"/>
	<xsl:include href="media.xsl"/>
	<xsl:include href="hi_res_image.xsl"/>
	<xsl:include href="entry.xsl"/>
	<xsl:include href="annotation.xsl"/>
	<xsl:include href="entity.xsl"/>
	<xsl:include href="role.xsl"/>
	<xsl:include href="map.xsl"/>
	<xsl:include href="term.xsl"/>
	<xsl:include href="contributor.xsl"/>
	<xsl:include href="previews.xsl"/>

	<xsl:template match="/">
		<xsl:call-template name="framework">
			<xsl:with-param name="title" select="export/references/reference/detail[@id=160]"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="extraCSS">
		<link rel="stylesheet" href="{$urlbase}thickbox.css" type="text/css" media="screen"/>
	</xsl:template>

	<xsl:template name="extraScripts"/>

	<xsl:template name="content">
		<xsl:call-template name="makeTitleDiv">
			<xsl:with-param name="record" select="export/references/reference[1]"/>
		</xsl:call-template>
		<xsl:apply-templates select="export/references/reference"/>
	</xsl:template>


	<xsl:template name="sidebar">
		<xsl:apply-templates select="export/references/reference" mode="sidebar"/>
	</xsl:template>


	<xsl:template match="reference" mode="sidebar"/>


	<xsl:template name="connections">
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Entries</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=98]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Pictures</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=74][starts-with(detail[@id=289], 'image')]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Sound</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'audio')]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Video</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'video')]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Maps</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=103]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Subjects</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=152]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">Mentioned in</xsl:with-param>
			<xsl:with-param name="items" select="reverse-pointer[@id=199][reftype/@id=99]"/>
		</xsl:call-template>
		<xsl:call-template name="relatedItems">
			<xsl:with-param name="label">External links</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='hasExternalLink'][reftype/@id=1]"/>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="relatedItems">
		<xsl:param name="label"/>
		<xsl:param name="items"/>

		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$items[1]"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test="count($items) > 0">
			<div class="menu">
				<h4 class="menu-{$type}"><xsl:value-of select="$label"/></h4>
			</div>
			<div class="submenu">
				<ul>
					<xsl:apply-templates select="$items[1]">
						<xsl:with-param name="matches" select="$items"/>
					</xsl:apply-templates>
				</ul>
			</div>
		</xsl:if>

	</xsl:template>


	<xsl:template match="related | pointer | reverse-pointer">
		<xsl:param name="matches"/>
		<!-- This template is to be called in the context of just one record,
		     with the whole list in the "matches" variable.  This gives the template
		     a chance to sort the list itself, while still allowing the magic of the
		     match parameter: the single apply-templates in the relatedItems template
		     above might call this template, or another, such as the one below,
		     depending on the items in question.
		-->
		<xsl:for-each select="$matches">
			<xsl:sort select="detail[@id=160]"/>

			<xsl:variable name="class">
				<xsl:if test="reftype/@id=74">
					<xsl:text>popup </xsl:text>
				</xsl:if>
				<xsl:text>preview-</xsl:text>
				<xsl:value-of select="id"/>
				<xsl:if test="local-name() = 'related'">
					<xsl:text>c</xsl:text>
					<xsl:value-of select="@id"/>
				</xsl:if>
			</xsl:variable>

			<xsl:variable name="href">
				<xsl:choose>
					<xsl:when test="reftype/@id=74 and starts-with(detail[@id=289], 'image')">
						<xsl:text>../popup/</xsl:text>
						<xsl:value-of select="id"/>
						<xsl:text>?width=878&amp;amp;height=578</xsl:text>
					</xsl:when>
					<xsl:when test="reftype/@id=74 and starts-with(detail[@id=289], 'audio')">
						<xsl:text>../popup/</xsl:text>
						<xsl:value-of select="id"/>
						<xsl:text>?height=436</xsl:text>
					</xsl:when>
					<xsl:when test="reftype/@id=74 and starts-with(detail[@id=289], 'video')">
						<xsl:text>../popup/</xsl:text>
						<xsl:value-of select="id"/>
						<xsl:text>?height=503</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="id"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<li>
				<a href="{$href}" class="{$class}">
					<xsl:choose>
						<xsl:when test="detail[@id=160]">
							<xsl:value-of select="detail[@id=160]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="title"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="related[reftype/@id=1]">
		<!-- external links: link to external link, new window, no preview -->
		<xsl:param name="matches"/>
		<xsl:for-each select="$matches">
			<xsl:sort select="detail[@id=160]"/>
			<li>
				<a href="{detail[@id=198]}" target="_blank">
					<xsl:choose>
						<xsl:when test="detail[@id=160]">
							<xsl:value-of select="detail[@id=160]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="title"/>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
