<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:str="http://exslt.org/strings" version="1.0">

	<xsl:template name="cleanQuote">
		<xsl:param name="string"/>
		<xsl:choose>
			<xsl:when test="contains($string, '&#x22;')">
				<xsl:value-of select="substring-before($string, '&#x22;')"/>
				<xsl:text>\"</xsl:text>
				<xsl:call-template name="cleanQuote">
					<xsl:with-param name="string" select="substring-after($string, '&#x22;')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="formatDate">
		<xsl:param name="date"/>
		<xsl:if test="$date/day">
			<xsl:value-of select="$date/day"/>
			<xsl:choose>
				<xsl:when test="$date/month = 1"> Jan </xsl:when>
				<xsl:when test="$date/month = 2"> Feb </xsl:when>
				<xsl:when test="$date/month = 3"> Mar </xsl:when>
				<xsl:when test="$date/month = 4"> Apr </xsl:when>
				<xsl:when test="$date/month = 5"> May </xsl:when>
				<xsl:when test="$date/month = 6"> Jun </xsl:when>
				<xsl:when test="$date/month = 7"> Jul </xsl:when>
				<xsl:when test="$date/month = 8"> Aug </xsl:when>
				<xsl:when test="$date/month = 9"> Sep </xsl:when>
				<xsl:when test="$date/month = 10"> Oct </xsl:when>
				<xsl:when test="$date/month = 11"> Nov </xsl:when>
				<xsl:when test="$date/month = 12"> Dec </xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="$date/year">
			<xsl:value-of select="$date/year"/>
		</xsl:if>
	</xsl:template>


	<!--xsl:template name="icon">
		<xsl:param name="record"/>
		<xsl:param name="size"/>

		<xsl:variable name="name">
			<xsl:choose>
				<xsl:when test="$record[reftype/@id=151][starts-with(detail[@id=523], 'Person')]">people</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'image')]">video</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'audio')]">video</xsl:when>
				<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'video')]">video</xsl:when>
				<xsl:otherwise>people</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="pixels">
			<xsl:choose>
				<xsl:when test="$size = 'small'">16</xsl:when>
				<xsl:when test="$size = 'medium'">32</xsl:when>
				<xsl:when test="$size = 'big'">64</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<img src="{$urlbase}images/{$name}-{$pixels}.jpg"/>
	</xsl:template-->


	<!-- static, pre-generated files -->
	<!--xsl:template name="getFileURL">
		<xsl:param name="file"/>
		<xsl:param name="size"/>
		<xsl:variable name="dir">
			<xsl:choose>
				<xsl:when test="$size = 'small'">100</xsl:when>
				<xsl:when test="$size = 'medium'">300</xsl:when>
				<xsl:when test="$size = 'full'">full</xsl:when>
				<xsl:otherwise>full</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$urlbase"/>
		<xsl:text>files/</xsl:text>
		<xsl:value-of select="$dir"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$file/file_id"/>

	</xsl:template-->

	<!-- live from Heurist -->
	<xsl:template name="getFileURL">
		<xsl:param name="file"/>
		<xsl:param name="size"/>
		<xsl:choose>
			<xsl:when test="$size = 'small'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;w=147</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'medium'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;w=300&amp;h=300</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'large'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;w=600&amp;h=600</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$file/file_fetch_url"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="getRecordTypeClassName">
		<xsl:param name="record"/>
		<xsl:choose>
			<!-- entity -->
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Artefact'">artifact</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Building'">building</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Event'">event</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Natural feature'">natural</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Organisation'">organisation</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Person'">people</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Place'">place</xsl:when>
			<xsl:when test="$record[reftype/@id=151]/detail[@id=523] = 'Structure'">structure</xsl:when>
			<!-- media -->
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'image')]">picture</xsl:when>
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'audio')]">sound</xsl:when>
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'video')]">video</xsl:when>
			<!-- others -->
			<xsl:when test="$record/reftype/@id = 98">entry</xsl:when>
			<xsl:when test="$record/reftype/@id = 99">annotation</xsl:when>
			<xsl:when test="$record/reftype/@id = 103">map</xsl:when>
			<xsl:when test="$record/reftype/@id = 91">role</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="getEntityRole">
		<xsl:param name="entity"/>
		<xsl:value-of select="$entity/reverse-pointer[@id=528][detail[@id=526]='Type']/pointer[@id=529]/detail[@id=160]"/>
	</xsl:template>


	<xsl:template name="getEntryContributor">
		<xsl:param name="entry"/>
		<xsl:choose>
			<xsl:when test="$entry/pointer[@id=538]">
				<xsl:text>by </xsl:text>
				<xsl:value-of select="$entry/pointer[@id=538]/detail[@id=160]"/>
				<xsl:if test="$entry/detail[@id=166]">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="$entry/detail[@id=166]/year"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="makeTitleDiv">
		<xsl:param name="record"/>
		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$record"/>
			</xsl:call-template>
		</xsl:variable>
		<div id="title">
			<h1 class="title-{$type}">
				<xsl:value-of select="$record/detail[@id=160]"/>
			</h1>
		</div>
		<span id="sub-title">
			<xsl:choose>
				<xsl:when test="$record/reftype/@id = 151">
					<xsl:call-template name="getEntityRole">
						<xsl:with-param name="entity" select="$record"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$record/reftype/@id = 98">
					<xsl:call-template name="getEntryContributor">
						<xsl:with-param name="entry" select="$record"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</span>
		<span id="extra">
			<!-- CC icon -->
		</span>
	</xsl:template>


	<xsl:template name="makeMediaAttributionStatement">
		<xsl:param name="record"/>
		<xsl:if test="$record/detail[@id=365]">
			<xsl:text>By </xsl:text>
			<xsl:value-of select="$record/detail[@id=365]"/>
			<xsl:text>. </xsl:text>
		</xsl:if>
		<xsl:if test="$record/pointer[@id=538]">
			<xsl:choose>
				<xsl:when test="$record/pointer[@id=538]/detail[@id=569]">
					<xsl:value-of select="$record/pointer[@id=538]/detail[@id=569]"/>
					<xsl:text> </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- default attribution phrase? -->
					<xsl:text>Contributed by </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<a href="{$record/pointer[@id=538]/id}">
				<xsl:value-of select="$record/pointer[@id=538]/detail[@id=160]"/>
			</a>
		</xsl:if>
		<xsl:if test="$record/detail[@id=368]">
			<xsl:text>: </xsl:text>
			<span class="contributor-id">
				<xsl:value-of select="$record/detail[@id=368]"/>
			</span>
		</xsl:if>
		<xsl:if test="$record/detail[@id=290]">
			<xsl:text> </xsl:text>
			<xsl:text>(</xsl:text>
			<xsl:value-of select="$record/detail[@id=290]"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:template>


</xsl:stylesheet>
