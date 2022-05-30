<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">

    <!--   java -jar ../../SaxonHE9-6-0-7J/saxon9he.jar -s:. xslt/extraccion-terminos.xsl -o:auxiliar 

    -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <xsl:result-document href="{'../auxiliar/vocabulario2.xml'}">
            <TEI>
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title>Vocabulario terminológico: poética</title>
                            <respStmt>
                                <resp>Recolección de datos, modelado y codificación</resp>
                                <name role="editor">Gimena del Rio Riande</name>
                            </respStmt>
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
                    <encodingDesc>
                        <refsDecl xml:id="PMC">
                            <cRefPattern matchPattern="(.+)"
                                replacementPattern="http://vocabularios.caicyt.gov.ar/pmc/$1">
                                <p/>
                            </cRefPattern>
                        </refsDecl>
                    </encodingDesc>
                </teiHeader>
                <text>
                    <body>
                        <div corresp="#PMC">
                            <xsl:for-each select="collection('..')">
                                <xsl:apply-templates select="//term"/>
                            </xsl:for-each>
                        </div>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    <xsl:template match="term">
        <entryFree>
            <xsl:copy-of select="."/>
        </entryFree>
    </xsl:template>
</xsl:stylesheet>
