<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


    <xsl:template name="kml" match="reference[reftype/@id=103 or reftype/@id=51 or reftype/@id=165]">

        <div id="main" class="div-main">
            <div id="map" class="map"  style="width: 990px; height: 370px;"/>
            <div id="timeline" class="timeline" style="width: 880px; height: 300px; overflow-x:hidden;"/>
            <div id="timeline-zoom"></div>

        </div>


        <script type="text/javascript">

           window.onload = function () {

               createCrumb({recId: <xsl:value-of select="//export/references/reference/id"/>, recTitle: '<xsl:value-of select="//export/references/reference/title"/>', recType: '<xsl:value-of select="//export/references/reference/reftype/@id"/>', hasGeoData:'<xsl:value-of select="//export/references/reference/detail[@id=230]"/>'});
               loadZooms();
               loadSavedView();

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



           var dataSets = [];

          //from here down we are constructing various timeMap objects for our map

          //a blank timeMap object
           var blankDataSet =   {
           title: "blank",
          			theme: TimeMapDataset.redTheme(),
           data: {
           type: "kml", // Data to be loaded in KML - must be a local URL
           url: "http://heuristscholar.org<xsl:value-of select="$urlbase"/>/blank.kml" // KML file to load
            }
            };

            dataSets.push (blankDataSet);


            <xsl:for-each select="pointer[@id=564]">
	                	dataSets.push ({
                title: "<xsl:value-of select="title"/>",
	                		theme: TimeMapDataset.<xsl:choose><xsl:when test="detail[@id=567]"><xsl:value-of select="detail[@id=567]"/></xsl:when><xsl:otherwise>red</xsl:otherwise></xsl:choose>Theme(),
                data: {
                type: "kml", // Data to be loaded in KML - must be a local URL
                url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmlfile/<xsl:value-of select="id"/>" // KML file to load
                }
                });
            </xsl:for-each>

            //record in focus timeMap object
            var focusRecord =  {
            title: "Focus record",
            <xsl:choose>
                <xsl:when test="detail[@id=567]">
                    				theme: TimeMapDataset.<xsl:value-of select="detail[@id=567]"/>Theme(),
                    data: {
                    type: "kml", // Data to be loaded in KML - must be a local URL
                    url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmlfile/<xsl:value-of select="id"/>" // KML file to load
                    }
                </xsl:when>
                <xsl:otherwise>
                    theme: TimeMapDataset.redTheme({
                    iconImage:'<xsl:value-of select="$timelineIconImage"/>',
                    color:'<xsl:value-of select="$timelineColour"/>'
                    				}),
                    data: {
                    type: "kml", // Data to be loaded in KML - must be a local URL
                    url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmltrans/id:<xsl:value-of select="id"/>" // KML file to load
                    }
                </xsl:otherwise>
           </xsl:choose>

            };

            //related records Object
            var relatedRecords =  {
            title: "Related records",
            theme: TimeMapDataset.redTheme({
            iconImage:'<xsl:value-of select="$timelineRelatedIconImage"/>',
            color:'<xsl:value-of select="$timelineRelatedColour"/>'
            			}),
            data: {
            type: "kml", // Data to be loaded in KML - must be a local URL
            url: "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmltrans/relatedto:<xsl:value-of select="id"/>" // KML file to load
            }
            };



            // and time map objects based on breadcrumbs!
           HAPI.PJ.retrieve("bcrumb", function (name, value){
           			if (value)  {
              				value.reverse();
              				for (var i = 1; i &lt; (value.length &lt; parseInt(maptrackCrumbNumber + 1) ? value.length : parseInt(maptrackCrumbNumber + 1)); ++i) {
           var link;

           if (value[i].recType &amp;&amp; value[i].recType == '165') {
	      link = "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmlfile/" + value[i].recId;
	  } else {
	      link = "http://heuristscholar.org<xsl:value-of select="$cocoonbase"/>/kmltrans/id:" + value[i].recId;
	  }

              var timeCrumb = {
                  title: "Breadcrumb"+i,
                  theme: TimeMapDataset.redTheme({
                  color:crumbColours[i-1]
                   					}),
                data: {
                type: "kml", // Data to be loaded in KML - must be a local URL
                url:   (value[i]? link :  "http://heuristscholar.org<xsl:value-of select="$urlbase"/>/blank.kml") // KML file to load
                }
                }

                dataSets.push(timeCrumb);
           }
           			}

            dataSets.push (focusRecord);
            dataSets.push (relatedRecords);

           // initialise timemap

            TimeMap.init({
            mapId: "map", // Id of map div element (required)
            timelineId: "timeline", // Id of timeline div element (required)
            datasets:dataSets,
            bandInfo:[ {
            width: "50%",
            intervalUnit: tl1,
            intervalPixels: 100,
            showEventText: false,
            trackHeight: 1.5,
            trackGap: 0.2
            }, {
            width: "50%",
            intervalUnit: tl2,
            intervalPixels: 200,
            showEventText: false,
            trackHeight: 1.5,
            trackGap: 0.2
            }]
            });
            }); //end hapi
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
                    saveZoomView(t1, t2, id);
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
</xsl:stylesheet>
