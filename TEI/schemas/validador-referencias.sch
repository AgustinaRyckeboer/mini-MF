<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="vocabulario" value="doc('../auxiliar/vocabulario.xml')"/>
    <let name="referencias" value="doc('../auxiliar/referencias.xml')"/>
    <let name="termos" value="$vocabulario//tei:body//tei:term/@n"/>
    <let name="persoas" value="$referencias//tei:person/concat('#', @xml:id)"/>
    <pattern>
        <rule context="tei:term/@cRef">
            <assert test=". = $termos">El término no está declarado. Comprueba que no haya un error tipográfico o que el término esté indexado</assert>
        </rule>
        <rule context="tei:persName/@ref">
            <assert test=". = $persoas">Este agente no está declarado. Comprueba que no haya un error tipográfico o que esta persona esté indexada</assert>
        </rule>
        <rule context="tei:sp/@who">
            <assert test=". = $persoas">Este agente no está declarado. Comprueba que no haya un error tipográfico o que esta persona esté indexada</assert>
        </rule>
        <rule context="tei:rs/@ref">
            <assert test=". = $persoas">Esta referencia no está declarada. Comprueba que no haya un error tipográfico o que la referencia esté indexada</assert>
        </rule>
        
        <!-- Regras adicionais -->
        
        <rule context="tei:origDate">
            <assert test="number(@notBefore) lt number(@notAfter)">La correlación de fechas es errónea</assert>
        </rule>
        <rule context="tei:lg[not(@type eq 'poema')]">
            <assert test="count(tokenize(@met, ',')) eq count(tei:l)">El número de versos no coincide con el patrón métrico</assert>
            <assert test="string-length(@rhyme) eq count(tei:l)">El número de versos no coincide con el patrón rimático</assert>
        </rule>
        <rule context="tei:msItem">
            <assert test="tei:idno">Identificador del texto</assert>
        </rule>
        <rule context="tei:titleStmt">
            <report test="count(tei:author/@ref) lt 1">Falta identificación del autor</report>
            <assert test="tei:author/@ref = $persoas">El autor no está declarado. Comprueba que no haya un error tipográfico o que esta persona esté indexada</assert>
        </rule>
    </pattern>
</schema>