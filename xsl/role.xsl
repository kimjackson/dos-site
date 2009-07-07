<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

	<xsl:template name="role" match="reference[reftype/@id=91]">

		<div class="line-box">

			<!-- dc.description -->
			<p>
				<xsl:value-of select="detail[@id=191]"/>
			</p>

			<!-- dc.type -->
			<p>
				<xsl:value-of select="detail[@id=591]"/>
			</p>
			<br/>
			<br/>

			<xsl:if test="detail[@id=591]='Occupation'">
				<table class="factoids" border="0" cellpadding="2">
				<xsl:for-each select="reverse-pointer[reftype/@id=150][detail[@id=526]=current()/detail[@id=591]]">
					<tr>
						<td>
							<a href="{pointer[@id=528]/id}">
								<xsl:value-of select="pointer[@id=528]/detail[@id=160]"/>
							</a>
						</td>
						<td>
							<xsl:value-of select="pointer[@id=529]/detail[@id=160]"/>
						</td>
						<td>
							<xsl:choose>
								<xsl:when test="pointer[@id=527]">
									<a href="{pointer[@id=527]/id}">
										<xsl:value-of select="pointer[@id=527]/detail[@id=160]"/>
									</a>
								</xsl:when>
								<xsl:when test="detail[@id=179]">
									<xsl:value-of select="detail[@id=179]"/>
								</xsl:when>
							</xsl:choose>
						</td>
						<td>
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="detail[@id=177]"/>
							</xsl:call-template>
						</td>
						<td>
							<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
										  detail[@id=178]/month != detail[@id=177]/month or
										  detail[@id=178]/day != detail[@id=177]/day">
								<xsl:call-template name="formatDate">
									<xsl:with-param name="date" select="detail[@id=178]"/>
								</xsl:call-template>
							</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
				</table>
			</xsl:if>


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
				<xsl:call-template name="role_factoids">
					<xsl:with-param name="factoids" select="
						$base/reverse-pointer
							[reftype/@id=150]
							[
								pointer[@id=527]/id = current()/@id  or
								detail[@id=179] = current()/text()
							]"/>
				</xsl:call-template>
			</xsl:for-each>

		</div>
	</xsl:template>


	<xsl:template name="role_factoids">
		<xsl:param name="factoids"/>

		<div class="role-factoids">

			<table class="factoids" border="0" cellpadding="2">
			<xsl:for-each select="$factoids">
				<xsl:sort select="detail[@id=177]/year"/>
				<xsl:sort select="detail[@id=177]/month"/>
				<xsl:sort select="detail[@id=177]/day"/>
				<xsl:sort select="pointer[@id=528]/detail[@id=160]"/>
				<tr>
					<td>
						<xsl:choose>
							<xsl:when test="$factoids[1]/pointer[@id=527]">
								<a href="{$factoids[1]/pointer[@id=527]/id}">
									<xsl:value-of select="$factoids[1]/pointer[@id=527]/detail[@id=160]"/>
								</a>
							</xsl:when>
							<xsl:when test="$factoids[1]/detail[@id=179]">
								<xsl:value-of select="$factoids[1]/detail[@id=179]"/>
							</xsl:when>
						</xsl:choose>
					</td>
						<td>
							<xsl:value-of select="pointer[@id=529]/detail[@id=160]"/>
						</td>
					<td>
						<a href="{pointer[@id=528]/id}">
							<xsl:value-of select="pointer[@id=528]/detail[@id=160]"/>
						</a>
					</td>
					<td>
						<xsl:call-template name="formatDate">
							<xsl:with-param name="date" select="detail[@id=177]"/>
						</xsl:call-template>
					</td>
					<td>
						<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
						              detail[@id=178]/month != detail[@id=177]/month or
						              detail[@id=178]/day != detail[@id=177]/day">
							<xsl:call-template name="formatDate">
								<xsl:with-param name="date" select="detail[@id=178]"/>
							</xsl:call-template>
						</xsl:if>
					</td>
				</tr>
			</xsl:for-each>
			</table>
		</div>

	</xsl:template>

</xsl:stylesheet>
