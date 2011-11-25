<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:ex="http://exslt.org/dates-and-times" 
	version="1.0">

	<xsl:include href="urlmap.xsl"/>

	<xsl:template name="citationStubs">
		<xsl:variable name="root" select="/hml/records/record"/>
		<xsl:variable name="related" select="
			$root/relationships
				/record
					/detail[@id=202 or @id=199]
						/record[id != $root/id]
		"/>
		<!-- direct pointers -->
		<xsl:for-each select="$root/detail/record">
			<xsl:call-template name="citationStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>
		

		<!-- annotations (in either direction) -->

		<!-- with targets -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=99][detail[@id=199]/record]">
			<xsl:call-template name="citationStub">
				<xsl:with-param name="record" select="current()[../@id=199]/detail[@id=322]/record | current()[../@id=322]/detail[@id=199]/record"/>
				<xsl:with-param name="context" select="id"/>
			</xsl:call-template>
		</xsl:for-each>
		<!-- without targets (gloss annotations) -->
		<xsl:for-each select="$root/reversePointer/record[type/@id=99][not(detail[@id=199]/record)]">
			<xsl:call-template name="citationStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		<!-- inverse contributor pointers -->
		<xsl:for-each select="$root/reversePointer[@id=538]/record">
			<xsl:call-template name="citationStub">
				<xsl:with-param name="record" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		
		
	</xsl:template>


	<xsl:template name="citationStub">
		<xsl:param name="record"/>
		<xsl:param name="context"/>

		<xsl:variable name="id">
			<xsl:value-of select="$record/id"/>
			<xsl:if test="$context">
				<xsl:text>c</xsl:text>
				<xsl:value-of select="$context"/>
			</xsl:if>
		</xsl:variable>

		<div id="citation-{$id}" class="citation"/>
	</xsl:template>


	<xsl:template name="citation">
		<xsl:param name="record"/>
		<xsl:param name="context"/>

		<xsl:variable name="type">
			<xsl:call-template name="getRecordTypeClassName">
				<xsl:with-param name="record" select="$record"/>
			</xsl:call-template>
		</xsl:variable>
		
		<!-- temp for testing -->
		
		<html>
			<head>
				<title></title>
				<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=2.0; user-scalable=1;" />
				<link rel="icon" href="http://heuristscholar.org/dos-static-2011-05-20/images/favicon.ico" type="image/x-icon"/>
				<link rel="shortcut icon" href="http://heuristscholar.org/dos-static-2011-05-20/images/favicon.ico" type="image/x-icon"/>
				<link rel="stylesheet" href="http://heuristscholar.org/dos-static-2011-05-20/style.css" type="text/css"/>
			</head>
			<body>

		<div class="balloon-container">
			<div class="balloon-top"/>
			<div class="balloon-middle">
				<div class="balloon-heading balloon-{$type}">
					<h2>Citation</h2>
				</div>
				<div class="balloon-content">
					<xsl:call-template name="citationContent">
						<xsl:with-param name="record" select="$record"/>
						
					</xsl:call-template>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="balloon-bottom"/>
		</div>
				
			</body>
			</html>
	</xsl:template>


	<xsl:template name="citationContent">
		<xsl:param name="record"/>
	
		<xsl:variable name="access_date" select="ex:date()"/>
		<!-- xsl:variable name="nice_date" select="ex:format-date($access_date,'dd MMM yyyy')"/ -->
		<xsl:variable name="dayofmonth" select="ex:day-in-month($access_date)"/>
		<xsl:variable name="monthname" select="ex:month-name($access_date)"/>
		<xsl:variable name="year" select="ex:year($access_date)"/>
		
		<xsl:variable name="pubDate" select="$record/detail[@id='166']/year"/>
		<xsl:variable name="author" select="$record/detail[@id=538]/record/detail[@id=160]"/>
		<!-- getPath template lives in urlmap.xsl - links ids to names -->
		<xsl:variable name="human_url">
			<xsl:call-template name="getPath">
				<xsl:with-param name="id" select="$record/id"/>
			</xsl:call-template>
		</xsl:variable>
		<p>
			
			<div class="balloon-content">
				<h4>Persistent URL for this entry</h4>
				<br/>
				<p>http://www.dictionaryofsydney.org/<xsl:value-of select="$human_url"/></p>
				<br/>
			</div>
			
			<div class="balloon-content">
				<h4>To cite this entry in text</h4>
				<br/>
				<p><xsl:value-of select="$author"/>, '<xsl:value-of select="$record/detail[@id=160]"/>', Dictionary of Sydney, 2009, http://www.dictionaryofsydney.org/entry/<xsl:value-of select="$human_url"/>, viewed <xsl:value-of select="$dayofmonth"/> <xsl:text> </xsl:text> <xsl:value-of select="$monthname"/> <xsl:text> </xsl:text> <xsl:value-of select="$year"/></p>	
				<br/>
			</div>
			
			
			<div class="balloon-content">
				<h4>To cite this entry in a Wikipedia footnote citation</h4>  
				<br/>
				<p>&lt;ref&gt;{{cite web |url= http://www.dictionaryofsydney.org/<xsl:value-of select="$human_url"/> |title = <xsl:value-of select="$record/detail[@id=160]"/> | author = <xsl:value-of select="$author"/> | date = <xsl:value-of select="$pubDate"/> |work = Dictionary of Sydney |publisher = Dictionary of Sydney Trust |accessdate = <xsl:value-of select="$access_date"/>}}&lt;/ref&gt;</p>
				<br/>
			</div>
			
			<div class="balloon-content">
				<h4>To cite this entry as a Wikipedia External link</h4>
				<br/>
				<p>
					* {{cite web | url = http://www.dictionaryofsydney.org/<xsl:value-of select="$human_url"/> | title = <xsl:value-of select="$record/detail[@id=160]"/> | accessdate = <xsl:value-of select="$access_date"/> | author = <xsl:value-of select="$author"/> | date = <xsl:value-of select="$pubDate"/> | work = Dictionary of Sydney | publisher = Dictionary of Sydney Trust}}
				</p>
				<br/>
				<div class="clearfix"></div>
			</div>
		</p>
	</xsl:template>

</xsl:stylesheet>
