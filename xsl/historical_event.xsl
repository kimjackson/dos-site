<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:param name="flavour"/>

	<xsl:template name="historical_event" match="reference[reftype/@id=51]">
		<table width="100%">
			<tr>
				<td width="100%">



					<!-- xsl:choose>
						<xsl:when test="detail@id = 230" -->

						<!-- test for the existence of detail id 230 - geographic type -->


						<!-- this is where the map goes -->
						<div id="map" style="width: 100%; height: 95%;"></div>

						<!--  /xsl:when>
						<xsl:otherwise>
							<xsl:if test="detail[@id=223]">


							</xsl:if>
						</xsl:otherwise>
					</xsl:choose -->

					<br/>
					<xsl:if test="detail[@id=255]">
						<xsl:for-each select="detail[@id=255]">
							<!-- role -->
							<em><xsl:value-of select="text()"/></em>
							<xsl:if test="position() != last()">,&#160; </xsl:if>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="detail[@id=266]">
						<xsl:call-template name="paragraphise">
							<xsl:with-param name="text">
								<xsl:value-of select="detail[@id=266]"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<br/>
					<br/>
				</td>
			</tr>
		</table>


		remove the map

		<!-- retrieve map data for main id and all related records -->
		<!-- script>
			var HEURIST = {};
		</script -->
		<!-- yes you do need this -->
		<!-- xsl:element name="script">
			<xsl:attribute name="src"><xsl:value-of select="$hbase"/>/mapper/tmap-data.php?w=all&amp;q=id:<xsl:value-of select="id"/>
				<xsl:for-each select="related">
					<xsl:text>,</xsl:text>
					<xsl:value-of select="id"/>
				</xsl:for-each>
			</xsl:attribute>
		</xsl:element>
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w"></script>
		<script src="{$hbase}/mapper/epoly.js"></script>
		<script src="{$hbase}/mapper/mapper.js"></script>

		<script>
			loadMap( { compact: true, highlight: [<xsl:value-of select="id"/>], onclick: function(record) { window.location = "<xsl:value-of select="$cocoonbase"/>/item/"+record.bibID+"/51?flavour=<xsl:value-of select="$flavour"/>"; } } );
		</script -->

		<div id="main" class="div-main">
			<div id="map" class="map"  style="width: 990px; height: 370px;"/>
			
			<div id="timeline" class="timeline" style="width: 880px; height: 300px; overflow-x:hidden;"/>
			<div id="timeline-zoom"></div>
		</div>
		
		
		<script type="text/javascript">
			
			window.onload = function () {
			loadZooms();
			onLoad();
			
			}
			function onLoad(tl1,tl2,id) {
			if(!tl1) {
			var tl1 = Timeline.DateTime.<xsl:choose><xsl:when test="detail[@id=565]"><xsl:value-of select="detail[@id=565]"/></xsl:when><xsl:otherwise>MONTH</xsl:otherwise></xsl:choose>;
			}
			if(!tl2) {
			var tl2 = Timeline.DateTime.<xsl:choose><xsl:when test="detail[@id=566]"><xsl:value-of select="detail[@id=566]"/></xsl:when><xsl:otherwise>YEAR</xsl:otherwise></xsl:choose>;
			}
			if(!id){
			var id = "<xsl:choose><xsl:when test="detail[@id=565]"><xsl:value-of select="detail[@id=565]"/></xsl:when><xsl:otherwise>MONTH</xsl:otherwise></xsl:choose>-<xsl:choose><xsl:when test="detail[@id=566]"><xsl:value-of select="detail[@id=566]"/></xsl:when><xsl:otherwise>YEAR</xsl:otherwise></xsl:choose>";          
			}                   
			
			TimeMap.init({
			mapId: "map", // Id of map div element (required)
			timelineId: "timeline", // Id of timeline div element (required)
			datasets:[ 
			{
			title: "blank",
			theme: TimeMapDataset.redTheme({
			eventIconPath: '../images/'
			}),
			data: {
			type: "kml", // Data to be loaded in KML - must be a local URL
			url: "http://heuristscholar.org<xsl:value-of select="$urlbase"/>/blank.kml" // KML file to load
			}
			}
			,
			
			<xsl:for-each select="pointer[@id=564]">
				
				{
				title: "<xsl:value-of select="title"/>",
				theme: TimeMapDataset.<xsl:choose><xsl:when test="detail[@id=567]"><xsl:value-of select="detail[@id=567]"/></xsl:when><xsl:otherwise>red</xsl:otherwise></xsl:choose>Theme({
				eventIconPath: '../images/'
				}),
				data: {
				type: "kml", // Data to be loaded in KML - must be a local URL
				url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmlfile/<xsl:value-of select="id"/>" // KML file to load
				}
				}
				,
			</xsl:for-each>
			
			
			{
			title: "Related records",
			theme: TimeMapDataset.greenTheme({
			eventIconPath: '../images/'
			}),
			data: {
			type: "kml", // Data to be loaded in KML - must be a local URL
			url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmltrans/relatedto:<xsl:value-of select="id"/>" // KML file to load
			}
			}
			,
			
			{
			title: "Other related records",
			theme: TimeMapDataset.redTheme({
			eventIconPath: '../images/'
			}),
			data: {
			type: "kml", // Data to be loaded in KML - must be a local URL
			url: "http://heuristscholar.org<xsl:value-of select="$urlbase"/>/blank.kml" // KML file to load
			}
			}],
			bandInfo:[ {
			width: "50%",
			intervalUnit: tl1,
			intervalPixels: 100,
			showEventText: true,
			trackHeight: 1.5,
			trackGap: 0.2
			}, {
			width: "50%",
			intervalUnit: tl2,
			intervalPixels: 400,
			showEventText: false,
			trackHeight: 0.5,
			trackGap: 0.1
			}]
			});
			
			document.getElementById(id).className = "timeline-zoom-a selected";
			
			}
			
			function loadZooms(){          
			var zoom = document.getElementById("timeline-zoom");       
			zoom.innerHTML = "&lt;b&gt;Timeline Views&lt;/b&gt; &lt;br/&gt;";
			createZoomLinks("Seconds / Minutes", Timeline.DateTime.SECOND, Timeline.DateTime.MINUTE, "SECOND-MINUTE");
			createZoomLinks("Minutes / Hours", Timeline.DateTime.MINUTE, Timeline.DateTime.HOUR, "MINUTE-HOUR");
			createZoomLinks("Hours / Days", Timeline.DateTime.HOUR, Timeline.DateTime.DAY, "HOUR-DAY");
			createZoomLinks("Days / Months", Timeline.DateTime.DAY, Timeline.DateTime.MONTH, "DAY-MONTH");
			createZoomLinks("Months / Years", Timeline.DateTime.MONTH, Timeline.DateTime.YEAR, "MONTH-YEAR");
			createZoomLinks("Years / Decades", Timeline.DateTime.YEAR, Timeline.DateTime.DECADE, "YEAR-DECADE");
			createZoomLinks("Decades / Centuries", Timeline.DateTime.DECADE, Timeline.DateTime.CENTURY, "DECADE-CENTURY");
			}
			
			function createZoomLinks(text, t1, t2, id){
			
			var zoom = document.getElementById("timeline-zoom");
			var a = document.createElement("a");
			a.href="#";
			a.id=id;
			a.name="timeline-zommies";
			a.className="timeline-zoom-a";
			a.onclick = function(){ 
			removeZoomSelect();
			onLoad(t1, t2, id);
			}
			var t = document.createTextNode(text);
			a.appendChild(t);
			zoom.appendChild(a);
			zoom.appendChild(document.createElement("br"));
			}
			
			function removeZoomSelect(){
			var elts = document.getElementsByName("timeline-zommies");
			for (var i = 0; i &lt; elts.length; ++i) {
			elts[i].className = "timeline-zoom-a";
			}
			}
			
		</script>


	</xsl:template>

	<!-- xsl:template name="person-summary" match="reference[reftype/@id=55]">
		<table>
			<tr>
				<td>
					<xsl:if test="detail[@id=223]">

						<div style="float: left;">
							<xsl:for-each select="detail[@id=223]">
								<img src="{file_thumb_url}" vspace="10" hspace="10"/>
							</xsl:for-each>
						</div>
					</xsl:if>

					<h1><xsl:value-of select="title"/></h1>
				</td>
			</tr>
		</table>
	</xsl:template -->

</xsl:stylesheet>
