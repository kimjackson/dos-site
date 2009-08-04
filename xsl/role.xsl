<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

	<xsl:template name="role" match="reference[reftype/@id=91]">

			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<div class="entity-content">
					<p>
						<xsl:value-of select="detail[@id=191]"/>
					</p>
				</div>
			</xsl:if>


			<!-- factoids without a target -->
			<xsl:call-template name="roleFactoidGroup">
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][not(pointer[@id=527])]"/>
			</xsl:call-template>


			<xsl:variable name="targets">
				<xsl:for-each select="reverse-pointer[reftype/@id=150]/pointer[@id=527]/detail[@id=160] |
				                      reverse-pointer[reftype/@id=150]/detail[@id=179]">
					<xsl:sort/>
					<target>
						<xsl:if test="@id=160">
							<xsl:attribute name="id"><xsl:value-of select="../id"/></xsl:attribute>
						</xsl:if>
						<xsl:value-of select="."/>
					</target>
				</xsl:for-each>
			</xsl:variable>

			<xsl:variable name="base" select="."/>

			<xsl:for-each select="exsl:node-set($targets)/target[not(text() = preceding-sibling::*/text())]">
				<xsl:call-template name="roleFactoidGroup">
					<xsl:with-param name="id" select="@id"/>
					<xsl:with-param name="factoids" select="
						$base/reverse-pointer
							[reftype/@id=150]
							[
								pointer[@id=527]/id = current()/@id  or
								detail[@id=179] = current()/text()
							]"/>
				</xsl:call-template>
			</xsl:for-each>

	</xsl:template>


	<xsl:template name="roleFactoidGroup">
		<xsl:param name="id"/>
		<xsl:param name="factoids"/>

		<xsl:if test="$factoids">
			<div class="entity-information">
				<xsl:if test="$id">
					<xsl:attribute name="id">t<xsl:value-of select="$id"/></xsl:attribute>
				</xsl:if>
				<div class="entity-information-heading">
					<xsl:choose>
						<xsl:when test="$factoids[1]/pointer[@id=527]">
							<xsl:value-of select="$factoids[1]/detail[@id=526]"/>
							<xsl:text> - </xsl:text>
							<xsl:value-of select="$factoids[1]/pointer[@id=529]/detail[@id=160]"/>
							<xsl:text> of </xsl:text>
							<a href="{$factoids[1]/pointer[@id=527]/id}" class="preview-{$factoids[1]/pointer[@id=527]/id}">
								<xsl:value-of select="$factoids[1]/pointer[@id=527]/detail[@id=160]"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="detail[@id=591]"/>
							<xsl:text> - </xsl:text>
							<xsl:value-of select="detail[@id=160]"/>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<xsl:for-each select="$factoids">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
					<xsl:sort select="pointer[@id=529]/detail[@id=160]"/>

					<xsl:call-template name="roleFactoid"/>

					<div class="clearfix"></div>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
