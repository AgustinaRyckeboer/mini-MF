<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.w3.org/1999/xhtml"
    >
    
  <xsl:output method="html" encoding="utf-8" omit-xml-declaration="yes"></xsl:output>
    
    <xsl:template match="/">
        <xsl:variable name="doc_id" select="//msItem/idno/@xml:id"/> <!-- Recuperamos el id del documento en una variable para nombrar el archivo de salida -->
        <!-- Redirigir el resultado hacia un archivo -->        
        <xsl:result-document method="html" encoding="utf-8"
            href="./_cantigas/{$doc_id}-idno.html" omit-xml-declaration="yes">---
layout: pregunta_respuesta
title: <xsl:apply-templates select="//title[1]"/> / incipit del otro poema        
permalink: <xsl:apply-templates select="//$doc_id"/>-idno/
type: cantiga
button: siquieromiboton
---
        
            <div class="row clearfix">
                <div class="col-right px-3">
                    <h1><xsl:apply-templates select="//title[1]"/></h1>
                </div>
            </div>
            
        <div class="row clearfix">
        <div class="col-right px-3">
            <p class="rubrica">
                <xsl:apply-templates select="//head"/>
            </p>
        </div>
        </div>

        <div class="row clearfix">
        <div class="col-right px-3">
            <xsl:apply-templates select="//lg[@type='cantiga']"/>
        </div>
        </div>  

        <!-- <div class="row clearfix">
        <div class="col-right px-3">
            <xsl:apply-templates select="//lg//lg"/>
        </div>
        </div>   -->

        
        
   <!-- fila de audio -->
<div class="row clearfix">
   <div class="col-center px-3">
     <div class="py-4">
     <h3>
     <xsl:apply-templates select="//title"/>
     </h3>
     <p class="rubrica">Melodía: Cantiga de Santa María nro, título</p>
     <audio controls=""><source src="{{{site.baseurl}}}/assets/audios/{$doc_id}.mp3" type="audio/mpeg">Your browser does not support the audio element.</source></audio><!-- cambiar path al audio -->
     </div>
   </div>
 </div>
 
 <!-- fila de imagenes -->
 <div class="row clearfix">
 
   <div class="col-center px-3">
     <div class="highlight">
      <a href="../assets/partituras/{$doc_id}.jpg"><img src="../assets/partituras/{$doc_id}.jpg"></img></a>
    </div>
   </div>
   </div>
            
            <div class="row clearfix">
                <div class="col-right px-3">
                    <div class="px-3 py-3">
                        <dl>
                            <dt>Autor</dt>
                            <dd><xsl:apply-templates select="//author"/></dd>
                            <dt>Editor/a del texto</dt>
                            <dd><xsl:apply-templates select="//editor[@resp='crítica']"/></dd>
                            <dt>Editor/a del contrafactum</dt>
                            <dd><xsl:apply-templates select="concat(//editor[@resp='contrafactum'][1],' y ',//editor[@resp='contrafactum'][2])"/></dd>
                            <dt>Repositorio</dt>
                            <dd><xsl:apply-templates select="//repository"/></dd>
                            <dt>Identificador</dt>
                            <dd><xsl:apply-templates select="//$doc_id"/></dd>
                            <dt>Localización manuscrito</dt>
                            <dd><xsl:apply-templates select="concat(//locus[1],' / ', //locus[2])"/></dd>
                            <dt>Tipo</dt>
                            <dd><xsl:apply-templates select="//lg/@subtype"/></dd>  
                        </dl>
                    </div>
                </div>
            </div> 
            
           <!-- <xsl:apply-templates select="//lg"/>--> <!-- Indicamos que las transformaciones de abajo se van a aplicar al elemento lg -->
           <!-- Tuve que comentar esta línea porque si no me repetía tres veces el texto del poema en la salida html-->
            
            
        </xsl:result-document>
        <!-- Redirigir el resultado hacia un archivo -->
    </xsl:template>
    
    
    <!-- Transformaciones -->
 
    
    <xsl:template match="//graphic">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="@url"/>
                </xsl:attribute>
                <xsl:apply-templates/>        
            </img>
        </a>
    </xsl:template>
    

    

    
    <!-- <xsl:template match="//lg//lg">
        <div class="estrofa">
            <p class="info">
            <xsl:value-of select="concat('Tipo de estrofa: ', @type, '; esquema métrico: ', @met, '; esquema rimático: ', @rhyme)"/>
            </p>
            <xsl:apply-templates/>
        </div>
    </xsl:template> -->
   
    <xsl:template match="//lg//lg">
        <div class="estrofa">
            <xsl:apply-templates/>
        </div>
    </xsl:template>   
   
    <xsl:template match="//lg//l">
        <p class="verso">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


    <xsl:template match="//l[@rendition='estribillo']">
    <p class="estribillo">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="//lg[@type='cantiga']">     
        <p class="info"><xsl:value-of select="concat('Unisonancia: ', @unisonancia)"/></p>
        <p class="info"><xsl:value-of select="concat('Isometrismo: ', @isometrismo)"/></p>
        <p class="info"><xsl:value-of select="concat('Isoestrofismo: ', @isoestrofismo)"/></p>
        <p class="info"><xsl:value-of select="concat('Asonancia: ', @asonancia)"/></p>
        <p class="info"><xsl:value-of select="concat('Esquema métrico: ', @met)"/></p>
        <p class="info"><xsl:value-of select="concat('Esquema rimático: ', @rhyme)"/></p>
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//note">
        <p class="nota">
            <xsl:apply-templates/>
        </p>
    </xsl:template>   
   
    <xsl:template match="//rhyme">
        <span> 
            <xsl:attribute name="class">
                <xsl:value-of select="concat('rima_', @label)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>   
   
</xsl:stylesheet>