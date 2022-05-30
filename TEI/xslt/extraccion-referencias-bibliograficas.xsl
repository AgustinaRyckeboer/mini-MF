<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">

    <!--   java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:. xslt/extraccion-referencias-bibliograficas.xsl -o:auxiliar - -suppressXsltNamespaceCheck:on

    -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="{'../auxiliar/bibliografia.xml'}">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Índice bibliográfico</title>
                        </titleStmt>
                        <publicationStmt>
                            <authority>Gimena del Rio Riande</authority>
                            <availability>
                                <licence>
                                    <ref target="http://creativecommons.org/licenses/by-nc-sa/4.0/"
                                        >Creative Commons Attribution-NonCommercial-ShareAlike 4.0
                                        International</ref>
                                </licence>
                            </availability>
                        </publicationStmt>
                        <sourceDesc>
                            <p>Born digital</p>
                        </sourceDesc>
                    </fileDesc>
                </teiHeader>
                <text>
                    <body>
                        <listBibl>
                            <xsl:for-each select="collection('..')">
                                <xsl:apply-templates select="//bibl"/>
                            </xsl:for-each>
                        </listBibl>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="bibl">
        <xsl:copy-of select="."/>
    </xsl:template>
</xsl:stylesheet>
