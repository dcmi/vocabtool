<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dcam="http://purl.org/dc/dcam/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    exclude-result-prefixes="xml"
>

<xsl:output method="xml" encoding="UTF-8" indent="yes" />

<xsl:param name="xml-lang-for-date" select="'no'"/> 
<xsl:param name="language" select="'en'" />

<!-- legacy use (See Qualifies)  -->
<!-- no longer used -->
<!--
<xsl:param name="class-list" select="'../xml/mn-dcmi-class-list.xml'" />
<xsl:variable name="class-doc" select="document($class-list)/dc"/>
-->

<xsl:template name="print-doctype">
<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE rdf:RDF [
    &lt;!ENTITY rdfns 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
    &lt;!ENTITY rdfsns 'http://www.w3.org/2000/01/rdf-schema#'>
    &lt;!ENTITY dcns 'http://purl.org/dc/elements/1.1/'>
    &lt;!ENTITY dctermsns 'http://purl.org/dc/terms/'>
    &lt;!ENTITY dctypens 'http://purl.org/dc/dcmitype/'>
    &lt;!ENTITY dcamns 'http://purl.org/dc/dcam/'>
    &lt;!ENTITY skosns 'http://www.w3.org/2004/02/skos/core#'>
]>
</xsl:text>
</xsl:template>

<xsl:template name="literal-or-resource">
    <xsl:param name="use-xml-lang" select="'yes'"/>
    <xsl:variable name="tmp" select="normalize-space(.)"/>
    <xsl:choose>
        <xsl:when test="starts-with($tmp,'http://') or starts-with($tmp,'ftp://') or starts-with($tmp,'mailto:')">
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
	    <xsl:if test="$use-xml-lang = 'yes'">
	    	<!-- <xsl:attribute name="xml:lang" namespace="whatever"> -->
		<xsl:attribute name="xml:lang">
		    <xsl:value-of select="$language"/>
		</xsl:attribute>
	    </xsl:if>
            <xsl:value-of select="."/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="Heading">
    <rdf:Description rdf:about="{$target-ns}">
	<xsl:choose>
	    <xsl:when test="$target-ns = 'http://purl.org/dc/elements/1.1/'">
		<xsl:apply-templates select="Title"/>
		<xsl:apply-templates select="Creator"/>
		<xsl:apply-templates select="Identifier"/>
		<xsl:apply-templates select="Date-Modified"/>
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:apply-templates select="Title"/>
		<xsl:apply-templates select="Creator"/>
		<xsl:apply-templates select="Date-Modified"/>
		<xsl:apply-templates select="Description"/>
	    </xsl:otherwise>
	</xsl:choose>
    </rdf:Description>
</xsl:template>

<xsl:template name="Heading">
    <xsl:param name="header" select="'NA'"/>
    <xsl:variable name="hdoc" select="document($header)/H1"/>
    <rdf:Description rdf:about="{$target-ns}">
	<xsl:apply-templates select="$hdoc/*"/>
    </rdf:Description>
</xsl:template>

<!--
    Mapping rules among Tom's elements, dc, dcq, rdf and rdfs.

    Title		= dcterms:title
    Creator		= dcterm:creator (how about "label"?)
    Identifier		= dcterm:identifier
    Replaces		= dcterms:replaces
    Document-Status	= (not used)
    Date-Modified	= dcterms:modified
    Description		= dcterms:description

    Anchor		= (not used)
    URI			= rdf:about of the rdf:Property or rdfs:Class
    Namespace		= rdfs:isDefinedBy
    Name		= (not used)
    Label		= rdfs:label
    Definition		= rdfs:comment
    Note		= skos:note (was rdfs:comment)
    See			= rdfs:seeAlso
    Comment		= dcterms:description
    References		= dcterms:references
    Type-of-Term	= rdf:type (was dc:type)
    Instance-Of		= rdf:type
    Qualifies		= (deleted) (was rdf:type)
    Status		= (not used)
    Date-Issued		= dcterms:issued 
    Date-Modified	= dcterms:modified
    Decision		= (not used)
    Version		= dcterms:hasVersion
    Replaces		= (not used)
    Is-Replaced-By	= (in use only for selecting elements.
			   See an xsl:template for "term".)
    
    Publisher		= dcterms:publisher
    Language		= dcterms:language
    Source		= dcterms:source
    Is-Required-By	= dcterms:isRequiredBy
    Is-Referenced-By	= dcterms:isReferencedBy
    Requires		= dcterms:Requires
    Narrower-Than	= rdfs:subClassOf

    Has-Domain		= rdfs:domain
    Has-Range		= rdfs:range
    Member-Of		= dcam:memberOf
    Refines		= rdfs:subPropertyOf
  -->

<xsl:template match="Title">
    <dcterms:title>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:title>
</xsl:template>

<xsl:template match="Creator">
    <dcterms:creator>
	<xsl:choose>
	    <xsl:when test="@label">
		<xsl:value-of select="@label"/> (<xsl:value-of select="."/>)
	    </xsl:when>
	    <xsl:otherwise>
		<xsl:call-template name="literal-or-resource"/>
	    </xsl:otherwise>
	</xsl:choose>
    </dcterms:creator>
</xsl:template>

<xsl:template match="Identifier">
    <dcterms:identifier>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:identifier>
</xsl:template>

<xsl:template match="Replaces">
    <dcterms:replaces>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:replaces>
</xsl:template>

<xsl:template match="Document-Status">
    <!--
    <dcterms:description><xsl:value-of select="."/></dcterms:description>
    -->
</xsl:template>

<xsl:template match="Description">
    <dcterms:description>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:description>
</xsl:template>

<xsl:template match="Date-Modified">
    <dcterms:modified>
	<xsl:call-template name="literal-or-resource">
	    <xsl:with-param name="use-xml-lang" select="$xml-lang-for-date"/>
	</xsl:call-template>
    </dcterms:modified>
</xsl:template>

<xsl:template match="Version">
    <dcterms:hasVersion>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:hasVersion>
</xsl:template>

<xsl:template match="Label">
    <rdfs:label>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:label>
</xsl:template>

<xsl:template match="Definition">
    <rdfs:comment>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:comment>
</xsl:template>

<xsl:template match="Note">
    <skos:note>
	<xsl:call-template name="literal-or-resource"/>
    </skos:note>
</xsl:template>

<xsl:template match="See">
    <rdfs:seeAlso>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:seeAlso>
</xsl:template>

<xsl:template match="Comment">
    <dcterms:description>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:description>
</xsl:template>

<xsl:template match="Namespace">
    <rdfs:isDefinedBy>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:isDefinedBy>
</xsl:template>

<xsl:template match="References">
    <dcterms:references>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:references>
</xsl:template>

<xsl:template match="Type-of-Term">
    <rdf:type>
	<xsl:call-template name="literal-or-resource"/>
    </rdf:type>
</xsl:template>

<xsl:template match="Instance-Of">
    <rdf:type>
	<xsl:call-template name="literal-or-resource"/>
    </rdf:type>
</xsl:template>

<xsl:template match="Qualifies">
    <!--
    <rdf:type>
	<xsl:attribute name="rdf:resource">
	    <xsl:value-of select="$class-doc/class[URI/text()=current()/text()]/rdfs:Class/@rdf:about"/>
	</xsl:attribute>
    </rdf:type>
    -->
</xsl:template>

<xsl:template match="Date-Issued">
    <dcterms:issued>
	<xsl:call-template name="literal-or-resource">
	    <xsl:with-param name="use-xml-lang" select="$xml-lang-for-date"/>
	</xsl:call-template>
    </dcterms:issued>
</xsl:template>

<xsl:template match="Refines">
    <rdfs:subPropertyOf>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:subPropertyOf>
</xsl:template>

<xsl:template match="Publisher">
    <dcterms:publisher>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:publisher>
</xsl:template>

<xsl:template match="Language">
    <dcterms:language>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:language>
</xsl:template>

<xsl:template match="Source">
    <dcterms:source>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:source>
</xsl:template>

<xsl:template match="Is-Required-By">
    <dcterms:isRequiredBy>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:isRequiredBy>
</xsl:template>

<xsl:template match="Is-Referenced-By">
    <dcterms:isReferencedBy>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:isReferencedBy>
</xsl:template>

<xsl:template match="Requires">
    <dcterms:requires>
	<xsl:call-template name="literal-or-resource"/>
    </dcterms:requires>
</xsl:template>

<xsl:template match="Narrower-Than">
    <rdfs:subClassOf>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:subClassOf>
</xsl:template>

<xsl:template match="Has-Domain">
    <rdfs:domain>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:domain>
</xsl:template>

<xsl:template match="Has-Range">
    <rdfs:range>
	<xsl:call-template name="literal-or-resource"/>
    </rdfs:range>
</xsl:template>

<xsl:template match="Member-Of">
    <dcam:memberOf>
	<xsl:call-template name="literal-or-resource"/>
    </dcam:memberOf>
</xsl:template>

<xsl:template name="print-properties-common">
  <xsl:apply-templates select="Label"/>
  <xsl:apply-templates select="Definition"/>
  <xsl:apply-templates select="Comment"/>
  <xsl:apply-templates select="Namespace"/>
  <xsl:apply-templates select="Date-Issued"/>
  <xsl:apply-templates select="Date-Modified"/>
  <xsl:apply-templates select="Type-of-Term"/>
  <xsl:apply-templates select="Instance-Of"/>
  <xsl:apply-templates select="Version"/>
  <xsl:apply-templates select="See"/>
  <xsl:apply-templates select="Has-Domain"/>
  <xsl:apply-templates select="Has-Range"/>
  <xsl:apply-templates select="Member-Of"/>
  <xsl:apply-templates select="Narrower-Than"/>
  <xsl:apply-templates select="Note"/>
  <xsl:apply-templates select="Refines"/>
  <xsl:apply-templates select="Title"/>
  <xsl:apply-templates select="Publisher"/>
</xsl:template>

</xsl:stylesheet>
