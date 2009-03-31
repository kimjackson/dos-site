<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" xmlns:regexp="http://exslt.org/regexp" xmlns:xi="http://www.w3.org/2001/XInclude" version="1.0">

	<xsl:include href="clean_quote.xsl"/>

	<xsl:template name="xmldoc" match="reference[reftype/@id=98]">

		<script src="{$urlbase}/js/highlight.js"/>

		<div>
			<div class="content-left">
				<!-- dc.contributor -->
				<div class="content-author">
					<xsl:value-of select="pointer[@id=538]/detail[@id=160]"/>
				</div>

				<!-- dc.date -->
				<div class="content-date">
					<xsl:call-template name="format_date">
						<xsl:with-param name="date" select="detail[@id=166]"/>
					</xsl:call-template>
				</div>

				<div class="clear"/>

				<xsl:choose>
					<!-- detail 231 is associated WordML file -->
					<xsl:when test="detail[@id=231]">
						<div id="tei" style="padding-right: 10px">
							<xi:include href="{detail[@id=231]/file_fetch_url}"/>
						</div>
					</xsl:when>
					<!-- detail 221 is associated TEI file -->
					<xsl:when test="detail[@id=221]">
						<div id="tei" style="padding-right: 10px">
							<xi:include href="{detail[@id=221]/file_fetch_url}"/>
						</div>
					</xsl:when>
				</xsl:choose>
			</div>
			
			<div class="content-right">
				<!--xsl:for-each select="reverse-pointer[@id=322][reftype/@id=99][detail[@id=359]='Annotation Multimedia']">
					<xsl:for-each select="pointer[@id=199][reftype/@id=74][starts-with(detail[@id=289], 'image')]">
						<img src="{detail[@id=221]/file_thumb_url}"/>
						<br/>
					</xsl:for-each>
				</xsl:for-each-->
				<xsl:apply-templates select="reverse-pointer[@id=322][reftype/@id=99][1]">
					<xsl:with-param name="matches" select="reverse-pointer[@id=322][reftype/@id=99]"/>
				</xsl:apply-templates>
			</div>
			
			<div class="clear"/>
		</div>

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
					<xsl:when test="detail[@id=359]='Annotation Multimedia'  and  pointer[@id=199][reftype/@id=74][starts-with(detail[@id=289], 'image')]">
						<p>
							<a href="../{pointer[@id=199]/id}">
								<img src="{pointer[@id=199]/detail[@id=221]/file_thumb_url}"/>
							</a>
							<br/>
							<xsl:value-of select="pointer[@id=199]/detail[@id=160]"/>
							<xsl:for-each select="pointer[@id=199]/pointer[@id=538]">
								<br/>
								<xsl:choose>
									<xsl:when test="detail[@id=569]">
										<xsl:value-of select="detail[@id=569]"/>
									</xsl:when>
									<xsl:otherwise>
										Contributed by: <xsl:value-of select="detail[@id=160]"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<!--p>
							<a href="#ref{id}" annotation-id="{id}" onclick="highlightAnnotation({id});">
								<xsl:value-of select="title"/>
							</a>
						</p-->
					</xsl:otherwise>
				</xsl:choose>

				<xsl:call-template name="add_ref">
					<xsl:with-param name="ref" select="."/>
				</xsl:call-template>

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
			window.onload = highlightOnLoad;
		]]>
		</script>
	</xsl:template>


	<xsl:template match="reference[reftype/@id=98]" mode="sidebar">

		<!-- generate document index here -->

		<xsl:call-template name="related_entities_by_type"/>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Related Terms</xsl:with-param>
			<xsl:with-param name="items" select="related[reftype/@id=152]"/>
		</xsl:call-template>
		<xsl:call-template name="related_items">
			<xsl:with-param name="label">Referenced in</xsl:with-param>
			<xsl:with-param name="items" select="reverse-pointer[@id=199][reftype/@id=99]"/>
		</xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
