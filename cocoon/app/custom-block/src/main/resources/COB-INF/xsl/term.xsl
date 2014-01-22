<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="term" match="record[type/@id=152]">

		<xsl:variable name="related" select="
			relationships
				/record
					/detail[@id=202 or @id=199]
						/record[id != current()/id]
		"/>

		<div id="subject-list">
			<!-- dc.description -->
			<xsl:if test="detail[@id=191]">
				<p>
					<xsl:value-of select="detail[@id=191]"/>
				</p>
			</xsl:if>

			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Entries</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=98]"/>
			</xsl:call-template>

			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">People</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Person']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Artefacts</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Artefact']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Buildings</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Building']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Events</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Event']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Natural features</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Natural feature']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Organisations</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Organisation']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Places</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Place']"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Structures</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=151][detail[@id=523] = 'Structure']"/>
			</xsl:call-template>

			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Pictures</xsl:with-param>
				<xsl:with-param name="items" select="$related[type/@id=74][starts-with(detail[@id=289], 'image')]"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Sound</xsl:with-param>
				<xsl:with-param name="items" select="$related[../../detail[@id=200]='IsRelatedTo'][type/@id=74][starts-with(detail[@id=289], 'audio')]"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Video</xsl:with-param>
				<xsl:with-param name="items" select="$related[../../detail[@id=200]='IsRelatedTo'][type/@id=74][starts-with(detail[@id=289], 'video')]"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Maps</xsl:with-param>
				<xsl:with-param name="items" select="$related[../../detail[@id=200]='IsRelatedTo'][type/@id=103]"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">Mentioned in</xsl:with-param>
				<xsl:with-param name="items" select="reversePointer[@id=199]/record[type/@id=99]"/>
			</xsl:call-template>
			<xsl:call-template name="termRelatedItems">
				<xsl:with-param name="label">External links</xsl:with-param>
				<xsl:with-param name="items" select="
					$related[
						../../detail[@id=200]='hasExternalLink' or
						../../detail[@id=200]='isExternalLinkOf'
					][type/@id=1]"/>
			</xsl:call-template>

		</div>

	</xsl:template>


	<xsl:template name="termRelatedItems">
		<xsl:param name="label"/>
		<xsl:param name="items"/>

		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$items[1]"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test="count($items) > 0">
			<div class="list-left-col list-{$type}" title="{$label}"></div>
			<div class="list-right-col">
				<div class="list-right-col-browse">
					<ul>
						<xsl:for-each select="$items">
							<xsl:sort select="detail[@id=160]"/>
							<li>
								<a href="{id}" class="preview-{id}">
									<xsl:value-of select="detail[@id=160]"/>
								</a>
							</li>
						</xsl:for-each>
					</ul>
				</div>
			</div>
			<div class="clearfix"/>
		</xsl:if>
	</xsl:template>


	<xsl:template match="record[type/@id=152]" mode="sidebar">
		<xsl:variable name="related" select="
			relationships
				/record
					/detail[@id=202 or @id=199]
						/record[id != current()/id]
		"/>
		<div id="connections">
			<h3>Connections</h3>
			<xsl:call-template name="relatedItems">
				<xsl:with-param name="label">Broader subjects</xsl:with-param>
				<xsl:with-param name="items" select="
					$related[../@id=199 and ../../detail[@id=200]='HasBroaderTerm'] |
					$related[../@id=202 and ../../detail[@id=200]/@inverse='HasBroaderTerm']
				"/>
			</xsl:call-template>
			<xsl:call-template name="relatedItems">
				<xsl:with-param name="label">Narrower subjects</xsl:with-param>
				<xsl:with-param name="items" select="
					$related[../@id=199 and ../../detail[@id=200]='HasNarrowerTerm'] |
					$related[../@id=202 and ../../detail[@id=200]/@inverse='HasNarrowerTerm']
				"/>
			</xsl:call-template>
		</div>
	</xsl:template>

</xsl:stylesheet>
