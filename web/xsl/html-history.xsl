<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	>

<xsl:namespace-alias result-prefix="xhtml" stylesheet-prefix="#default" />
	
<!-- gk: HTML5 really shouldn't have either system or public DOCTYPE elements, but removing these results in no DOCTYPE -->
<xsl:output
	method="xml"
	indent="yes"
	version="1.0"
	encoding="utf-8"
	doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-2.dtd"
	doctype-public="-//W3C//DTD XHTML+RDFa 1.1//EN"
	/>

<xsl:param name="todaysDate" select="substring-before(document('http://xobjex.com/service/date.xsl')/date/utc/@stamp,'T')"/>

<xsl:param name="datestamp.dir" select="concat('../../',$todaysDate)" />
<xsl:param name="sect.dir" select="concat($datestamp.dir,'/xmldata')" />
<xsl:param name="intro.file" select="concat($datestamp.dir,'/headers/intro.history.xml')" />

<xsl:param name="section1"	select="concat($sect.dir,'/dcterms-properties.xml')" />
<xsl:param name="section2"	select="concat($sect.dir,'/dcelements.xml')" />
<xsl:param name="section3"	select="concat($sect.dir,'/dcterms-ves.xml')" />
<xsl:param name="section4"	select="concat($sect.dir,'/dcterms-ses.xml')" />
<xsl:param name="section5"	select="concat($sect.dir,'/dcterms-classes.xml')" />
<xsl:param name="section6"	select="concat($sect.dir,'/dctype.xml')" />
<xsl:param name="section7"	select="concat($sect.dir,'/dcam.xml')" />

<xsl:param name="test.hostname" /> <!-- set to "http://dublincore.org" to use its CSS when testing -->

<xsl:variable name="sec1-doc" select="document($section1)" />
<xsl:variable name="sec2-doc" select="document($section2)" />
<xsl:variable name="sec3-doc" select="document($section3)" />
<xsl:variable name="sec4-doc" select="document($section4)" />
<xsl:variable name="sec5-doc" select="document($section5)" />
<xsl:variable name="sec6-doc" select="document($section6)" />
<xsl:variable name="sec7-doc" select="document($section7)" />

<xsl:variable name="intro" select="document($intro.file)" />

<!-- <xsl:variable name="mappings" select="document(concat($sect.dir,'/mappings.xml'))" /> -->

<xsl:key name="map" match="match[not(../@context) or ../@context='history']" use="@element" />

<xsl:include href="html-common.xsl" />

<xsl:template match="/">
	<html prefix="dcam: http://purl.org/dc/dcam/" lang="en">
		<head>
			<title>
				<xsl:apply-templates select="H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="stylesheet" href="{$test.hostname}/css/default.css" type="text/css" />
			<style type="text/css"> <!-- FIXME: this inline style is for development only, and it should be placed inside the stylesheet referenced above -->
				<![CDATA[
				tr.attribute th {
					background-color: #fff;
				}
				table.legend,
				table.references {
					margin-left: 2.5%;
					margin-right: 2.5%;
					width: 95%;
					table-layout: fixed;
					border-width: 0;
					}
				.legend th.label,
				.references th.abbrev {
					width: 20%;
				}
				.legend td.definition,
				.references td.citation {
					width: 80%;
				}
				]]>
			</style>
			<!-- TODO: a feed autodiscovery link in here? -->
		</head>
    <!-- gk: this should have a resource defining the top-level IRI -->	
		<body>
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<!-- CHECKME: no H1 for this page? -->
			<xsl:apply-templates select="H1" mode="docinfo" />
			<xsl:apply-templates select="$intro/xhtml:html" />
			<xsl:call-template name="sectionsTable" />
			<xsl:comment>#include virtual="/ssi/footer.shtml" </xsl:comment>
		</body>
	</html>
</xsl:template>

<xsl:template match="xhtml:html">
	<xsl:copy-of select="xhtml:body/*" />
</xsl:template>

<xsl:template name="sectionsTable">
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec1-doc/dc" />
		<xsl:apply-templates select="$sec2-doc/dc" />
		<xsl:apply-templates select="$sec3-doc/dc" />
		<xsl:apply-templates select="$sec4-doc/dc" />
		<xsl:apply-templates select="$sec5-doc/dc" />
		<xsl:apply-templates select="$sec6-doc/dc" />
		<xsl:apply-templates select="$sec7-doc/dc" />
	</table>
</xsl:template>

<xsl:template match="dc">
	<!-- CHECKME: can't see the point of sorting these by name within classifications, especially if no headings are output -->
	<xsl:apply-templates select="term">
		<xsl:sort select="Name"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="term">
	<tbody id="{Anchor}" class="term" resource="{Version}">
		<tr>
			<th colspan="2" scope="rowgroup">
				<xsl:text>Term Name: </xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text>
				<span>
					<xsl:apply-templates select="key('map','Name')" />
					<xsl:value-of select="Name"/>
				</span>
			</th>
		</tr>
		<xsl:apply-templates>
      <xsl:with-param name="no-rdfa" select="true()" />
    </xsl:apply-templates>
	</tbody>
</xsl:template>

<xsl:template match="Version
	| Type-of-Term
	| Status
	| Decision
	| Replaces
	| Is-Replaced-By
	"
	>
	<xsl:call-template name="fragmentCheckingRow" />
</xsl:template>

<!-- skip processing these ones -->
<xsl:template match="Anchor
	| Name
	"
	/>

</xsl:transform>
