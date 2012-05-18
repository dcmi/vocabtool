<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	>
	
<!-- gk: HTML5 really shouldn't have either system or public DOCTYPE elements, but removing these results in no DOCTYPE -->
<xsl:output
	method="xml"
	indent="yes"
	version="1.0"
	encoding="utf-8"
	/>

<xsl:namespace-alias result-prefix="xhtml" stylesheet-prefix="#default" />

<xsl:param name="todaysDate" select="substring-before(document('http://xobjex.com/service/date.xsl')/date/utc/@stamp,'T')"/>

<xsl:param name="datestamp.dir" select="concat('../../',$todaysDate)" />
<xsl:param name="sect.dir" select="concat($datestamp.dir,'/xmldata')" />
<xsl:param name="intro.file" select="concat($datestamp.dir,'/headers/intro.dcmi-terms.xml')" />

<xsl:param name="section2"	select="concat($sect.dir,'/dcterms-properties.xml')" />
<xsl:param name="section3"	select="concat($sect.dir,'/dcelements.xml')" />
<xsl:param name="section4"	select="concat($sect.dir,'/dcterms-ves.xml')" />
<xsl:param name="section5"	select="concat($sect.dir,'/dcterms-ses.xml')" />
<xsl:param name="section6"	select="concat($sect.dir,'/dcterms-classes.xml')" />
<xsl:param name="section7"	select="concat($sect.dir,'/dctype.xml')" />
<xsl:param name="section8"	select="concat($sect.dir,'/dcam.xml')" />

<xsl:param name="test.hostname" /> <!-- mainly so I can hook into the http://dublincore.org CSS file(s) when testing -->

<xsl:variable name="sec2-doc" select="document($section2)" />
<xsl:variable name="sec3-doc" select="document($section3)" />
<xsl:variable name="sec4-doc" select="document($section4)" />
<xsl:variable name="sec5-doc" select="document($section5)" />
<xsl:variable name="sec6-doc" select="document($section6)" />
<xsl:variable name="sec7-doc" select="document($section7)" />
<xsl:variable name="sec8-doc" select="document($section8)"/>

<xsl:variable name="intro" select="document($intro.file)" />

<xsl:key name="map" match="match[not(../@context)]" use="@element" />

<xsl:include href="html-common.xsl" />
<xsl:include href="html-regular.xsl" />

<xsl:template match="/">
  <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>&#10;</xsl:text>
	<html
    prefix="dcam: http://purl.org/dc/dcam/ dctype: http://purl.org/dc/dcmitype/"
    lang="en"
    resource="http://purl.org/dc/"
  >
		<head>
			<title>
				<xsl:apply-templates select="H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="stylesheet" href="{$test.hostname}/css/default.css" type="text/css" />
			<link rel="dcterms:tableOfContents" href="#contents" title="Table of Contents" /> <!-- see note at #contents below re not implementing this as an RDFa @property -->
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
					table-layout:fixed;
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
				abbr.xmlns {
					font-style: italic;
					border-bottom: 0;
				}
				table.border.index td,
				table.border.index th {
					border-spacing: 0;
				}
				table.index th {
					border-right: 1px solid #CCC; border-bottom: 1px solid #CCC; padding: .5em; /* FIXME: if this selector gets added to table.border th, then these duplicate CSS settings won't be needed. The ones below are the overrides */
					font-weight: normal;
					background-color: transparent;
				}
				]]>
			</style>
		</head>
		<body>
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<h1><xsl:apply-templates select="H1/Title" /></h1>
			<xsl:apply-templates select="H1" mode="docinfo" />
			<xsl:call-template name="tableOfContents" />
			<xsl:call-template name="indexOfTerms" />
			<xsl:call-template name="introSection" />
			<xsl:call-template name="mainSections" />
			<xsl:comment>#include virtual="/ssi/footer.shtml" </xsl:comment>
		</body>
	</html>
</xsl:template>

<xsl:template match="xhtml:html">
	<xsl:copy-of select="xhtml:body/*" />
</xsl:template>

<xsl:template name="tableOfContents">
	<div id="contents"> <!-- CHECKME: had @property = "dcterms:tableOfContents" here, which check.rdfa.info liked, but it's value was XHTML markup, doesn't seem exactly right -->
		<h2>Table of Contents</h2>
		<ol>
			<li><a href="#H1">Introduction and Definitions</a></li>
			<li><a href="#H2"><xsl:apply-templates select="$sec2-doc" mode="heading" /></a></li>
			<li><a href="#H3"><xsl:apply-templates select="$sec3-doc" mode="heading" /></a></li>
			<li><a href="#H4"><xsl:apply-templates select="$sec4-doc" mode="heading" /></a></li>
			<li><a href="#H5"><xsl:apply-templates select="$sec5-doc" mode="heading" /></a></li>
			<li><a href="#H6"><xsl:apply-templates select="$sec6-doc" mode="heading" /></a></li>
			<li><a href="#H7"><xsl:apply-templates select="$sec7-doc" mode="heading" /></a></li>
			<li><a href="#H8"><xsl:apply-templates select="$sec8-doc" mode="heading" /></a></li>
			<!--
			<li><a href="http://dublincore.org/dcregistry/navigateServlet?reqType=termsOverviewServlet">DCMI Terms Overview</a></li>
			-->
		</ol>
	</div>
</xsl:template>

<xsl:template match="dc" mode="heading">
	<xsl:copy-of select="heading/node()" />
</xsl:template>

<xsl:template name="indexOfTerms">
	<h2>Index of Terms</h2>
	<table class="border index">
		<xsl:apply-templates select="$sec2-doc" mode="index">
			<xsl:with-param name="propertiesOnly" select="true()" />
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec3-doc" mode="index">
			<xsl:with-param name="propertiesOnly" select="true()" />
		</xsl:apply-templates>
		<xsl:apply-templates select="$sec4-doc" mode="index" />
		<xsl:apply-templates select="$sec5-doc" mode="index" />
		<xsl:apply-templates select="$sec6-doc" mode="index" />
		<xsl:apply-templates select="$sec7-doc" mode="index" />
		<xsl:apply-templates select="$sec8-doc" mode="index" />
	</table>
</xsl:template>

<xsl:template match="dc" mode="index">
	<xsl:param name="propertiesOnly" />
	<tr>
		<th scope="row"><xsl:apply-templates select="." mode="heading" /></th>
		<td>
			<xsl:apply-templates select="term[
				not(Is-Replaced-By) and
				(
					not($propertiesOnly) or
					substring-after(Type-of-Term, '#') = 'Property'
				)
			]"
			mode="index"
			>
				<xsl:sort select="Name"/>
			</xsl:apply-templates>
		</td>
	</tr>
</xsl:template>

<xsl:template match="term" mode="index">
	<xsl:if test="position() &gt; 1">
		<xsl:text>, </xsl:text>
	</xsl:if>
	<a href="#{Name-for-Table}" class="term">
		<xsl:value-of select="Name"/>
	</a>
</xsl:template>

<xsl:template name="introSection">
	<div id="H1">
		<h2>Section 1: Introduction and Definitions</h2>
		<xsl:apply-templates select="$intro/xhtml:html" />
	</div>
</xsl:template>

<xsl:template name="mainSections">
	<xsl:apply-templates select="$sec2-doc/dc">
		<xsl:with-param name="propertiesOnly" select="true()" />
		<xsl:with-param name="seq" select="2" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec3-doc/dc">
		<xsl:with-param name="propertiesOnly" select="true()" />
		<xsl:with-param name="seq" select="3" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec4-doc/dc">
		<xsl:with-param name="seq" select="4" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec5-doc/dc">
		<xsl:with-param name="seq" select="5" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec6-doc/dc">
		<xsl:with-param name="seq" select="6" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec7-doc/dc">
		<xsl:with-param name="seq" select="7" />
	</xsl:apply-templates>
	<xsl:apply-templates select="$sec8-doc/dc">
		<xsl:with-param name="seq" select="8" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="dc">
	<xsl:param name="propertiesOnly" />
	<xsl:param name="seq" select="1" /> <!-- a bit unfortunate, needing this -->
	<div id="H{$seq}">
		<h2>Section <xsl:value-of select="$seq" />: <xsl:apply-templates select="." mode="heading" /></h2>
		<table cellspacing="0" class="border">
			<xsl:apply-templates select="term[
				not(Is-Replaced-By) and
					(
					not($propertiesOnly) or
					substring-after(Type-of-Term, '#') = 'Property'
					)
				]
			">
				<xsl:sort select="Name"/>
			</xsl:apply-templates>
		</table>
	</div>
</xsl:template>

<xsl:template match="term">
	<tbody id="{Name-for-Table}" class="term" resource="{URI}">
		<tr>
			<th colspan="2" scope="rowgroup">
				<xsl:text>Term Name: </xsl:text>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text>
				<span>
					<xsl:apply-templates select="key('map','Name')" />
					<xsl:value-of select="Name"/>
				</span>
				<!-- FIXME: really can't work out why I should need to populate @select here. Would be more robust without it. If I leave it out, the text contents of every other <term/> child node are output. halp! -->
				<xsl:apply-templates select="Date-Modified | Date-Issued | Namespace" mode="content" />
			</th>
		</tr>
		<xsl:apply-templates />
	</tbody>
</xsl:template>

</xsl:transform>
