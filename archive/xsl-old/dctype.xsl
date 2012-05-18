<?xml version="1.0" encoding="ISO-8859-1"?>

<!--

    description: This style sheet generates DCMI Type Vocabulary in RDFS.
    creator: nagamori@slis.tsukuba.ac.jp

-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dcam="http://purl.org/dc/dcam/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
>

<xsl:include href="common-templates.xsl"/>

<xsl:param name="target-ns" select="'http://purl.org/dc/dcmitype/'"/>
<xsl:param name="header" select="''"/>

<xsl:template match="/">
    <xsl:apply-templates select="dc"/>
</xsl:template>

<xsl:template match="dc">
    <xsl:call-template name="print-doctype"/>
    <rdf:RDF>
	<xsl:call-template name="Heading">
	    <xsl:with-param name="header" select="$header"/>
	</xsl:call-template>
	<xsl:apply-templates select="term"/>
    </rdf:RDF>
</xsl:template>

<xsl:template match="term">
    <xsl:variable name="irb" select="normalize-space(Is-Replaced-By)"/>
    <xsl:variable name="ns" select="normalize-space(Namespace)"/>
    <xsl:if test="$irb = '' and $ns = $target-ns">
	<rdf:Description rdf:about="{normalize-space(URI)}">
	  <xsl:call-template name="print-properties-common" />
	</rdf:Description>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
