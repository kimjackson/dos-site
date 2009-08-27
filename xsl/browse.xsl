<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>
	<xsl:include href="factoid.xsl"/>

	<xsl:param name="type"/>

	<xsl:template match="/">

		<xsl:variable name="pluralTypeName">
			<xsl:choose>
				<xsl:when test="$type = 'entries'">Entries</xsl:when>
				<xsl:when test="$type = 'maps'">Maps</xsl:when>
				<xsl:when test="$type = 'subjects'">Subjects</xsl:when>
				<xsl:when test="$type = 'roles'">Roles</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="getEntityPluralName">
						<xsl:with-param name="codeName" select="$type"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="typeCodeName">
			<xsl:choose>
				<xsl:when test="$type = 'entries'">entry</xsl:when>
				<xsl:when test="$type = 'maps'">map</xsl:when>
				<xsl:when test="$type = 'subjects'">term</xsl:when>
				<xsl:when test="$type = 'roles'">role</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="getEntityCodeName">
						<xsl:with-param name="typeName" select="$type"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<html>
			<head>
				<title>Browse - <xsl:value-of select="$pluralTypeName"/></title>
				<link href="{$urlbase}style.css" rel="stylesheet" type="text/css" />
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
				<script src="{$urlbase}js/browse.js" type="text/javascript"/>
				<script src="{$urlbase}browse/{$type}.js" type="text/javascript"/>
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

							<div id="heading" class="title-search">
								<h1>
									Browse <xsl:value-of select="$pluralTypeName"/>
								</h1>
								<span id="sub-title">
									Sort by
									<a id="name-sort-link" href="#">Name</a>
									or
									<a id="type-sort-link" href="#">Type</a>
								</span>
							</div>

							<ul id="browse-alpha-index"/>
							<ul id="browse-type-index"/>

							<div class="list-left-col list-{$typeCodeName}"/>
							<div class="list-right-col">
								<div class="list-right-col-browse" id="entities-alpha"/>
								<div class="list-right-col-browse" id="entities-type"/>
							</div>

						</div>
					</div>

					<div id="right-col">
						<img src="{$urlbase}images/img-logo.jpg" alt="Dictionary of Sydney" width="198" height="125" class="logo"/>
						<div id="search-bar">
							<form method="get" action="{$urlbase}search/search.cgi">
								<input type="text" name="zoom_query" id="search" size="20" maxlength="40"/>
								<div id="search-submit"/>
							</form>
						</div>

						<!-- sidebar -->
						<div id="browse-connections">
							<h3>Browse</h3>
							<ul id="menu">
								<xsl:call-template name="makeEntityBrowseList"/>
								<li class="browse-entry"><a href="entries">Entries</a></li>
								<li class="browse-map"><a href="maps">Maps</a></li>
								<li class="browse-term"><a href="subjects">Subjects</a></li>
								<li class="browse-role"><a href="roles">Roles</a></li>
							</ul>
						</div>

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

			</body>
		</html>
	</xsl:template>



</xsl:stylesheet>
