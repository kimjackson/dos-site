<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>

	<xsl:include href="factoid.xsl"/>
	<xsl:include href="media.xsl"/>
	<xsl:include href="entry.xsl"/>
	<xsl:include href="annotation.xsl"/>
	<xsl:include href="entity.xsl"/>
	<xsl:include href="role.xsl"/>
	<xsl:include href="map.xsl"/>
	<xsl:include href="term.xsl"/>
	<xsl:include href="contributor.xsl"/>
	<xsl:include href="previews.xsl"/>

	<xsl:template match="/">

		<html>
			<head>
				<xsl:call-template name="makeMetaTags"/>
				<title><xsl:value-of select="export/references/reference/detail[@id=160]"/></title>
				<link href="{$urlbase}style.css" rel="stylesheet" type="text/css"/>
				<link href="{$urlbase}thickbox.css" rel="stylesheet" type="text/css" media="screen"/>
				<script type="text/javascript">
					RelBrowser = {
						baseURL: "<xsl:value-of select="$urlbase"/>"
					};
					var tb_pathToImage = RelBrowser.baseURL + "images/loadingAnimation.gif";
				</script>
				<script src="http://hapi.heuristscholar.org/load?instance={$instance}&amp;amp;key={$hapi-key}" type="text/javascript"/>
				<script src="/jquery/jquery.js" type="text/javascript"/>
				<script src="{$urlbase}js/cookies.js" type="text/javascript"/>
				<script src="{$urlbase}js/fontsize.js" type="text/javascript"/>
				<script src="{$urlbase}js/history.js" type="text/javascript"/>
				<script src="{$urlbase}js/search.js" type="text/javascript"/>
				<script src="{$urlbase}js/menu.js" type="text/javascript"/>
				<script src="{$urlbase}js/tooltip.js" type="text/javascript"/>
				<script src="{$urlbase}js/thickbox.js" type="text/javascript"/>
				<script src="{$urlbase}js/swfobject.js" type="text/javascript"/>
				<script src="{$urlbase}js/media.js" type="text/javascript"/>

				<xsl:if test="/export/references/reference[reftype/@id=103]  |
				              /export/references/reference[reftype/@id=151][reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]]">
					<script type="text/javascript">
						var Timeline_urlPrefix = RelBrowser.baseURL + "timeline/timeline_js/";
						var Timeline_ajax_url = RelBrowser.baseURL + "timeline/timeline_ajax/simile-ajax-api.js";
						var Timeline_parameters = "bundle=true";
					</script>
					<script src="http://maps.google.com/maps?file=api&amp;amp;v=2&amp;amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w" type="text/javascript"/>
					<script src="{$urlbase}timeline/timeline_js/timeline-api.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/timemap.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/loaders/kml.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/manipulation.js" type="text/javascript"/>
					<script src="{$urlbase}js/mapping.js" type="text/javascript"/>
				</xsl:if>

				<xsl:if test="/export/references/reference/reftype/@id = 98">
					<script src="http://yui.yahooapis.com/2.7.0/build/yahoo/yahoo-min.js" type="text/javascript"/>
					<script src="http://yui.yahooapis.com/2.7.0/build/event/event-min.js" type="text/javascript"/>
					<script src="http://yui.yahooapis.com/2.7.0/build/history/history-min.js" type="text/javascript"/>
					<script src="{$urlbase}js/highlight.js" type="text/javascript"/>
				</xsl:if>
			</head>


			<body>
			<xsl:if test="/export/references/reference/reftype/@id = 98">
				<iframe id="yui-history-iframe" src="{$urlbase}images/minus.png"/>
				<input id="yui-history-field" type="hidden"/>
			</xsl:if>
			<div id="header"></div>
			<div id="subheader">
				<div id="navigation">
					<a class="browse" href="{$urlbase}"></a>
					<div id="breadcrumbs"/>
				</div>
			</div>

			<div id="middle">
				<div id="container">

					<div id="left-col">
						<div id="content">

							<xsl:call-template name="makeTitleDiv">
								<xsl:with-param name="record" select="export/references/reference[1]"/>
							</xsl:call-template>

							<xsl:apply-templates select="export/references/reference"/>

						</div>
					</div>

					<div id="right-col">
						<a href="{$urlbase}" title="Dictionary of Sydney Home">
							<img src="{$urlbase}images/img-logo.jpg" alt="Dictionary of Sydney" width="198" height="125" class="logo"/>
						</a>
						<div id="search-bar">
							<form method="post" action=".">
								<input type="text" name="search" id="search" size="20" maxlength="40"/>
								<div id="search-submit"/>
							</form>
						</div>

						<xsl:apply-templates select="export/references/reference" mode="sidebar"/>

					</div>

					<div class="clearfix"/>
					<div id="container-bottom"/>

				</div>
			</div>

			<div id="footer">
				<div id="footer-content">
					<ul id="footer-left-col">
						<li class="no-bullet"><a href="#">Home</a></li>
						<li><a href="#">About</a></li>
						<li><a href="#">Copyright</a></li>
						<li><a href="#">RSS</a></li>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">Browse</a></li>
						<li><a href="#">Contact</a></li>
						<li>
							<a href="#" class="increasefont" title="Increase font size">Font +</a>
							<xsl:text> </xsl:text>
							<a href="#" class="decreasefont" title="Decrease font size">-</a>
						</li>
					</ul>
					<ul id="footer-right-col">
						<li class="no-bullet"><a href="#">Print</a></li>
						<li><a href="#">Contribute</a></li>
						<li><a href="#">Share</a></li>
					</ul>
				</div>
			</div>

			<div id="previews">
				<xsl:call-template name="previewStubs"/>
			</div>

			</body>
		</html>
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
						<xsl:text>?width=878&amp;amp;height=566</xsl:text>
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
