<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:variable name="hbase">http://heuristscholar.org/heurist</xsl:variable>
    <xsl:variable name="urlbase">/relbrowser</xsl:variable>
    <xsl:variable name="cocoonbase">/cocoon/relbrowser</xsl:variable>
    <xsl:variable name="hapi-key">147983c93cdd221dd23f9a93884034f2246b7e01</xsl:variable>
    <xsl:variable name="instance"></xsl:variable>
    <xsl:variable name="instance_prefix"></xsl:variable>
    <xsl:variable name="site-title">rel-browser</xsl:variable>
    <xsl:variable name="home-id">205</xsl:variable>


    <!-- custom timemap colours -->

    <xsl:variable name="timelineColour">purple</xsl:variable>
    <xsl:variable name="timelineIconImage"><xsl:value-of select="$urlbase"/>/images/purple-dot.png</xsl:variable>

    <xsl:variable name="timelineRelatedColour">yellow</xsl:variable>
    <xsl:variable name="timelineRelatedIconImage"><xsl:value-of select="$urlbase"/>/images/yellow-dot.png</xsl:variable>

    <xsl:variable name="crumbColours">
        '#ff0000',
        '#ff3333',
        '#ff6666',
        '#ff9999',
        '#ffcccc'
    </xsl:variable>

</xsl:stylesheet>
