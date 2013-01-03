<?xml version="1.0" encoding="ISO-8859-1"?>

<!--

    description: This style sheet generates DCES in RDFS.
    creator: nagamori@slis.tsukuba.ac.jp

-->

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dcam="http://purl.org/dc/dcam/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:owl="http://www.w3.org/2002/07/owl#"
>

<xsl:include href="common-templates.xsl"/>

<xsl:param name="target-ns" select="'http://purl.org/dc/elements/1.1/'"/>
<xsl:param name="header" select="''" />

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
	<xsl:variable name="element_name">
	  <xsl:choose>
	    <xsl:when test="Type-of-Term = 'http://www.w3.org/2000/01/rdf-schema#Class'">
	      <xsl:text>rdfs:Class</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>rdf:Description</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<xsl:element name="{$element_name}">
	  <xsl:attribute name="rdf:about">
	    <xsl:value-of select="normalize-space(URI)" />
	  </xsl:attribute>
	  <xsl:call-template name="print-properties-common" />
	</xsl:element>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
