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
	<xsl:include href="kml-timeline.xsl"/>

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
				<xsl:if test="/export/references/reference/reftype[@id=103 or @id=151]">
					<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
				</xsl:if>
				<xsl:if test="/export/references/reference/reftype[@id=103]">
					<script src="http://simile.mit.edu/timeline/api/timeline-api.js"></script>
					<script src="http://heuristscholar.org/{$urlbase}timemap.1.3/timemap.js"></script>
				</xsl:if>
			</head>


			<body>
			<div id="container">
				<div id="header">
					<div class="logo"><a href="{$urlbase}"><img src="{$urlbase}images/dictionary-of-sydney.jpg" width="148" height="97" /></a></div>
					<div class="search"><h1>SEARCH</h1></div>
					<form method="post" onsubmit="top.search(document.getElementById('search').value); return false;">
						<div class="search-box"><input type="text" name="search" id="search" /></div>
					</form>
					<div class="advanced-search">
						<ul>
							<li><a title="Coming soon" onclick="alert('Coming soon!'); return false;" href="#">Advanced</a></li>
						</ul>
					</div>
					<a href="#" class="left-arrow"><img src="{$urlbase}images/img-left-arrow.jpg" width="13" height="24" /></a>
					<a href="#" class="right-arrow"><img src="{$urlbase}images/img-right-arrow.jpg" width="13" height="24" /></a>
				</div>
				<div id="menu">
					<ul id="navigation">
						<li><a href="#">Place</a></li>
						<li><a href="#">Event</a></li>
						<li><a href="#">Image</a></li>
						<li><a href="#">Place</a></li>
						<li><a href="#">Search</a></li>
						<li><a href="#">Image</a></li>
						<li><a href="#">Event</a></li>
					</ul>
				</div>
				<div id="title" class="left-column">
					<xsl:call-template name="icon">
						<xsl:with-param name="record" select="export/references/reference"/>
						<xsl:with-param name="size" select="'big'"/>
					</xsl:call-template>
					<xsl:value-of select="export/references/reference[1]/title"/>
				</div>
				<div class="right-column">
					<div style="font-size: 16px; font-weight: bold; position: relative; top: 20px; left: 10px;">Connections</div>
				</div>
				<div id="middle">
					<div class="left-column">
						<div class="content-top"></div>
						<div class="content" id="content">

							<xsl:apply-templates select="export/references/reference"/>

						</div>
						<div class="content-bottom"></div>
					</div>
					<div class="right-column">

						<xsl:apply-templates select="export/references/reference" mode="sidebar"/>

					</div>
					<div class="clear"></div>
				</div>

				<div id="footer">
					<div class="copyright">&#169; 2009 Dictionary of Sydney</div>
					<div id="footer-navigation" class="footer-nav">
						<ul>
							<li><a href="#">Index</a></li>
							<li><a href="#">About</a></li>
							<li><a href="#">Contact</a></li>
							<li><a href="#">RSS</a></li>
						</ul>
					</div>
				</div>

			</div>
			</body>
		</html>
	</xsl:template>


	<xsl:template match="reference" mode="sidebar"/>


	<xsl:template name="related_items">
		<xsl:param name="label"/>
		<xsl:param name="items"/>

		<xsl:if test="count($items) > 0">
			<div>
				<div class="sidebar-top"/>
				<div class="sidebar">
					<h4>
						<xsl:call-template name="icon">
							<xsl:with-param name="record" select="$items[1]"/>
							<xsl:with-param name="size" select="'small'"/>
						</xsl:call-template>
						<xsl:value-of select="$label"/>
					</h4>
					<ul>
						<xsl:apply-templates select="$items[1]">
							<xsl:with-param name="matches" select="$items"/>
						</xsl:apply-templates>
					</ul>
				</div>
				<div class="sidebar-bottom"></div>
			</div>
		</xsl:if>

	</xsl:template>



	<xsl:template match="related | pointer | reverse-pointer">
		<!-- this is where the display work is done summarising the related items of various types - pictures, events etc -->
		<!-- reftype-specific templates take precedence over this one -->
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
