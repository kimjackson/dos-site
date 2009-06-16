<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                version="1.0">

	<xsl:param name="id"/>

	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>

	<xsl:include href="factoid.xsl"/>
	<xsl:include href="media.xsl"/>
	<xsl:include href="teidoc.xsl"/>
	<xsl:include href="teidoc_reference.xsl"/>
	<xsl:include href="entity.xsl"/>
	<xsl:include href="role.xsl"/>
	<xsl:include href="map.xsl"/>

	<xsl:template match="/">

		<html>
			<head>
				<title>
					<xsl:value-of select="export/references/reference/title"/>
				</title>
				<link href="{$urlbase}style.css" rel="stylesheet" type="text/css" />
				<link href="{$urlbase}tei.css" rel="stylesheet" type="text/css" />
				<script src="http://hapi.heuristscholar.org/load?instance={$instance}&amp;key={$hapi-key}"></script>
				<script src="{$urlbase}js/search.js"/>
				<xsl:if test="/export/references/reference[reftype/@id=103]  |
				              /export/references/reference[reftype/@id=151][reverse-pointer[reftype/@id=150]/detail[@id=230 or @id=177]]">
					<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
					<script>
						Timeline_urlPrefix = "<xsl:value-of select="$urlbase"/>timeline/timeline_js/";
						Timeline_ajax_url = "<xsl:value-of select="$urlbase"/>timeline/timeline_ajax/simile-ajax-api.js";
						Timeline_parameters = "bundle=true";
					</script>
					<script src="{$urlbase}timeline/timeline_js/timeline-api.js" type="text/javascript"></script>
					<script src="{$urlbase}timemap.js/timemap.js" type="text/javascript"></script>
					<script src="{$urlbase}timemap.js/kmlparser.js" type="text/javascript"></script>
					<script src="{$urlbase}timemap.js/manipulation.js" type="text/javascript"></script>
					<script src="{$urlbase}js/mapping.js"></script>
				</xsl:if>
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
								<xsl:call-template name="makeTitleDiv">
									<xsl:with-param name="record" select="export/references/reference[1]"/>
								</xsl:call-template>
							</div>

							<xsl:apply-templates select="export/references/reference"/>

						</div>
					</div>

					<div id="right-col">
						<img src="{$urlbase}images/img-logo.jpg" alt="Dictionary of Sydney" width="198" height="125" class="logo"/>
						<div id="search-bar">
							<form method="post" onsubmit="top.search(document.getElementById('search').value); return false;">
								<input type="text" name="search" id="search" value="search..." size="20" maxlength="40"/>
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


	<xsl:template match="reference" mode="sidebar"/>


	<xsl:template name="connections">
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Pictures</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'image')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Sound</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'audio')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Video</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=74][starts-with(detail[@id=289], 'video')]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Maps</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='IsRelatedTo'][reftype/@id=103]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Subjects</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=152]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Mentioned in</xsl:with-param>
			<xsl:with-param name="items" select="reverse-pointer[@id=199][reftype/@id=99]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">External links</xsl:with-param>
			<xsl:with-param name="items" select="related[@type='hasExternalLink'][reftype/@id=1]"/>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="related_items">
		<xsl:param name="label"/>
		<xsl:param name="items"/>

		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$items[1]"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test="count($items) > 0">
			<li class="menu-{$type}">
				<a class="parent" href="#"><xsl:value-of select="$label"/></a>
				<ul>
					<xsl:apply-templates select="$items[1]">
						<xsl:with-param name="matches" select="$items"/>
					</xsl:apply-templates>
				</ul>
			</li>
		</xsl:if>

	</xsl:template>



	<xsl:template match="related | pointer | reverse-pointer">
		<xsl:param name="matches"/>
		<!-- trickiness!
		     First off, this template will catch a single related (/ pointer / reverse-pointer) record,
		     with the full list as a parameter ("matches").  This gives the template a chance to sort the records
		     and call itself with those sorted records
		-->
		<xsl:choose>
			<xsl:when test="$matches">
				<xsl:apply-templates select="$matches">
					<xsl:sort select="detail[@id=160]"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<a href="{id}">
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
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
