<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.opengis.net/kml/2.2"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:kml="http://www.opengis.net/kml/2.2"
                exclude-result-prefixes="kml"
                version="1.0">

	<xsl:include href="factoid.xsl"/>
	<xsl:include href="myvariables.xsl"/>
	<xsl:include href="util.xsl"/>

	<xsl:variable name="record" select="/data/hml/records/record"/>
	<xsl:variable name="factoids" select="$record/reversePointer/record"/>

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

		<name>
			<xsl:choose>
				<xsl:when test="$factoid/detail[@id=526] = 'TimePlace'">
					<xsl:value-of select="$record/detail[@id=160]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="getKMLRoleName">
						<xsl:with-param name="factoid" select="$factoid"/>
					</xsl:call-template>
					<xsl:call-template name="getTarget">
						<xsl:with-param name="factoid" select="$factoid"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</name>

	</xsl:template>


	<xsl:template name="getKMLRoleName">
		<xsl:param name="factoid"/>

		<xsl:call-template name="getRoleName">
			<xsl:with-param name="factoid" select="$factoid"/>
		</xsl:call-template>

		<xsl:if test="$factoid/detail[@id=529]/record/detail[@id=591] = 'Name'"> name</xsl:if>

	</xsl:template>


	<xsl:template name="getTarget">
		<xsl:param name="factoid"/>
		<xsl:choose>
			<xsl:when test="$factoid/@id = 528">
				<xsl:choose>
					<xsl:when test="$factoid/detail[@id=527]/record"> - <xsl:value-of select="$factoid/detail[@id=527]/record/detail[@id=160]"/></xsl:when>
					<xsl:when test="$factoid/detail[@id=179]"> - <xsl:value-of select="$factoid/detail[@id=179]"/></xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$factoid/@id = 527"> - <xsl:value-of select="$factoid/detail[@id=528]/record/detail[@id=160]"/></xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
