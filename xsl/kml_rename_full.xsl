<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:kml="http://www.opengis.net/kml/2.2"
                version="1.0">

	<xsl:variable name="factoids" select="/data/export/references/reference/reverse-pointer"/>

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="/data">
		<xsl:apply-templates select="kml:kml"/>
	</xsl:template>

	<xsl:template match="kml:kml">
		<xsl:copy>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="kml:Placemark/kml:name">
		<xsl:variable name="factoidID" select="../kml:ExtendedData/kml:Data[@name='HeuristID']/kml:value"/>
		<xsl:variable name="factoid" select="$factoids[id=$factoidID]"/>
		<xsl:variable name="role" select="$factoid/pointer[@id=529]"/>

		<name>
			<xsl:call-template name="getRoleName">
				<xsl:with-param name="factoid" select="$factoid"/>
			</xsl:call-template>
			<xsl:call-template name="getTarget">
				<xsl:with-param name="factoid" select="$factoid"/>
			</xsl:call-template>
		</name>

	</xsl:template>


	<xsl:template name="getRoleName">
		<xsl:param name="factoid"/>
		<xsl:variable name="role" select="$factoid/pointer[@id=529]"/>

		<xsl:choose>
			<xsl:when test="$factoid/@id = 527  and  $role/detail[@id=174]">
				<!-- dc.title.inverse -->
				<xsl:value-of select="$role/detail[@id=174]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$role/detail[@id=160]"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$role/detail[@id=591] = 'Name'"> name</xsl:if>

	</xsl:template>


	<xsl:template name="getTarget">
		<xsl:param name="factoid"/>
		<xsl:choose>
			<xsl:when test="$factoid/@id = 528">
				<xsl:choose>
					<xsl:when test="$factoid/pointer[@id=527]">, <xsl:value-of select="$factoid/pointer[@id=527]/detail[@id=160]"/></xsl:when>
					<xsl:when test="$factoid/detail[@id=179]">, <xsl:value-of select="$factoid/detail[@id=179]"/></xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$factoid/@id = 527">, <xsl:value-of select="$factoid/pointer[@id=528]/detail[@id=160]"/></xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
