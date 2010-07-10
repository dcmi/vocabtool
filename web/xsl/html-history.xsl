<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	>

<xsl:namespace-alias result-prefix="xhtml" stylesheet-prefix="#default" />
	
<xsl:output
	method="xml"
	indent="yes"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
	doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	/> <!-- CHECKME: are the doctypes still required, or even correct for XHTML+RDFa? -->

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

<xsl:variable name="sec1-doc" select="document($section1)" />
<xsl:variable name="sec2-doc" select="document($section2)" />
<xsl:variable name="sec3-doc" select="document($section3)" />
<xsl:variable name="sec4-doc" select="document($section4)" />
<xsl:variable name="sec5-doc" select="document($section5)" />
<xsl:variable name="sec6-doc" select="document($section6)" />
<xsl:variable name="sec7-doc" select="document($section7)" />

<xsl:variable name="intro" select="document($intro.file)" />

<xsl:template match="/">
	<html>
		<head>
			<title>
				<xsl:apply-templates select="H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
			<link rel="meta" href="index.shtml.rdf" />
			<link rel="stylesheet" href="/css/default.css" type="text/css" />
		</head>	
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

<xsl:template match="H1/Title">
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="H1" mode="docinfo">
	<table cellspacing="0" class="docinfo">
		<xsl:apply-templates mode="docinfo" />
		<!-- CHECKME: this was pulled commented out - should it be re-enabled? It was possibly commented out because the build.xml param was mistyped -->
		<!--
		<tr>
		  <th>Date Valid:</th>
		  <td><xsl:value-of select="$todaysDate"/></td>
		</tr>
		-->
	</table>
</xsl:template>

<xsl:template match="xhtml:html">
	<xsl:copy-of select="xhtml:body/*" />
</xsl:template>

<xsl:template match="H1/*" mode="docinfo">
	<!-- TODO: make this a definition list -->
	<tr>
		<th><xsl:value-of select="translate(local-name(), '-', ' ')" />:</th> <!--  FIXME: @scope="row" -->
		<td>
			<xsl:copy-of select="@property" />
			<xsl:choose>
				<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
					<xsl:choose>
						<xsl:when test="@label">
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates />
								</xsl:attribute>
								<xsl:value-of select="@label"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates />
								</xsl:attribute>
								<xsl:apply-templates />
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
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
	<tr> <!-- CHECKME: this is probably the same template as used for dcmi-type -->
		<th colspan="2">
			<a> <!-- TODO: change this to @id on wrapper, etc -->
				<xsl:attribute name="name">
					<xsl:value-of select="Anchor"/>
				</xsl:attribute>
			</a>
			<xsl:text> </xsl:text>
			<xsl:text>Term Name: </xsl:text>
			<xsl:value-of select="Name"/>
		</th>
	</tr>
	<xsl:apply-templates />
</xsl:template>

<!-- 
FIXME: the contents of this template have been copied without cleanup.
Expect this to be the same as corresponding template in dcmi-types transform 
-->
<xsl:template match="Version
	| Type-of-Term
	| Status
	| Decision
	| Replaces
	| Is-Replaced-By
	"
	>
	<tr>
		<td>
			<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
		</td>
		<td>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="."/>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="contains(., '#')">
						<xsl:value-of select="substring-after(., '#')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</td>
	</tr>
</xsl:template>

<!-- skip processing these ones -->
<xsl:template match="Anchor
	| Name
	"
	/>

<!-- 
FIXME: the contents of this template have been copied without cleanup.
Expect this to be the same as corresponding template in dcmi-types transform 
-->
<!-- apply to all children of term for which there are not specific templates, -->
<xsl:template match="term/*" priority="-1">
	<tr>
		<td>
			<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
		</td>
		<td>
			<xsl:choose>
				<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="."/>
						</xsl:attribute>
						<xsl:choose>
							<xsl:when test="@label">
								<xsl:value-of select="@label"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

</xsl:transform>
