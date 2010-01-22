<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="previewStubs">
		<xsl:variable name="root" select="/hml/records/record"/>
		<!-- direct pointers -->
		<xsl:for-each select="$root/detail/record">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- related records -->
		<xsl:for-each select="$root/related">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="."/>
				<xsl:with-param name="context" select="@id"/>
			</xsl:call-template>
		</xsl:for-each>

		<!-- annotations (in either direction) -->

		<!-- with targets -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=99][detail[@id=199]/record]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()[@id=199]/detail[@id=322]/record | current()[@id=322]/detail[@id=199]/record"/>
				<xsl:with-param name="context" select="id"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- without targets (gloss annotations) -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=99][not(detail[@id=199]/record)]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		<!-- inverse contributor pointers -->
		<xsl:for-each select="$root/reversePointer[@id=538]/record">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		<!-- records related through factoids -->

		<!-- source-factoids with targets -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=528][detail[@id=527]/record]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=527]/record"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- source-factoids with roles -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=528]
			[detail[@id=529]/record[detail[@id=160]!='Generic']]
			[detail[@id=526]='Type' or detail[@id=526]='Occupation' or detail[@id=526]='Position']">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=529]/record"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- target-factoids -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=527]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=528]/record"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- target-factoids with roles -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=527]
			[detail[@id=529]/record[detail[@id=160]!='Generic']]
			[detail[@id=526]='Type' or detail[@id=526]='Occupation' or detail[@id=526]='Position']">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=529]/record"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- role pages: source -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=529][detail/@id=528]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=528]/record"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- role pages: target -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=150][@id=529][detail/@id=527]">
			<xsl:call-template name="previewStub">
				<xsl:with-param name="record" select="current()/detail[@id=527]/record"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>


	<xsl:template name="previewStub">
		<xsl:param name="record"/>
		<xsl:param name="context"/>

		<xsl:variable name="id">
			<xsl:value-of select="$record/id"/>
			<xsl:if test="$context">
				<xsl:text>c</xsl:text>
				<xsl:value-of select="$context"/>
			</xsl:if>
		</xsl:variable>

		<div id="preview-{$id}" class="preview"/>
	</xsl:template>


	<xsl:template name="preview">
		<xsl:param name="record"/>
		<xsl:param name="context"/>

		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$record"/>
			</xsl:call-template>
		</xsl:variable>

		<div class="balloon-container">
			<div class="balloon-top"/>
			<div class="balloon-middle">
				<div class="balloon-heading balloon-{$type}">
					<h2><xsl:value-of select="$record/detail[@id=160]"/></h2>
				</div>
				<div class="balloon-content">
					<xsl:call-template name="previewContent">
						<xsl:with-param name="record" select="$record"/>
						<xsl:with-param name="context" select="$context"/>
					</xsl:call-template>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="balloon-bottom"/>
		</div>
	</xsl:template>


	<xsl:template name="previewContent">
		<xsl:param name="record"/>
		<xsl:param name="context"/>

		<xsl:variable name="thumbnail" select="
			$record
				[type/@id=74]
				[starts-with(detail[@id=289], 'image')]
					/detail[@id=221]
			|
			$record
				[type/@id=151]
					/detail[@id=508]/record
						/detail[@id=221]
			|
			$record
				[type/@id=168]
					/detail[@id=221]
		"/>

		<xsl:choose>
			<xsl:when test="$thumbnail">
					<img class="thumbnail">
						<xsl:attribute name="alt"/><!-- FIXME -->
						<xsl:attribute name="src">
							<xsl:call-template name="getFileURL">
								<xsl:with-param name="file" select="$thumbnail"/>
								<xsl:with-param name="size" select="'thumbnail'"/>
							</xsl:call-template>
						</xsl:attribute>
					</img>
			</xsl:when>
		</xsl:choose>

		<p>
			<xsl:choose>
				<xsl:when test="$context and $record/reversePointer/record[id=$context]/detail[@id=191]">
					<xsl:value-of select="$record/reversePointer/record[id=$context]/detail[@id=191]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$record/detail[@id=191]"/>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>

</xsl:stylesheet>
