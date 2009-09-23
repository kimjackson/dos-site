<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>
	<xsl:include href="browse.xsl"/>

	<xsl:param name="target1"/>
	<xsl:param name="target2"/>
	<xsl:param name="target3"/>
	<xsl:param name="target4"/>

	<xsl:template match="/">

		<html>
			<head>
				<title>Dictionary of Sydney</title>
				<link href="{$urlbase}style.css" rel="stylesheet" type="text/css" />
				<link href="{$urlbase}search.css" rel="stylesheet" type="text/css" />
				<script type="text/javascript">
					RelBrowser = {
						baseURL: "<xsl:value-of select="$urlbase"/>",
						pipelineBaseURL: ""
					};
				</script>
				<script src="/jquery/jquery.js" type="text/javascript"/>
				<script src="{$urlbase}js/cookies.js" type="text/javascript"/>
				<script src="{$urlbase}js/fontsize.js" type="text/javascript"/>
				<script src="{$urlbase}js/history.js" type="text/javascript"/>
				<script src="{$urlbase}js/search.js" type="text/javascript"/>
				<script src="{$urlbase}js/tooltip.js" type="text/javascript"/>
				<script src="{$urlbase}js/swfobject.js" type="text/javascript"/>
				<script src="{$urlbase}js/media.js" type="text/javascript"/>
			</head>

			<body>
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

							<div id="home-heading">
								<div id="browser"/>
								<script type="text/javascript">
									$(function () { DOS.Media.embedBrowser("browser"); });
								</script>
								<h1>Welcome to the Dictionary of Sydney</h1>
							</div>

							<div class="teaser">
								<a href="item/{$target1}">
									<img>
										<xsl:attribute name="src">
											<xsl:call-template name="getFileURL">
												<xsl:with-param name="file" select="data/export[2]/references/reference/detail[@id=221]"/>
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
												<xsl:with-param name="file" select="data/export[4]/references/reference/detail[@id=221]"/>
												<xsl:with-param name="size" select="'thumbnail'"/>
											</xsl:call-template>
										</xsl:attribute>
									</img>
								</a>
							</div>

							<div class="teaser">
								<a href="item/{$target3}">
									<img>
										<xsl:attribute name="src">
											<xsl:call-template name="getFileURL">
												<xsl:with-param name="file" select="data/export[6]/references/reference/detail[@id=221]"/>
												<xsl:with-param name="size" select="'thumbnail'"/>
											</xsl:call-template>
										</xsl:attribute>
									</img>
								</a>
							</div>

							<div class="teaser teaser-end">
								<a href="item/{$target4}">
									<img>
										<xsl:attribute name="src">
											<xsl:call-template name="getFileURL">
												<xsl:with-param name="file" select="data/export[8]/references/reference/detail[@id=221]"/>
												<xsl:with-param name="size" select="'thumbnail'"/>
											</xsl:call-template>
										</xsl:attribute>
									</img>
								</a>
							</div>

							<div class="teaser">
								<h2>Featured article</h2>
								<p><xsl:value-of select="data/export[1]/references/reference/detail[@id=191]"/></p>
							</div>

							<div class="teaser">
								<h2>Sydney suburbs</h2>
								<p><xsl:value-of select="data/export[3]/references/reference/detail[@id=191]"/></p>
							</div>

							<div class="teaser">
								<h2>Sydney people</h2>
								<p><xsl:value-of select="data/export[5]/references/reference/detail[@id=191]"/></p>
							</div>

							<div class="teaser teaser-end">
								<h2>Sydney cultures</h2>
								<p><xsl:value-of select="data/export[7]/references/reference/detail[@id=191]"/></p>
							</div>

							<div class="teaser">
								<a href="item/{$target1}">more &#187;</a>
							</div>
							<div class="teaser">
								<a href="item/{$target2}">more &#187;</a>
							</div>
							<div class="teaser">
								<a href="item/{$target3}">more &#187;</a>
							</div>
							<div class="teaser teaser-end">
								<a href="item/{$target4}">more &#187;</a>
							</div>

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
						<xsl:call-template name="makeBrowseMenu">
							<xsl:with-param name="base" select="''"/>
						</xsl:call-template>

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
