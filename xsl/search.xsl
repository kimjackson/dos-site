<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="browse.xsl"/>

	<xsl:template match="/">

		<html>
			<head>
				<title>Search</title>
				<link rel="icon" href="{$urlbase}images/favicon.ico" type="image/x-icon"/>
				<link rel="shortcut icon" href="{$urlbase}images/favicon.ico" type="image/x-icon"/>
				<link rel="stylesheet" href="{$urlbase}style.css" type="text/css"/>
				<link rel="stylesheet" href="{$urlbase}search.css" type="text/css"/>
				<script type="text/javascript">
					RelBrowser = {
						baseURL: "<xsl:value-of select="$urlbase"/>"
					};
				</script>
				<script src="/jquery/jquery.js" type="text/javascript"/>
				<script src="{$urlbase}js/cookies.js" type="text/javascript"/>
				<script src="{$urlbase}js/fontsize.js" type="text/javascript"/>
				<script src="{$urlbase}js/history.js" type="text/javascript"/>
				<script src="{$urlbase}js/search.js" type="text/javascript"/>
				<script src="{$urlbase}js/tooltip.js" type="text/javascript"/>
			</head>

			<body>
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

							<div id="heading" class="title-search">
								<h1>Search</h1>
							</div>

							<xsl:comment>ZOOM_SHOW_SUMMARY</xsl:comment>
							<xsl:comment>ZOOM_SHOW_HEADING</xsl:comment>
							<xsl:comment>ZOOM_SHOW_SUGGESTION</xsl:comment>
							<xsl:comment>ZOOM_SHOW_RECOMMENDED</xsl:comment>
							<xsl:comment>ZOOM_SHOW_RESULTS</xsl:comment>
							<xsl:comment>ZOOM_SHOW_PAGENUMBERS</xsl:comment>

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

						<!-- sidebar -->
						<xsl:call-template name="makeBrowseMenu"/>

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

			<div id="previews"/>

			</body>
		</html>
	</xsl:template>



</xsl:stylesheet>
