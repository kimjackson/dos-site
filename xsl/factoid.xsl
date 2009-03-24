<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template match="reverse-pointer[reftype/@id=150]">
		<tr>
			<td><!-- Type -->
				<xsl:value-of select="detail[@id=526]"/>
			</td>

			<td><!-- Source -->
				<xsl:choose>
					<xsl:when test="pointer[@id=528]/id  and  ../id != pointer[@id=528]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=528]/id}">
							<xsl:value-of select="pointer[@id=528]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=528]/id  and  ../id = pointer[@id=528]/id">
						<em>self</em>
					</xsl:when>
				</xsl:choose>
			</td>

			<td><!-- Related -->
				<xsl:choose>
					<xsl:when test="pointer[@id=529]/id  and  ../id != pointer[@id=529]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=529]/id}">
							<xsl:value-of select="pointer[@id=529]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=529]/id  and  ../id = pointer[@id=529]/id">
						<em>self</em>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="detail[@id=160]"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>

			<td><!-- Start -->
				<xsl:if test="detail[@id=177]/year"><xsl:value-of select="detail[@id=177]/year"/></xsl:if>
				<xsl:if test="detail[@id=177]/month">/<xsl:value-of select="detail[@id=177]/month"/></xsl:if>
				<xsl:if test="detail[@id=177]/day">/<xsl:value-of select="detail[@id=177]/day"/></xsl:if>
			</td>

			<td><!-- End -->
				<xsl:if test="detail[@id=178]/year"><xsl:value-of select="detail[@id=178]/year"/></xsl:if>
				<xsl:if test="detail[@id=178]/month">/<xsl:value-of select="detail[@id=178]/month"/></xsl:if>
				<xsl:if test="detail[@id=178]/day">/<xsl:value-of select="detail[@id=178]/day"/></xsl:if>
			</td>

			<td><!-- Place -->
				<xsl:choose>
					<xsl:when test="pointer[@id=528] and detail/@id=230">
						<!-- nb detail 230 = type location so show map -->

						see map


						<script>
							var HEURIST = {};
						</script>
						<!-- yes you do need this -->
						<xsl:element name="script">
							<xsl:attribute name="src"><xsl:value-of select="$hbase"/>/mapper/tmap-data.php?w=all&amp;q=id:<xsl:value-of select="id"/>
								<xsl:for-each select="related">
									<xsl:text>,</xsl:text>
									<xsl:value-of select="id"/>
								</xsl:for-each>
							</xsl:attribute>
						</xsl:element>
						<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
						<script src="{$hbase}/mapper/epoly.js"></script>
						<script src="{$hbase}/mapper/mapper.js"></script>

						<!-- script>
							loadMap( { compact: true, highlight: [<xsl:value-of select="id"/>], onclick: function(record) { window.location = "<xsl:value-of select="$cocoonbase"/>/item/<xsl:value-of select="id"/>"; } } );
							</script -->

						<script>
							window.onload = function() {
								loadMap( { compact: true, highlight: [], onclick: function(record) { window.location = "/cocoon/dos/browser/item/"+record.bibID+"/"; } } );
							};
						</script>

					</xsl:when>
					<xsl:when test="pointer[@id=527]/id  and  ../id != pointer[@id=527]/id">
						<a href="{$cocoonbase}/item/{pointer[@id=527]/id}">
							<xsl:value-of select="pointer[@id=527]/title"/>
						</a>
					</xsl:when>
					<xsl:when test="pointer[@id=527]/id  and  ../id = pointer[@id=527]/id">
						<em>self</em>
					</xsl:when>
				</xsl:choose>

			</td>
		</tr>

	</xsl:template>


</xsl:stylesheet>
