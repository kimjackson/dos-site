<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="factoids">
		<table class="factoids" border="0" cellpadding="2" width="100%" align="center">
			<xsl:if test="reverse-pointer[reftype/@id=150]
			                             [not(starts-with(detail[@id=526], 'Role'))]
			                             [not(starts-with(detail[@id=526], 'Relationship'))]
			                             [not(starts-with(detail[@id=526], 'Name'))]
			                             [not(starts-with(detail[@id=526], 'Generic'))]">
				<tr><th colspan="2">Milestones</th></tr>
				<!-- all factoids other than Role, Relationship and Name types? -->
				<xsl:apply-templates select="reverse-pointer[reftype/@id=150]
				                                            [not(starts-with(detail[@id=526], 'Role'))]
				                                            [not(starts-with(detail[@id=526], 'Relationship'))]
				                                            [not(starts-with(detail[@id=526], 'Name'))]
				                                            [not(starts-with(detail[@id=526], 'Generic'))]">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Role')]">
				<tr><th colspan="2">Roles</th></tr>
				<xsl:apply-templates select="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Role')]">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Relationship')]">
				<tr><th colspan="2">Relationships</th></tr>
				<xsl:apply-templates select="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Relationship')]">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
				</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Name')]">
				<tr><th colspan="2">Names</th></tr>
				<xsl:apply-templates select="reverse-pointer[reftype/@id=150][starts-with(detail[@id=526], 'Name')]">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
				</xsl:apply-templates>
			</xsl:if>
		</table>
	</xsl:template>


	<xsl:template match="reverse-pointer[reftype/@id=150]">
		<tr>
			<td>
				<xsl:call-template name="factoid_type_name"/>
			</td>

			<td>
				<xsl:call-template name="format_date">
					<xsl:with-param name="date" select="detail[@id=177]"/>
				</xsl:call-template>

				<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
				              detail[@id=178]/month != detail[@id=177]/month or
				              detail[@id=178]/day != detail[@id=177]/day">
					<xsl:text> - </xsl:text>
					<xsl:call-template name="format_date">
						<xsl:with-param name="date" select="detail[@id=178]"/>
					</xsl:call-template>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>


	<!-- plain english names for factoid types -->
	<xsl:template name="factoid_type_name">

		<xsl:variable name="type" select="detail[@id=526]"/>

		<xsl:choose>
			<xsl:when test="@id = 528">
				<!-- source -->

				<xsl:choose>
					<xsl:when test="$type = 'Artefact - Created'">Created</xsl:when>
					<xsl:when test="$type = 'Building-Structure - Constructed'">Constructed</xsl:when>
					<xsl:when test="$type = 'Building-Structure - Demolished'">Demolished</xsl:when>
					<xsl:when test="$type = 'Building-Structure - Modified'">Modified</xsl:when>

					<xsl:when test="$type = 'Person - ArrivedSydney'">Arrived in Sydney</xsl:when>
					<xsl:when test="$type = 'Person - Birth'">Born</xsl:when>
					<xsl:when test="$type = 'Person - Death'">Died</xsl:when>
					<xsl:when test="$type = 'Person - LeftSydney'">Left Sydney</xsl:when>
					<xsl:when test="$type = 'Relationship - ChildOf'">Parent</xsl:when>
					<xsl:when test="$type = 'Relationship - ColleagueOf'">Colleague</xsl:when>
					<xsl:when test="$type = 'Relationship - FriendOf'">Friend</xsl:when>
					<xsl:when test="$type = 'Relationship - OpponentOf'">Opponent</xsl:when>
					<xsl:when test="$type = 'Relationship - PatronOf'">Patronised</xsl:when>
					<xsl:when test="$type = 'Relationship - RelativeOf'">Relative</xsl:when>
					<xsl:when test="$type = 'Relationship - SiblingOf'">Sibling</xsl:when>
					<xsl:when test="$type = 'Relationship - SpouseOf'">Spouse</xsl:when>
					<xsl:when test="$type = 'Role - Occupation'">Occupation</xsl:when>
					<xsl:when test="$type = 'Role - Position'">Position</xsl:when>
					<xsl:otherwise><xsl:value-of select="substring-after($type, ' - ')"/></xsl:otherwise>
				</xsl:choose>

				<xsl:if test="pointer[@id=529]">
					<xsl:text> - </xsl:text>
					<a href="{pointer[@id=529]/id}">
						<xsl:value-of select="pointer[@id=529]/title"/>
					</a>
				</xsl:if>

				<xsl:if test="pointer[@id=527]">
					<xsl:text> of </xsl:text>
					<a href="{pointer[@id=527]/id}">
						<xsl:value-of select="pointer[@id=527]/title"/>
					</a>
				</xsl:if>
			</xsl:when>


			<xsl:when test="@id = 529">
				<!-- target -->

				<xsl:choose>
					<xsl:when test="$type = 'Relationship - ChildOf'">Child</xsl:when>
					<xsl:when test="$type = 'Relationship - ColleagueOf'">Colleague</xsl:when>
					<xsl:when test="$type = 'Relationship - FriendOf'">Friend</xsl:when>
					<xsl:when test="$type = 'Relationship - OpponentOf'">Opponent</xsl:when>
					<xsl:when test="$type = 'Relationship - PatronOf'">Patronised by</xsl:when>
					<xsl:when test="$type = 'Relationship - RelativeOf'">Relative</xsl:when>
					<xsl:when test="$type = 'Relationship - SiblingOf'">Sibling</xsl:when>
					<xsl:when test="$type = 'Relationship - SpouseOf'">Spouse</xsl:when>
					<xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise>
				</xsl:choose>
				<xsl:if test="pointer[@id=528]">
					<xsl:text> - </xsl:text>
					<a href="{pointer[@id=528]/id}">
						<xsl:value-of select="pointer[@id=528]/title"/>
					</a>
				</xsl:if>
			</xsl:when>

			<xsl:when test="@id = 527">
				<!-- place -->
				<xsl:value-of select="$type"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
