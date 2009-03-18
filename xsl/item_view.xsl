<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:str="http://exslt.org/strings"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                version="1.0">

	<xsl:param name="id"/>
	<xsl:param name="related_reftype_filter"/>
	

	<xsl:include href="myvariables.xsl"/>



	<xsl:include href="author_editor.xsl"/>
	<xsl:include href="books-etc.xsl"/>
	<xsl:include href="factoid.xsl"/>
	<xsl:include href="historical_event.xsl"/>
	<xsl:include href="internet_bookmark.xsl"/>
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
				<link href="{$urlbase}/style.css" rel="stylesheet" type="text/css" />
				<link href="{$urlbase}/tei.css" rel="stylesheet" type="text/css" />
				<style type="text/css">
					
					/* timemap styles */
					
					#timeline { 
					padding: 0;
					margin: 0;
					position: absolute;
					top: 400px;
					left: 120px;
					right: 0;
					bottom: 0;
					overflow: auto; 
					text-align: center; float: left;
					}
					
					#timeline-zoom {
					padding: 0;
					margin: 0;
					position: absolute;
					top: 400px;
					width: 120px;
					left: 10px;
					right: 0;
					bottom: 0;
					
					
					
					}
					
					
					#div-main {
					position:relative;
					float:center;   
					}
					
					a.timeline-zoom-a, a.timeline-zoom-a:hover, a.timeline-zoom-a:visited{
					text-decoration:none;
					padding-left: 5px;
					font-size: 11px;
					
					}
					
					.selected{
					font-size: 11px;
					background-color: yellow;
					}

				</style>

				<script>
					var pathDos = "http://heuristscholar.org/<xsl:value-of select="$cocoonbase"/>/item/";
					var imgpath = "http://heuristscholar.org/<xsl:value-of select="$urlbase"/>/img/reftype/";

					function showFootnote(recordID) {
						//document.getElementById("page").style.bottom = "205px";
						//document.getElementById("footnotes").style.display = "block";

						var elts = document.getElementsByName("footnote");
						if (elts.length === 0) elts = document.getElementById("footnotes-inner").getElementsByTagName("div");  // fallback compatibility with IE
						for (var i = 0; i &lt; elts.length; ++i) {
							var e = elts[i];
							e.style.display = e.getAttribute("recordID") == recordID ? "" : "none";
						}
						load(recordID);
					}

					function load(id) {
						var loader = new HLoader(
							function(s,r) {
								annotation_loaded(r[0]);
							},
							function(s,e) {
								alert("load failed: " + e);
							});
						HeuristScholarDB.loadRecords(new HSearch("id:" + id), loader);
				    }

					function annotation_loaded(record) {
				        var elts = document.getElementById("footnotes-inner");
						var notes = record.getDetail(HDetailManager.getDetailTypeById(303));

						elts.innerHTML = "&lt;p&gt;" + record.getTitle() + "&lt;/p&gt;";
						if (notes) {
							elts.innerHTML += "&lt;p&gt;" + notes + "&lt;/p&gt;";
						}

						var val = record.getDetail(HDetailManager.getDetailTypeById(199));
						if (val){
							HeuristScholarDB.loadRecords(new HSearch("id:"+val.getID()),
                                  new HLoader(function(s,r){MM_loaded(r[0],record)})
							);
						}

				   }
				   function MM_loaded(val,record) {
				        var elts = document.getElementById("footnotes-inner");

						if (val.getRecordType().getID() == 74) {
							var img=val.getDetail(HDetailManager.getDetailTypeById(221)). getThumbnailURL();
							elts.innerHTML += "&lt;br&gt;&lt;a href=\""+pathDos+val.getID()+"\"&gt;&lt;img src=\"" + img+ "\"/&gt;&lt;/a&gt;";
						}
						else {
						   elts.innerHTML += "&lt;br&gt;&lt;br&gt;&lt;span style=\"padding-right:5px; vertical-align:top\"&gt;&lt;a href=\""+pathDos+val.getID()+"\"&gt;"+val.getTitle()+"&lt;/a&gt;&lt;/span&gt;"+"&lt;img src=\"" + imgpath+val.getRecordType().getID() +".gif\"/&gt;";
						}
				   }
				</script>

				<script src="http://hapi.heuristscholar.org/load?instance={$instance}&amp;key={$hapi-key}"></script>
				<script src="{$urlbase}/js/search.js"/>
				<script>
					top.HEURIST = {};
					top.HEURIST.fireEvent = function(e, e){};
				</script>
				<script src="http://{$instance_prefix}heuristscholar.org/heurist/php/js/heurist-obj-user.php"></script>
				<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
				<xsl:if test="/export/references/reference/reftype[@id=103]">

					<script type="text/javascript" src="http://simile.mit.edu/timeline/api/timeline-api.js"></script>
					<script src="http://heuristscholar.org/{$urlbase}/timemap.1.3/timemap.js" type="text/javascript"></script>
				</xsl:if>
			</head>


			<body>
			<div id="container">
				<div id="header">
					<div class="logo"><a href="{$urlbase}"><img src="{$urlbase}/images/dictionary-of-sydney.jpg" width="148" height="97" /></a></div>
					<div class="search"><h1>SEARCH</h1></div>
					<form method="post" onsubmit="top.search(document.getElementById('search').value); return false;">
						<div class="search-box"><input type="text" name="search" id="search" /></div>
					</form>
					<div class="advanced-search">
						<ul>
							<li><a title="Coming soon" onclick="alert('Coming soon!'); return false;" href="#">Advanced</a></li>
						</ul>
					</div>
					<a href="#" class="left-arrow"><img src="{$urlbase}/images/img-left-arrow.jpg" width="13" height="24" /></a>
					<a href="#" class="right-arrow"><img src="{$urlbase}/images/img-right-arrow.jpg" width="13" height="24" /></a>
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
				<div id="title">
					<div id="entity-title" class="heading"><xsl:value-of select="export/references/reference[1]/title"/></div>
				</div>
				<div id="middle">
					<div class="left-column">
						<div class="content-top"></div>
						<div class="content" id="content">

								<xsl:apply-templates select="export/references/reference"/>

							<!--div id="factoids" class="line-box big-thumb-gap">

								<xsl:apply-templates select="export/references/reference"/>

								<span class="gray">FACTOIDS</span><br />
								<br />
								<img src="{$urlbase}/images/img-default-image.jpg" width="158" height="116" /><img src="{$urlbase}/images/img-default-map.jpg" width="158" height="116" />
							</div>
							<div id="text" class="line-box">
								<h1>TEXT</h1>
								In non arcu. Suspendisse aliquam eleifend magna. Praesent congue. Phesellus suscipit facilisis nunc. Pellentesque semper eleifend tellus. Fusce porttitor condimentum quam. Quisque quis justo. Proin congue erat eget dolor bibendum rhoncus. Nullam sit amet magna Cras lorem ligula, ultncies et, hendrerit eget, bibendum id, ligula.
							</div>
							<div id="images" class="line-box big-thumb-gap">
								<h1>IMAGES</h1>
								In non arcu. Suspendisse aliquam eleifend magna. Praesent congue. Phesellus suscipit facilisis nunc. Pellentesque semper eleifend tellus. Fusce porttitor condimentum quam. Quisque quis justo. Proin congue erat eget dolor bibendum rhoncus. Nullam sit amet magna Cras lorem ligula, ultncies et, hendrerit eget, bibendum id.<br />
								<br />
								<img src="{$urlbase}/images/img-image.jpg" width="158" height="115" /><img src="{$urlbase}/images/img-image.jpg" width="158" height="115" />
							</div>
							<div id="audio" class="line-box small-thumb-gap">
								<h1>AUDIO</h1>
								<img src="{$urlbase}/images/img-audio.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-audio.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-audio.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-audio.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-audio.jpg" width="67" height="50" />
							</div>
							<div id="video" class="line-box small-thumb-gap">
								<h1>VIDEO</h1>
								<img src="{$urlbase}/images/img-video.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-video.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-video.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-video.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-video.jpg" width="67" height="50" /></div>
							<div id="hi-res-images" class="line-box big-thumb-gap">
								<h1>HI RES IMAGES</h1>
							In non arcu. Suspendisse aliquam eleifend magna. Praesent congue. Phesellus suscipit facilisis nunc. Pellentesque semper eleifend tellus. Fusce porttitor condimentum quam. Quisque quis justo. Proin congue erat eget dolor bibendum rhoncus. Nullam sit amet magna Cras lorem ligula, ultncies et, hendrerit eget, bibendum id.<br />
							<br />
							<img src="{$urlbase}/images/img-image.jpg" width="158" height="115" /><img src="{$urlbase}/images/img-image.jpg" width="158" height="115" />
							</div>
							<div id="map" class="line-box small-thumb-gap">
							  <h1>MAP</h1>
								<img src="{$urlbase}/images/img-map.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-map.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-map.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-map.jpg" width="67" height="50" /><img src="{$urlbase}/images/img-map.jpg" width="67" height="50" /></div-->
						</div>
						<div class="content-bottom"></div>
					</div>
						<div class="right-column">
							<xsl:call-template name="related_items_section">
								<xsl:with-param name="items"
									select="export/references/reference/related |
											export/references/reference/pointer |
											export/references/reference/reverse-pointer"
								/>
							</xsl:call-template>
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


				<div id="footnotes">
					<div id="footnotes-inner">
						<xsl:apply-templates
							select="export/references/reference/reverse-pointer[reftype/@id=99]"
							mode="footnote"/>
					</div>
				</div>

			</div>
			</body>
		</html>
	</xsl:template>



	<xsl:template name="related_items_section">
		<xsl:param name="items"/>
		<!-- aggregate related items into groupings based on the type of related item -->

		<xsl:variable name="type_names">
			<type id="1" name="EXTERNAL LINKS" />
			<type id="74" name="MULTIMEDIA" />
			<type id="98" name="ENTRIES" />
			<type id="99" name="ANNOTATIONS" />
			<type id="103" name="MAPS" />
			<type id="151" name="ENTITIES" />
			<type id="152" name="TERMS" />
			<type id="153" name="CONTRIBUTORS" />
			<type id="154" name="REFERENCES" />
		</xsl:variable>

		<xsl:for-each select="exsl:node-set($type_names)/type">
			<xsl:choose>
				<xsl:when test="(@id != 150  or  ../reftype/@id = 103)  and  @id != $related_reftype_filter">
					<xsl:call-template name="related_items">
						<xsl:with-param name="reftype_id" select="@id"/>
						<xsl:with-param name="reftype_label" select="@name"/>
						<xsl:with-param name="items" select="$items[reftype/@id = current()/@id]"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>

	</xsl:template>



	<xsl:template name="related_items">
		<xsl:param name="reftype_id"/>
		<xsl:param name="reftype_label"/>
		<xsl:param name="items"/>

		<xsl:if test="count($items) > 0">
			<div>
				<div class="sidebar-top"/>
				<div class="sidebar">
					<h4>
						<xsl:value-of select="$reftype_label"/>
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
					<a href="{$cocoonbase}/item/{id}">
						<xsl:choose>
							<!-- related / notes -->
							<xsl:when test="@notes">
								<xsl:attribute name="title">
									<xsl:value-of select="@notes"/>
								</xsl:attribute>
							</xsl:when>
						</xsl:choose>
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



	<!-- fall-back template for any reference types that aren't already handled -->
	<xsl:template match="reference">
		<xsl:if test="detail[@id=221]">
			<img src="{detail[@id=221]/file_thumb_url}&amp;w=400"/>
		</xsl:if>
		<table>
			<tr>
				<td colspan="2">
					<img style="vertical-align: middle;"
						src="{$hbase}/img/reftype/{reftype/@id}.gif"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="reftype"/>
				</td>

			</tr>
			<xsl:if test="url != ''">
				<tr>
					<td style="padding-right: 10px;">URL</td>
					<td>
						<a href="{url}">
							<xsl:choose>
								<xsl:when test="string-length(url) &gt; 50">
									<xsl:value-of select="substring(url, 0, 50)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="url"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</td>
				</tr>
			</xsl:if>

			<!-- this calls  ? -->
			<xsl:for-each select="detail[@id!=222 and @id!=223 and @id!=224]">
				<tr>
					<td style="padding-right: 10px;">
						<nobr>
							<xsl:choose>
								<xsl:when test="string-length(@name)">
									<xsl:value-of select="@name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@type"/>
								</xsl:otherwise>
							</xsl:choose>
						</nobr>
					</td>
					<td>
						<xsl:choose>
							<!-- 268 = Contact details URL,  256 = Web links -->
							<xsl:when test="@id=268  or  @id=256  or  starts-with(text(), 'http')">
								<a href="{text()}">
									<xsl:choose>
										<xsl:when test="string-length() &gt; 50">
											<xsl:value-of select="substring(text(), 0, 50)"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="text()"/>
										</xsl:otherwise>
									</xsl:choose>
								</a>
							</xsl:when>
							<!-- 221 = AssociatedFile,  231 = Associated File -->
							<xsl:when test="@id=221  or  @id=231">
								<a href="{file_fetch_url}">
									<xsl:value-of select="file_orig_name"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="text()"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:for-each>


			<tr>
				<td style="padding-right: 10px;">
					<xsl:value-of select="pointer[@id=264]/@name"/>
				</td>
				<td>
					<xsl:apply-templates select="pointer[@id=264]"/>

				</td>
			</tr>
			<tr>
				<td style="padding-right: 10px;">
					<xsl:value-of select="pointer[@id=267]/@name"/>
				</td>
				<td>

					<xsl:apply-templates select="pointer[@id=267]"/>
				</td>
			</tr>

			<xsl:if test="notes != ''">
				<tr>
					<td style="padding-right: 10px;">Notes</td>
					<td>
						<xsl:value-of select="notes"/>
					</td>
				</tr>
			</xsl:if>

			<xsl:if test="detail[@id=222 or @id=223 or @id=224]">
				<tr>
					<td style="padding-right: 10px;">Images</td>
					<td>
						<!-- 222 = Logo image,  223 = Thumbnail,  224 = Images -->
						<xsl:for-each select="detail[@id=222 or @id=223 or @id=224]">
							<a href="{file_fetch_url}">
								<img src="{file_thumb_url}" border="0"/>
							</a> &#160;&#160; </xsl:for-each>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<xsl:template name="paragraphise">
		<xsl:param name="text"/>
		<xsl:for-each select="str:split($text, '&#xa;&#xa;')">
			<p>
				<xsl:value-of select="."/>
			</p>
		</xsl:for-each>
	</xsl:template>


</xsl:stylesheet>
