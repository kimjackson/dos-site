<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template match="reversePointer[@id=199]/record[reftype/@id=99]">
		<xsl:param name="matches"/>
		<xsl:for-each select="$matches">
			<xsl:sort select="detail[@id=322]/record/detail[@id=160]"/>
			<li>
				<a href="{detail[@id=322]/record/id}#ref={id}" class="preview-{detail[@id=322]/record/id}c{id}">
					<xsl:value-of select="detail[@id=322]/record/detail[@id=160]"/>
				</a>
			</li>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
