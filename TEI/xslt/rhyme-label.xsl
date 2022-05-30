<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    
    <!--   java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:. xslt/rhyme-label.xsl -o:label - -suppressXsltNamespaceCheck:on

    -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="rhyme/@label">
        <xsl:if test="current() ne ..//text()">
            <xsl:attribute name="label"><xsl:value-of select="current()"/></xsl:attribute>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>