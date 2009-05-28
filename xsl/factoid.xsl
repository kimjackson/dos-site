<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="factoids">
		<table class="factoids" border="0" cellpadding="2">
			<xsl:call-template name="factoid_group">
				<xsl:with-param name="heading">Names</xsl:with-param>
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][detail[@id=526]='Name']"/>
			</xsl:call-template>
			<xsl:call-template name="factoid_group">
				<xsl:with-param name="heading">Milestones</xsl:with-param>
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][detail[@id=526]='Milestone']"/>
			</xsl:call-template>
			<xsl:call-template name="factoid_group">
				<xsl:with-param name="heading">Relationships</xsl:with-param>
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][detail[@id=526]='Relationship']"/>
			</xsl:call-template>
			<xsl:call-template name="factoid_group">
				<xsl:with-param name="heading">Occupations</xsl:with-param>
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][detail[@id=526]='Occupation']"/>
			</xsl:call-template>
			<xsl:call-template name="factoid_group">
				<xsl:with-param name="heading">Positions</xsl:with-param>
				<xsl:with-param name="factoids" select="reverse-pointer[reftype/@id=150][detail[@id=526]='Position']"/>
			</xsl:call-template>
		</table>
	</xsl:template>


	<xsl:template name="factoid_group">
		<xsl:param name="heading"/>
		<xsl:param name="factoids"/>
		<xsl:if test="$factoids">
			<tr><th colspan="2"><xsl:value-of select="$heading"/></th></tr>
			<xsl:apply-templates select="$factoids">
				<xsl:sort select="pointer[@id=529]/detail[@id=160]"/>
				<xsl:sort select="detail[@id=177]/year"/>
				<xsl:sort select="detail[@id=177]/month"/>
				<xsl:sort select="detail[@id=177]/day"/>
				<xsl:sort select="detail[@id=178]/year"/>
				<xsl:sort select="detail[@id=178]/month"/>
				<xsl:sort select="detail[@id=178]/day"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>


	<xsl:template match="reverse-pointer[reftype/@id=150]">
		<tr>
			<td>
				<xsl:choose>
					<xsl:when test="detail[@id=526]='Name' or detail[@id=526]='Milestone'">
						<xsl:call-template name="role_name"/>
					</xsl:when>
					<xsl:otherwise>
						<a href="{pointer[@id=529]/id}">
							<xsl:call-template name="role_name"/>
						</a>
					</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<xsl:choose>
					<xsl:when test="@id=527 and pointer[@id=528]">
						<a href="{pointer[@id=528]/id}">
							<xsl:value-of select="pointer[@id=528]/detail[@id=160]"/>
						</a>
					</xsl:when>
					<xsl:when test="@id=528 and pointer[@id=527]">
						<a href="{pointer[@id=527]/id}">
							<xsl:value-of select="pointer[@id=527]/detail[@id=160]"/>
						</a>
					</xsl:when>
					<xsl:when test="@id=528 and detail[@id=179]">
						<xsl:value-of select="detail[@id=179]"/>
					</xsl:when>
				</xsl:choose>
			</td>
			<td>
				<xsl:call-template name="format_date">
					<xsl:with-param name="date" select="detail[@id=177]"/>
				</xsl:call-template>
			</td>
			<td>
				<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
				              detail[@id=178]/month != detail[@id=177]/month or
				              detail[@id=178]/day != detail[@id=177]/day">
						<xsl:call-template name="format_date">
							<xsl:with-param name="date" select="detail[@id=178]"/>
						</xsl:call-template>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>


	<xsl:template name="role_name">
		<xsl:choose>
			<xsl:when test="@id=527 and pointer[@id=529]/detail[@id=174]">
				<!-- use inverse role name -->
				<xsl:value-of select="pointer[@id=529]/detail[@id=174]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="pointer[@id=529]/detail[@id=160]"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
