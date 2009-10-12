<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="framework">
		<xsl:param name="title"/>

		<html>
			<head>
				<title><xsl:value-of select="$title"/></title>
				<xsl:call-template name="makeMetaTags"/>
				<link rel="icon" href="{$urlbase}images/favicon.ico" type="image/x-icon"/>
				<link rel="shortcut icon" href="{$urlbase}images/favicon.ico" type="image/x-icon"/>
				<link rel="stylesheet" href="{$urlbase}style.css" type="text/css"/>
				<xsl:call-template name="extraCSS"/>
				<script type="text/javascript">
					RelBrowser = {
						baseURL: "<xsl:value-of select="$urlbase"/>",
						pipelineBaseURL: "../"
					};
					var tb_pathToImage = RelBrowser.baseURL + "images/loadingAnimation.gif";
				</script>
				<script src="/jquery/jquery.js" type="text/javascript"/>
				<script src="{$urlbase}js/cookies.js" type="text/javascript"/>
				<script src="{$urlbase}js/fontsize.js" type="text/javascript"/>
				<script src="{$urlbase}js/history.js" type="text/javascript"/>
				<script src="{$urlbase}js/search.js" type="text/javascript"/>
				<script src="{$urlbase}js/menu.js" type="text/javascript"/>
				<xsl:call-template name="extraScripts"/>
				<script src="{$urlbase}js/tooltip.js" type="text/javascript"/>
				<script src="{$urlbase}js/thickbox.js" type="text/javascript"/>
				<script src="{$urlbase}js/swfobject.js" type="text/javascript"/>
				<script src="{$urlbase}js/media.js" type="text/javascript"/>

				<xsl:if test="/export/references/reference[
				                  reftype/@id=103  or
				                  reftype/@id=168  or
				                  reftype/@id=151  and  reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]]">
					<script src="http://maps.google.com/maps?file=api&amp;amp;v=2&amp;amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w" type="text/javascript"/>
				</xsl:if>

				<xsl:if test="/export/references/reference[reftype/@id=103]  |
				              /export/references/reference[reftype/@id=151][reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]]">
					<script type="text/javascript">
						var Timeline_urlPrefix = RelBrowser.baseURL + "timeline/timeline_js/";
						var Timeline_ajax_url = RelBrowser.baseURL + "timeline/timeline_ajax/simile-ajax-api.js";
						var Timeline_parameters = "bundle=true";
					</script>
					<script src="{$urlbase}timeline/timeline_js/timeline-api.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/timemap.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/loaders/kml.js" type="text/javascript"/>
					<script src="{$urlbase}timemap.js/manipulation.js" type="text/javascript"/>
					<script src="{$urlbase}js/mapping.js" type="text/javascript"/>
				</xsl:if>

				<xsl:if test="/export/references/reference[reftype/@id=168][detail[@id=618] = 'image']">
					<script src="{$urlbase}js/gmapimage.js" type="text/javascript"/>
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
					<div id="breadcrumbs"/>
				</div>
			</div>

			<div id="middle">
				<div id="container">

					<div id="left-col">
						<div id="content">

							<xsl:call-template name="content"/>

						</div>
					</div>

					<div id="right-col">
						<a href="{$urlbase}" title="Dictionary of Sydney Home">
							<img src="{$urlbase}images/img-logo.jpg" alt="Dictionary of Sydney" width="198" height="125" class="logo"/>
						</a>
						<div id="search-bar">
							<form method="get" action="{$urlbase}search/search.cgi">
								<input type="text" name="zoom_query" id="search" size="20"/>
								<div id="search-submit"/>
							</form>
						</div>

						<xsl:call-template name="sidebar"/>

					</div>

					<div class="clearfix"/>
					<div id="container-bottom"/>

				</div>
			</div>

			<div id="footer">
				<div id="footer-content">
					<ul id="footer-left-col">
						<li class="no-bullet"><a href="#">Home</a></li>
						<li><a href="{$urlbase}about.html">About</a></li>
						<li><a href="{$urlbase}copyright.html">Copyright</a></li>
						<li><a href="{$urlbase}faq.html">FAQ</a></li>
						<li><a href="{$urlbase}contact.html">Contact</a></li>
						<li>
							<a href="#" class="increasefont" title="Increase font size">Font +</a>
							<xsl:text> </xsl:text>
							<a href="#" class="decreasefont" title="Decrease font size">-</a>
						</li>
					</ul>
					<ul id="footer-right-col">
						<li class="no-bullet"><a href="{$urlbase}contribute.html">Contribute</a></li>
						<!-- AddThis Button BEGIN -->
						<li><a href="http://www.addthis.com/bookmark.php?v=250&amp;amp;pub=xa-4ad2828856394955" class="addthis_button">Share</a></li>
						<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pub=xa-4ad2828856394955"></script>
						<script>
							var addthis_config = {
								services_exclude: 'myaol'
							}
						</script>
						<!-- AddThis Button END -->

					</ul>
				</div>
			</div>

			<div id="previews">
				<xsl:call-template name="previewStubs"/>
			</div>

			</body>
		</html>
	</xsl:template>


</xsl:stylesheet>
