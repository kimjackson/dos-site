<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="factoids">
		<xsl:if test="count(reversePointer/record[type/@id=150][detail[@id=526]='Type']) > 1">
			<xsl:call-template name="factoidGroup">
				<xsl:with-param name="heading">Types</xsl:with-param>
				<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Type']"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="factoidGroup">
			<xsl:with-param name="heading">Names</xsl:with-param>
			<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Name']"/>
		</xsl:call-template>
		<xsl:call-template name="factoidGroup">
			<xsl:with-param name="heading">Milestones</xsl:with-param>
			<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Milestone']"/>
		</xsl:call-template>
		<xsl:call-template name="factoidGroup">
			<xsl:with-param name="heading">Relationships</xsl:with-param>
			<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Relationship']"/>
		</xsl:call-template>
		<xsl:call-template name="factoidGroup">
			<xsl:with-param name="heading">Occupations</xsl:with-param>
			<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Occupation']"/>
		</xsl:call-template>
		<xsl:call-template name="factoidGroup">
			<xsl:with-param name="heading">Positions</xsl:with-param>
			<xsl:with-param name="factoids" select="reversePointer/record[type/@id=150][detail[@id=526]='Position']"/>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="factoidGroup">
		<xsl:param name="heading"/>
		<xsl:param name="factoids"/>

		<xsl:if test="$factoids">
			<div class="entity-information">
				<div class="entity-information-heading">
					<xsl:value-of select="$heading"/>
				</div>
				<xsl:for-each select="$factoids">
					<xsl:sort select="detail[@id=177]/year"/>
					<xsl:sort select="detail[@id=177]/month"/>
					<xsl:sort select="detail[@id=177]/day"/>
					<xsl:sort select="detail[@id=178]/year"/>
					<xsl:sort select="detail[@id=178]/month"/>
					<xsl:sort select="detail[@id=178]/day"/>
					<xsl:sort select="detail[@id=529]/record/detail[@id=160]"/>

					<xsl:call-template name="factoid"/>

					<div class="clearfix"></div>
				</xsl:for-each>
			</div>
		</xsl:if>
	</xsl:template>


	<xsl:template name="factoid" match="reversePointer/record[type/@id=150]">

		<xsl:variable name="roleLink">
			<xsl:if test="detail[@id=529]/record">
				<xsl:value-of select="detail[@id=529]/record/id"/>
				<xsl:if test="detail[@id=527]/record">
					<xsl:text>#t</xsl:text>
					<xsl:value-of select="detail[@id=527]/record/id"/>
				</xsl:if>
			</xsl:if>
		</xsl:variable>


		<xsl:choose>
			<!-- generic and type factoids can span two columns -->
			<xsl:when test="detail[@id=529]/record/detail[@id=160] = 'Generic'">
				<div class="entity-information-col01-02">
					<xsl:value-of select="detail[@id=160]"/>
				</div>
			</xsl:when>
			<xsl:when test="detail[@id=526] = 'Type'">
				<div class="entity-information-col01-02">
					<a href="{$roleLink}" class="preview-{detail[@id=529]/record/id}">
						<xsl:call-template name="getRoleName">
							<xsl:with-param name="factoid" select="."/>
						</xsl:call-template>
					</a>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="entity-information-col01">
					<xsl:choose>
						<xsl:when test="detail[@id=526] = 'Occupation' or detail[@id=526] = 'Position'">
							<a href="{$roleLink}" class="preview-{detail[@id=529]/record/id}">
								<xsl:call-template name="getRoleName">
									<xsl:with-param name="factoid" select="."/>
								</xsl:call-template>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getRoleName">
								<xsl:with-param name="factoid" select="."/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div class="entity-information-col02">
					<xsl:choose>
						<xsl:when test="@id=527 and detail[@id=528]/record">
							<a href="{detail[@id=528]/record/id}" class="preview-{detail[@id=528]/record/id}">
								<xsl:value-of select="detail[@id=528]/record/detail[@id=160]"/>
							</a>
						</xsl:when>
						<xsl:when test="@id=528 and detail[@id=527]/record">
							<a href="{detail[@id=527]/record/id}" class="preview-{detail[@id=527]/record/id}">
								<xsl:value-of select="detail[@id=527]/record/detail[@id=160]"/>
							</a>
						</xsl:when>
						<xsl:when test="@id=528 and detail[@id=179]">
							<xsl:value-of select="detail[@id=179]"/>
						</xsl:when>
					</xsl:choose>
				</div>
			</xsl:otherwise>
		</xsl:choose>

		<div class="entity-information-col03">
			<xsl:call-template name="formatDate">
				<xsl:with-param name="date" select="detail[@id=177]"/>
			</xsl:call-template>
		</div>
		<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
					  detail[@id=178]/month != detail[@id=177]/month or
					  detail[@id=178]/day != detail[@id=177]/day">
			<div class="entity-information-col04">
				<xsl:text> - </xsl:text>
			</div>
			<div class="entity-information-col05">
				<xsl:call-template name="formatDate">
					<xsl:with-param name="date" select="detail[@id=178]"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</xsl:template>


	<xsl:template name="roleFactoid" match="reversePointer/record[type/@id=150]">

		<div class="entity-information-col01-02">
			<a href="{detail[@id=528]/record/id}" class="preview-{detail[@id=528]/record/id}">
				<xsl:value-of select="detail[@id=528]/record/detail[@id=160]"/>
			</a>
		</div>

		<div class="entity-information-col03">
			<xsl:call-template name="formatDate">
				<xsl:with-param name="date" select="detail[@id=177]"/>
			</xsl:call-template>
		</div>
		<xsl:if test="detail[@id=178]/year != detail[@id=177]/year or
					  detail[@id=178]/month != detail[@id=177]/month or
					  detail[@id=178]/day != detail[@id=177]/day">
			<div class="entity-information-col04">
				<xsl:text> - </xsl:text>
			</div>
			<div class="entity-information-col05">
				<xsl:call-template name="formatDate">
					<xsl:with-param name="date" select="detail[@id=178]"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</xsl:template>


	<xsl:template name="getRoleName">
		<xsl:param name="factoid"/>
		<xsl:variable name="role" select="$factoid/detail[@id=529]/record"/>
		<xsl:choose>
			<xsl:when test="$role/detail[@id=160] = 'Generic'">
				<!-- generic role, use factoid title instead -->
				<xsl:value-of select="$factoid/detail[@id=160]"/>
			</xsl:when>
			<xsl:when test="$factoid/@id = 527 and $role/detail[@id=174]">
				<!-- use inverse role name -->
				<xsl:value-of select="$role/detail[@id=174]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$role/detail[@id=160]"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
