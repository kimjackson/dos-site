<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="exsl"
                version="1.0">

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


	<xsl:template name="getFileURL">
		<xsl:param name="file"/>
		<xsl:param name="size"/>
		<xsl:param name="fq"/>
		<!-- static, pre-generated files -->
		<!--
		<xsl:variable name="dir">
			<xsl:choose>
				<xsl:when test="$size = 'thumbnail'">thumbnail</xsl:when>
				<xsl:when test="$size = 'small'">small</xsl:when>
				<xsl:when test="$size = 'medium'">medium</xsl:when>
				<xsl:when test="$size = 'wide'">wide</xsl:when>
				<xsl:when test="$size = 'large'">large</xsl:when>
				<xsl:otherwise>full</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$fq">
				<xsl:value-of select="$fullurlbase"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$urlbase"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>files/</xsl:text>
		<xsl:value-of select="$dir"/>
		<xsl:text>/</xsl:text>
		<xsl:value-of select="$file/file_id"/>
		-->
		<!-- live from Heurist -->
		<xsl:choose>
			<xsl:when test="$size = 'thumbnail'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;amp;w=148&amp;amp;h=148</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'small'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;amp;w=148</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'medium'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;amp;h=180</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'wide'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;amp;w=800&amp;amp;h=400</xsl:text>
			</xsl:when>
			<xsl:when test="$size = 'large'">
				<xsl:value-of select="$file/file_thumb_url"/>
				<xsl:text>&amp;amp;w=698</xsl:text>
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
			<xsl:when test="$record[reftype/@id=151]">
				<xsl:call-template name="getEntityCodeName">
					<xsl:with-param name="typeName" select="$record/detail[@id=523]"/>
				</xsl:call-template>
			</xsl:when>
			<!-- media -->
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'image')]">image</xsl:when>
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'audio')]">audio</xsl:when>
			<xsl:when test="$record[reftype/@id=74][starts-with(detail[@id=289], 'video')]">video</xsl:when>
			<!-- others -->
			<xsl:when test="$record/reftype/@id = 1">link</xsl:when>
			<xsl:when test="$record/reftype/@id = 91">role</xsl:when>
			<xsl:when test="$record/reftype/@id = 98">entry</xsl:when>
			<xsl:when test="$record/reftype/@id = 99">annotation</xsl:when>
			<xsl:when test="$record/reftype/@id = 103">map</xsl:when>
			<xsl:when test="$record/reftype/@id = 152">term</xsl:when>
			<xsl:when test="$record/reftype/@id = 153">contributor</xsl:when>
			<xsl:when test="$record/reftype/@id = 154">reference</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xsl:variable name="entityNames">
		<entity c="artefact"     cp="artefacts"     t="Artefact"        p="Artefacts"/>
		<entity c="building"     cp="buildings"     t="Building"        p="Buildings"/>
		<entity c="event"        cp="events"        t="Event"           p="Events"/>
		<entity c="natural"      cp="natural"       t="Natural feature" p="Natural features"/>
		<entity c="organisation" cp="organisations" t="Organisation"    p="Organisations"/>
		<entity c="person"       cp="people"        t="Person"          p="People"/>
		<entity c="place"        cp="places"        t="Place"           p="Places"/>
		<entity c="structure"    cp="structures"    t="Structure"       p="Structures"/>
	</xsl:variable>


	<xsl:template name="getEntityCodeName">
		<xsl:param name="typeName"/>
		<xsl:value-of select="exsl:node-set($entityNames)/entity[@t=$typeName or @cp=$typeName]/@c"/>
	</xsl:template>


	<xsl:template name="getEntityTypeName">
		<xsl:param name="codeName"/>
		<xsl:value-of select="exsl:node-set($entityNames)/entity[@c=$codeName]/@t"/>
	</xsl:template>


	<xsl:template name="getEntityPluralName">
		<xsl:param name="codeName"/>
		<xsl:value-of select="exsl:node-set($entityNames)/entity[@c=$codeName or @cp=$codeName]/@p"/>
	</xsl:template>


	<xsl:template name="makeEntityBrowseList">
		<xsl:for-each select="exsl:node-set($entityNames)/entity">
			<li class="browse-{@c}"><a href="{@cp}"><xsl:value-of select="@p"/></a></li>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="getEntityTypeList">
		<xsl:param name="entity"/>
		<xsl:for-each select="$entity/reverse-pointer[@id=528][detail[@id=526]='Type']">
			<xsl:sort select="detail[@id=177]/year"/>
			<xsl:sort select="detail[@id=177]/month"/>
			<xsl:sort select="detail[@id=177]/day"/>
			<xsl:sort select="detail[@id=178]/year"/>
			<xsl:sort select="detail[@id=178]/month"/>
			<xsl:sort select="detail[@id=178]/day"/>
			<xsl:call-template name="getRoleName">
				<xsl:with-param name="factoid" select="."/>
			</xsl:call-template>
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
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
		<div id="heading" class="title-{$type}">
			<h1>
				<xsl:value-of select="$record/detail[@id=160]"/>
			</h1>
			<span id="sub-title">
				<xsl:choose>
					<xsl:when test="$record/reftype/@id = 151">
						<!-- entity -->
						<xsl:call-template name="getEntityTypeList">
							<xsl:with-param name="entity" select="$record"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$record/reftype/@id = 98">
						<!-- entry -->
						<xsl:call-template name="getEntryContributor">
							<xsl:with-param name="entry" select="$record"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$record/reftype/@id = 91">
						<!-- role -->
						<xsl:value-of select="$record/detail[@id=591]"/>
					</xsl:when>
					<xsl:when test="$record/reftype/@id = 152">
						<!-- term -->
						<xsl:text>Subject</xsl:text>
					</xsl:when>
				</xsl:choose>
			</span>
			<span id="extra">
				<!-- CC icon -->
			</span>
		</div>
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
