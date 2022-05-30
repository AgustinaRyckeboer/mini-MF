<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:template match="/">
        <xsl:result-document href="{'../_includes/script-rimas-from-xsl.html'}" omit-xml-declaration="yes">
            <xsl:text>&lt;script&gt;&#x0A;</xsl:text>
            <xsl:for-each-group select="//rhyme" group-by="@label">
                
                <xsl:text>&#x0A;</xsl:text>
                <xsl:value-of select="concat('$(&quot;.rima_', @label,'&quot;).hover')"/>
                <xsl:text>(&#x0A;</xsl:text>
                <xsl:text>function()&#x0A;</xsl:text>
                <xsl:text>{&#x0A;</xsl:text>
                <xsl:value-of select="concat('$(&quot;.rima_', @label,'&quot;).css(&quot;font-weight&quot;,&quot;bold&quot;);')"/>
                <xsl:text>},&#x0A;</xsl:text>
                <xsl:text>function()&#x0A;</xsl:text>
                <xsl:text>{&#x0A;</xsl:text>
                <xsl:value-of select="concat('$(&quot;.rima_', @label,'&quot;).css(&quot;font-weight&quot;,&quot;normal&quot;);')"/>
                <xsl:text>}&#x0A;</xsl:text>
                <xsl:text>),&#x0A;</xsl:text>
            
            </xsl:for-each-group>
            <xsl:text>&lt;/script&gt;</xsl:text>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>
