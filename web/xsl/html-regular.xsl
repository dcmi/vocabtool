<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	>

<!-- skip processing these ones, we could have gone the other way (listed the elements to process, not ignore, but this list is enumerated already by the legacy code -->
<!-- relies on priority attribute in other template, unfortunately -->
<xsl:template match="Anchor
	| Namespace
	| Publisher
	| Replaces
	| Qualifies
	| Is-Replaced-By
	| Date-Issued
	| Date-Modified
	| Decision
	| Status
	| Name-for-Table
	| Name
	" 
	/>

<!-- NB. this template originally matched <Status/> as well. That's because I hadn't noticed the original code [1][2] checked for it twice, with the second check (correlating to the original match below) never being reached.
	The live website confirms that <Status/> should not be output except in the HTML history.
	[1] http://github.com/dublincore/website/blob/16f695c7aed63feeb87ac60dbcfb54f2a1cbfc6b/web/xsl/html-dctype.xsl#LC133
	[2] http://github.com/dublincore/website/blob/16f695c7aed63feeb87ac60dbcfb54f2a1cbfc6b/web/xsl/html-dcmiterms.xsl#LC343
	-->
<!-- gk: this should really by @typeof on the element -->
<xsl:template match="Type-of-Term">
	<xsl:call-template name="fragmentCheckingRow">
    <xsl:with-param name="property">rdf:type</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- this has to have its own mode because its output (empty <span/>) can't be positioned between table rows, so output position needs to be controlled -->
<!-- NB important to maintain these elements' matches in default mode as well so they aren't processed as table rows -->
<xsl:template match="Date-Modified" mode="content">
	<time>
		<xsl:apply-templates select="key('map',local-name())" />
    <xsl:attribute name="property">dcterms:modfified</xsl:attribute>
		<xsl:attribute name="datetime">
			<xsl:apply-templates />
		</xsl:attribute>
	</time>
</xsl:template>
<xsl:template match="Date-Issued" mode="content">
	<time>
		<xsl:apply-templates select="key('map',local-name())" />
    <xsl:attribute name="property">dcterms:issued</xsl:attribute>
		<xsl:attribute name="datetime">
			<xsl:apply-templates />
		</xsl:attribute>
	</time>
</xsl:template>

</xsl:transform>
