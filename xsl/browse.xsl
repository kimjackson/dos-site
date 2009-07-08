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
				<script src="/jquery/jquery.js" type="text/javascript"/>
				<script src="{$urlbase}js/browse.js" type="text/javascript"/>
				<script src="{$urlbase}deploy/browse/{$type}.js" type="text/javascript"/>
			</head>

			<body>
			<div id="header"></div>
			<div id="subheader">
				<div id="subheader-content">
					<a class="browse" href="{$urlbase}"></a>
					<!--ul id="navigation">
						<li class="nav-search"><a href="#">search</a></li>
						<li class="nav-entry"><a href="#">entry</a></li>
						<li class="nav-contributor"><a href="#">contributor</a></li>
						<li class="nav-building"><a href="#">building</a></li>
						<li class="nav-artifact"><a href="#">artifact</a></li>
						<li class="nav-entry2"><a href="#">entry2</a></li>
						<li class="nav-video"><a href="#">video</a></li>
						<li class="nav-term"><a href="#">term</a></li>
						<li class="nav-structure"><a href="#">structure</a></li>
						<li class="nav-sound"><a href="#">sound</a></li>
						<li class="nav-role"><a href="#">role</a></li>
						<li class="nav-reference"><a href="#">reference</a></li>
						<li class="nav-place"><a href="#">place</a></li>
						<li class="nav-people"><a href="#">people</a></li>
						<li class="nav-map"><a href="#">map</a></li>
						<li class="nav-organisation"><a href="#">organisation</a></li>
						<li class="nav-image"><a href="#">image</a></li>
						<li class="nav-natural"><a href="#">natural</a></li>
						<li class="nav-link"><a href="#">link</a></li>
					</ul-->
				</div>
			</div>

			<div id="middle">
				<div id="container">

					<div id="left-col">
						<div id="content">

							<div id="heading">
								<div id="title">
									<h1 class="title-search">
										Browse <xsl:value-of select="$pluralTypeName"/>
									</h1>
								</div>
								<span id="sub-title">
									Sort by
									<a id="name-sort-link" href="#">Name</a>
									or
									<a id="type-sort-link" href="#">Type</a>
								</span>

							</div>

							<ul id="browse-alpha-index"/>
							<ul id="browse-type-index"/>

							<div class="list-left-col list-{$type}"/>
							<div class="list-right-col">
								<div class="list-right-col-browse" id="entities-alpha"/>
								<div class="list-right-col-browse" id="entities-type"/>
							</div>

						</div>
					</div>

					<div id="right-col">
						<img src="{$urlbase}images/img-logo.jpg" alt="Dictionary of Sydney" width="198" height="125" class="logo"/>
						<div id="search-bar">
							<form method="post" onsubmit="top.search(document.getElementById('search').value); return false;">
								<input type="text" name="search" id="search" value="search..." size="20" maxlength="40"/>
							</form>
						</div>

						<!-- sidebar -->
						<div id="browse-connections">
							<h3>Connections</h3>
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
						<li><a href="#">Font - +</a></li>
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
