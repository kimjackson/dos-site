<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:template name="artwork" match="reference[reftype/@id=129]">
		<!-- root template for artworks -->
		
		<div id="artwork" class="artwork">
		
		<xsl:call-template name="images"/>
		
		<p><xsl:call-template name="medium"/></p>
		
		<p><b>width:</b> <xsl:call-template name="width-cm"/> cm<br/>
		<b>height:</b> <xsl:call-template name="height-cm"/> cm<br/>
		<b>width:</b> <xsl:call-template name="width-inches"/> inches<br/>
		<b>height:</b> <xsl:call-template name="height-inches"/> inches</p>
			
			<p><xsl:call-template name="description"/></p>
			 
			 
			 
			<p>
			<b>quality:</b> <xsl:call-template name="quality"/><br/>
			<b>condition:</b> <xsl:call-template name="condition"/>
			</p>
			
			
		
		
		</div>
	</xsl:template>
	
	<xsl:template name="images" match="detail[@id=224]">	
			<a href="{detail/file_fetch_url}" target="_top">
				<img src="{detail/file_thumb_url}&amp;w=400" border="1"/>
			</a>
	</xsl:template>
	
	
	<xsl:template name="description" match="detail[@id=303]">
			<xsl:call-template name="paragraphise">
				<xsl:with-param name="text">
					<xsl:value-of select="detail[@id=303]"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="medium" match="detail[@id=437]">
		<xsl:value-of select="detail[@id=437]"/>
	</xsl:template>
	
	<xsl:template name="quality" match="detail[@id=424]">
		<xsl:value-of select="detail[@id=424]"/>
	</xsl:template>
	
	<xsl:template name="condition" match="detail[@id=578]">
		<xsl:value-of select="detail[@id=578]"/>
	</xsl:template>
	
	<xsl:template name="width-cm" match="detail[@id=594]">
		<xsl:value-of select="detail[@id=594]"/>
	</xsl:template>
	
	<xsl:template name="width-inches" match="detail[@id=596]">
		<xsl:value-of select="detail[@id=596]"/>
	</xsl:template>
	
	<xsl:template name="height-inches" match="detail[@id=597]">
		<xsl:value-of select="detail[@id=597]"/>
	</xsl:template>
	
	<xsl:template name="height-cm" match="detail[@id=595]">
		<xsl:value-of select="detail[@id=595]"/>
	</xsl:template>
	
	
</xsl:stylesheet>
