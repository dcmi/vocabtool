<?xml version="1.0" encoding="ISO-8859-1"?>
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

<xsl:param name="target-ns" select="'http://purl.org/dc/terms/'"/>
<xsl:param name="header" select="''"/>
<xsl:param name="properties" select="''"/>
<xsl:param name="ses" select="''"/>
<xsl:param name="ves" select="''"/>

<!-- 
     NOTE: 
     primary xml data source is dcterms-classes.xml (see build.xml). 
     The following three lines import other xml data sources via document
     function.
-->
<xsl:variable name="properties-doc" select="document($properties)/dc"/>
<xsl:variable name="ses-doc" select="document($ses)/dc"/>
<xsl:variable name="ves-doc" select="document($ves)/dc"/>

<xsl:template match="/">
    <xsl:apply-templates select="dc"/>
</xsl:template>

<xsl:template match="dc">
    <xsl:call-template name="print-doctype"/>
    <rdf:RDF>
	<xsl:call-template name="Heading">
	    <xsl:with-param name="header" select="$header"/>
	</xsl:call-template>
        <xsl:call-template name="print-terms">
	    <xsl:with-param name="doc" select="$properties-doc"/>
	</xsl:call-template>
        <xsl:call-template name="print-terms">
	    <xsl:with-param name="doc" select="/dc"/>
	</xsl:call-template>
        <xsl:call-template name="print-terms">
	    <xsl:with-param name="doc" select="$ses-doc"/>
	</xsl:call-template>
        <xsl:call-template name="print-terms">
	    <xsl:with-param name="doc" select="$ves-doc"/>
	</xsl:call-template>
    </rdf:RDF>
</xsl:template>

<xsl:template name="print-terms">
  <xsl:param name="doc" select="''" />
  <xsl:for-each select="$doc/term">
      <xsl:variable name="irb" select="normalize-space(Is-Replaced-By)"/>
      <xsl:variable name="ns" select="normalize-space(Namespace)"/>
      <xsl:if test="$irb = '' and $ns = $target-ns">
	  <xsl:call-template name="rdf-description"/>
      </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="rdf-description">
  <!--
       NOTE:
       'print-properties-common' template makes an RDFS definition which is
       defined in common-templates.xsl.
       It is required to modify 'print-properties-common' when you add a new
       element (e.g. EquivalentProperty) to xml data sources.
  -->
  <rdf:Description rdf:about="{normalize-space(URI)}">
    <xsl:call-template name="print-properties-common" />
  </rdf:Description>
</xsl:template>

</xsl:stylesheet>
