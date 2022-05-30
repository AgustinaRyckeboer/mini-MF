<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:variable name="unicas">
            <xsl:apply-templates mode="eliminar-copias"/>
        </xsl:variable>
        <xsl:apply-templates select="$unicas" mode="ordenar"/>
    </xsl:template>
    <xsl:template match="@* | node()" mode="eliminar-copias">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="eliminar-copias"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="entryFree[term/@n = preceding-sibling::entryFree/term/@n]"
        mode="eliminar-copias"/>

    <xsl:template match="@* | node()" mode="ordenar">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="ordenar"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="body/div" mode="ordenar">
        <div corresp="#PMC">
            <xsl:for-each select="entryFree">
                <xsl:sort select="term/number(@n)"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </div>
    </xsl:template>
</xsl:stylesheet>
