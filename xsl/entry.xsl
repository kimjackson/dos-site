<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:str="http://exslt.org/strings"
                exclude-result-prefixes="xi str"
                version="1.0">

	<xsl:include href="urlmap.xsl"/>

	<xsl:template name="xmldoc" match="record[reftype/@id=98]">

		<xsl:variable name="file" select="detail[@id=231 or @id=221]"/>

		<div id="content-left-col">

			<div id="tei">
				<xsl:if test="$file">
					<xi:include>
						<xsl:attribute name="href">
							<xsl:call-template name="getFileURL">
								<xsl:with-param name="file" select="$file"/>
							</xsl:call-template>
						</xsl:attribute>
					</xi:include>
				</xsl:if>
			</div>

			<div id="pagination">
				<a id="previous" href="#">&#171; previous</a>
				<a id="next" href="#">next &#187;</a>
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

		<xsl:call-template name="setupRefs"/>

		<xsl:for-each select="$matches">
			<xsl:sort select="str:split(detail[@id=539], ',')[1]" data-type="number"/>
			<xsl:sort select="str:split(detail[@id=539], ',')[2]" data-type="number"/>
			<xsl:sort select="str:split(detail[@id=539], ',')[3]" data-type="number"/>
			<xsl:sort select="str:split(detail[@id=539], ',')[4]" data-type="number"/>
			<xsl:sort select="detail[@id=329]" data-type="number"/>

			<xsl:choose>
				<xsl:when test="detail[@id=359]='Annotation Multimedia'">
					<xsl:if test="pointer[@id=199][reftype/@id=74 or reftype/@id=168]">
						<xsl:choose>
							<xsl:when test="starts-with(pointer[@id=199]/detail[@id=289], 'image') or pointer[@id=199]/detail[@id=618] = 'image'">
								<div class="annotation-img annotation-id-{id}">
									<a href="{pointer[@id=199]/id}" class="popup preview-{pointer[@id=199]/id}c{id}">
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
							</xsl:when>
							<xsl:when test="starts-with(pointer[@id=199]/detail[@id=289], 'audio')">
								<div class="annotation-img annotation-id-{id}">
									<a href="{pointer[@id=199]/id}" class="popup preview-{pointer[@id=199]/id}c{id}">
										<img src="{$urlbase}images/img-entity-audio.jpg"/>
									</a>
								</div>
							</xsl:when>
							<xsl:when test="starts-with(pointer[@id=199]/detail[@id=289], 'video')">
								<div class="annotation-img annotation-id-{id}">
									<a href="{pointer[@id=199]/id}" class="popup preview-{pointer[@id=199]/id}c{id}">
										<img>
											<xsl:attribute name="src">
												<xsl:call-template name="getFileURL">
													<xsl:with-param name="file" select="pointer[@id=199]/detail[@id=223]"/>
													<xsl:with-param name="size" select="'small'"/>
												</xsl:call-template>
											</xsl:attribute>
										</img>
									</a>
								</div>
							</xsl:when>
						</xsl:choose>
						<xsl:call-template name="addRef">
							<xsl:with-param name="ref" select="."/>
							<xsl:with-param name="hide">true</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="addRef">
						<xsl:with-param name="ref" select="."/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="setupRefs">
		<script type="text/javascript">
			if (! window["refs"]) {
				window["refs"] = [];
			}
		</script>
	</xsl:template>

	<xsl:template name="addRef">
		<xsl:param name="ref"/>
		<xsl:param name="hide"/>
		<script type="text/javascript">
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
					<xsl:if test="pointer[@id=199]">
					targetID : <xsl:value-of select="pointer[@id=199]/id"/>,
					href : "../<xsl:call-template name="getPath"><xsl:with-param name="id" select="pointer[@id=199]/id"/></xsl:call-template>",
					</xsl:if>
					recordID : "<xsl:value-of select="id"/>"
				} );
			}
		</script>
	</xsl:template>


	<xsl:template match="record[reftype/@id=98]" mode="sidebar">

		<div id="chapters">
			<div id="chapters-top"/>
			<div id="chapters-middle">
				<h3>Chapters</h3>
				<!-- document index generated here -->
			</div>
			<div id="chapters-bottom"/>
		</div>

		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedEntitiesByType"/>
			<xsl:call-template name="connections"/>
		</div>

	</xsl:template>

</xsl:stylesheet>
