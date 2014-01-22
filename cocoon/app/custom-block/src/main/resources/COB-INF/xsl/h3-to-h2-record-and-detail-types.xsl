<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- identity transform -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

    <xsl:template match="record/type">
        <xsl:variable name="id">
            <xsl:if test="@id='1'">52</xsl:if>
            <xsl:if test="@id='2'">1</xsl:if>
            <xsl:if test="@id='5'">74</xsl:if>
            <xsl:if test="@id='11'">168</xsl:if>
            <xsl:if test="@id='13'">98</xsl:if>
            <xsl:if test="@id='15'">99</xsl:if>
            <xsl:if test="@id='23'">165</xsl:if>
            <xsl:if test="@id='24'">153</xsl:if>
            <xsl:if test="@id='25'">151</xsl:if>
            <xsl:if test="@id='26'">150</xsl:if>
            <xsl:if test="@id='27'">91</xsl:if>
            <xsl:if test="@id='28'">103</xsl:if>
            <xsl:if test="@id='29'">152</xsl:if>
        </xsl:variable>
        <type id="{$id}" h3id="{@id}"><xsl:value-of select="."/></type>
    </xsl:template>

    <xsl:template match="record/detail | record/reversePointer">
        <xsl:variable name="id">
            <xsl:if test="@id='1'">160</xsl:if>
            <xsl:if test="@id='2'">173</xsl:if>
            <xsl:if test="@id='3'">303</xsl:if>
            <xsl:if test="@id='4'">191</xsl:if>
            <xsl:if test="@id='5'">199</xsl:if>
            <xsl:if test="@id='6'">200</xsl:if>
            <xsl:if test="@id='7'">202</xsl:if>
            <xsl:if test="@id='9'">166</xsl:if>
            <xsl:if test="@id='10'">177</xsl:if>
            <xsl:if test="@id='11'">178</xsl:if>
            <xsl:if test="@id='13'">199</xsl:if>
            <xsl:if test="@id='17'">256</xsl:if>
            <xsl:if test="@id='20'">399</xsl:if>
            <xsl:if test="@id='28'">230</xsl:if>
            <xsl:if test="@id='29'">289</xsl:if>
            <xsl:if test="@id='30'">618</xsl:if>
            <xsl:if test="@id='31'">585</xsl:if>
            <xsl:if test="@id='32'">586</xsl:if>
            <xsl:if test="@id='33'">587</xsl:if>
            <xsl:if test="@id='34'">339</xsl:if>
            <xsl:if test="@id='35'">290</xsl:if>
            <xsl:if test="@id='38'">221</xsl:if>
            <xsl:if test="@id='39'">223</xsl:if>
            <xsl:if test="@id='42'">322</xsl:if>
            <xsl:if test="@id='44'">329</xsl:if>
            <xsl:if test="@id='45'">330</xsl:if>
            <xsl:if test="@id='46'">539</xsl:if>
            <xsl:if test="@id='47'">540</xsl:if>
            <xsl:if test="@id='52'">359</xsl:if>
            <xsl:if test="@id='61'">508</xsl:if>
            <xsl:if test="@id='74'">568</xsl:if>
            <xsl:if test="@id='75'">523</xsl:if>
            <xsl:if test="@id='76'">171</xsl:if>
            <xsl:if test="@id='77'">176</xsl:if>
            <xsl:if test="@id='78'">193</xsl:if>
            <xsl:if test="@id='79'">197</xsl:if>
            <xsl:if test="@id='80'">218</xsl:if>
            <xsl:if test="@id='81'">231</xsl:if>
            <xsl:if test="@id='82'">304</xsl:if>
            <xsl:if test="@id='83'">365</xsl:if>
            <xsl:if test="@id='84'">368</xsl:if>
            <xsl:if test="@id='85'">526</xsl:if>
            <xsl:if test="@id='86'">527</xsl:if>
            <xsl:if test="@id='87'">528</xsl:if>
            <xsl:if test="@id='88'">529</xsl:if>
            <xsl:if test="@id='89'">531</xsl:if>
            <xsl:if test="@id='90'">538</xsl:if>
            <xsl:if test="@id='91'">564</xsl:if>
            <xsl:if test="@id='92'">569</xsl:if>
            <xsl:if test="@id='93'">588</xsl:if>
            <xsl:if test="@id='94'">590</xsl:if>
            <xsl:if test="@id='95'">591</xsl:if>
            <xsl:if test="@id='97'">179</xsl:if>
        </xsl:variable>
        <xsl:if test="name() = 'detail'">
            <detail id="{$id}" h3id="{@id}" type="{@type}" name="{@name}" inverse="{@inverse}"><xsl:apply-templates/></detail>
        </xsl:if>
        <xsl:if test="name() = 'reversePointer'">
            <reversePointer id="{$id}" h3id="{@id}" type="{@type}" name="{@name}"><xsl:apply-templates/></reversePointer>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
