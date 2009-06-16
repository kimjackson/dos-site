<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" xmlns:regexp="http://exslt.org/regexp" xmlns:xi="http://www.w3.org/2001/XInclude" version="1.0">

	<xsl:template name="xmldoc" match="reference[reftype/@id=98]">

		<script src="http://yui.yahooapis.com/2.7.0/build/yahoo/yahoo-debug.js"></script>
		<script src="http://yui.yahooapis.com/2.7.0/build/event/event-debug.js"></script>
		<script src="http://yui.yahooapis.com/2.7.0/build/history/history-debug.js"></script>

		<script src="/jquery/jquery.js"/>
		<script src="{$urlbase}js/highlight.js"/>

		<iframe id="yui-history-iframe" src="{$urlbase}images/logo.png"></iframe>
		<input id="yui-history-field" type="hidden"></input>

		<div id="content-left-col">

			<div id="tei">
				<xi:include>
					<xsl:attribute name="href">
						<xsl:call-template name="getFileURL">
							<xsl:with-param name="file" select="detail[@id=231 or @id=221]"/>
						</xsl:call-template>
					</xsl:attribute>
				</xi:include>
			</div>

			<div id="pagination">
				<a id="previous" href="#">&lt; Previous</a>
				<a id="next" href="#">Next &gt;</a>
			</div>
		</div>

		<div id="content-right-col">
			<xsl:apply-templates select="reverse-pointer[@id=322][reftype/@id=99][1]">
				<xsl:with-param name="matches" select="reverse-pointer[@id=322][reftype/@id=99]"/>
			</xsl:apply-templates>
		</div>

		<div class="clearfix"/>

	</xsl:template>


	<xsl:template match="reverse-pointer[@id=322][reftype/@id=99]">
		<xsl:param name="matches"/>
		<xsl:choose>
			<xsl:when test="$matches">

				<xsl:call-template name="setup_refs"/>

				<xsl:apply-templates select="$matches">
					<!-- somewhat cumbersome way of sorting based on annotation position: -->
					<xsl:sort select="substring-before(detail[@id=539], ',')" data-type="number"/>
					<!--xsl:sort select="substring-before(substring-after(detail[@id=539], ','), ',')" data-type="number"/-->
					<xsl:sort select="substring-after(detail[@id=539], ',')" data-type="text"/>
					<!--xsl:sort data-type="text" select="regexp:replace(detail[@id=539], '(,|^)(\d)(?!\d)', 'g', '$10$2')"/-->
					<xsl:sort select="detail[@id=329]" data-type="number"/>
				</xsl:apply-templates>

				<xsl:call-template name="render_refs"/>

			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="detail[@id=359]='Annotation Multimedia'">
						<xsl:if test="pointer[@id=199][reftype/@id=74]">
							<div class="annotation-img" annotation-id="{id}">
								<a href="{pointer[@id=199]/id}">
									<img>
										<xsl:attribute name="src">
											<xsl:call-template name="getFileURL">
												<xsl:with-param name="file" select="pointer[@id=199]/detail[@id=221]"/>
												<xsl:with-param name="size" select="'small'"/>
											</xsl:call-template>
										</xsl:attribute>
									</img>
								</a>
							</div>
							<xsl:call-template name="add_ref">
								<xsl:with-param name="ref" select="."/>
								<xsl:with-param name="hide">true</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="add_ref">
							<xsl:with-param name="ref" select="."/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="setup_refs">
		<script>
			if (! window["refs"]) {
				window["refs"] = [];
			}
		</script>
	</xsl:template>

	<xsl:template name="add_ref">
		<xsl:param name="ref"/>
		<xsl:param name="hide"/>
		<script>
			if (window["refs"]) {
				refs.push( {
					startElems : [ <xsl:value-of select="detail[@id=539]"/> ],
					endElems : [ <xsl:value-of select="detail[@id=540]"/> ],
					startWord :
						<xsl:choose>
							<xsl:when test="detail[@id=329]"><xsl:value-of select="detail[@id=329]"/></xsl:when>
							<xsl:otherwise>null</xsl:otherwise>
						</xsl:choose>,
					endWord :
						<xsl:choose>
							<xsl:when test="detail[@id=330]"><xsl:value-of select="detail[@id=330]"/></xsl:when>
							<xsl:otherwise>null</xsl:otherwise>
						</xsl:choose>,
					<xsl:if test="$hide='true'">
					hide : true,
					</xsl:if>
					href : "../<xsl:value-of select="id"/>/#ref1",
					title : "<xsl:call-template name="cleanQuote"><xsl:with-param name="string" select="detail[@id=160]"/></xsl:call-template>",
					recordID : "<xsl:value-of select="id"/>"
				} );
			}
		</script>
	</xsl:template>

	<xsl:template name="render_refs">
		<script>
		<![CDATA[
			var root = document.getElementById("tei");
			if (root  &&  window["refs"])
			highlight(root, refs);
		]]>
		</script>
	</xsl:template>


	<xsl:template match="reference[reftype/@id=98]" mode="sidebar">

		<div id="chapters">
			<h3>Chapters</h3>
			<!-- document index generated here -->
		</div>

		<div id="connections">
			<h3>Connections</h3>
			<ul id="menu">
				<xsl:call-template name="related_entities_by_type"/>
				<xsl:call-template name="connections"/>
			</ul>
		</div>

	</xsl:template>

</xsl:stylesheet>
