<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	>
	
<xsl:output
	method="xml"
	indent="yes"
	version="1.0"
	encoding="utf-8"
	doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
	doctype-public="-//W3C//DTD XHTML+RDFa 1.0//EN"
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

<xsl:variable name="sec2-doc" select="document($section2)" />
<xsl:variable name="sec3-doc" select="document($section3)" />
<xsl:variable name="sec4-doc" select="document($section4)" />
<xsl:variable name="sec5-doc" select="document($section5)" />
<xsl:variable name="sec6-doc" select="document($section6)" />
<xsl:variable name="sec7-doc" select="document($section7)" />
<xsl:variable name="sec8-doc" select="document($section8)"/>

<xsl:variable name="intro" select="document($intro.file)" />

<xsl:include href="html-common.xsl" />

<xsl:template match="/">
	<html version="XHTML+RDFa 1.0">
		<head>
			<title>
				<xsl:apply-templates select="H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="meta" href="index.shtml.rdf" />
			<link rel="stylesheet" href="/css/default.css" type="text/css" />
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
				]]>
			</style>
		</head>
		<body>
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<h1><xsl:apply-templates select="H1/Title" /></h1>
			<xsl:apply-templates select="H1" mode="docinfo" />
			<xsl:call-template name="print-toc" />
			<xsl:call-template name="print-index-of-terms" />
			<xsl:call-template name="print-section1" />
			<xsl:call-template name="print-section2" />
			<xsl:call-template name="print-section3" />
			<xsl:call-template name="print-section4" />
			<xsl:call-template name="print-section5" />
			<xsl:call-template name="print-section6" />
			<xsl:call-template name="print-section7" />
			<xsl:call-template name="print-section8" />
			<xsl:comment>#include virtual="/ssi/footer.shtml" </xsl:comment>
		</body>
	</html>
</xsl:template>

<xsl:template match="xhtml:html">
	<xsl:copy-of select="xhtml:body/*" />
</xsl:template>

<xsl:template name="print-toc">
  <h2>Table of Contents</h2>
  <ol>
    <li><a href="#H1">Introduction and Definitions</a></li>
    <li><a href="#H2">Properties in the <i>/terms/</i> namespace</a></li>
    <li><a href="#H3">Properties in the legacy <i>/elements/1.1/</i> namespace</a></li>
    <li><a href="#H4">Vocabulary Encoding Schemes</a></li>
    <li><a href="#H5">Syntax Encoding Schemes</a></li>
    <li><a href="#H6">Classes</a></li>
    <li><a href="#H7">DCMI Type Vocabulary</a></li>
    <li><a href="#H8">Terms related to the DCMI Abstract Model</a></li>
    <!--
    <li><a href="http://dublincore.org/dcregistry/navigateServlet?reqType=termsOverviewServlet">DCMI Terms Overview</a></li>
    -->
  </ol>
</xsl:template>

<xsl:template name="print-index-of-terms">
	<h2>Index of Terms</h2>
	<table cellspacing="0" border="0" class="border">
		<tr>
			<td>Properties in the <i>/terms/</i> namespace</td>
			<td>
				<xsl:for-each select="$sec2-doc/dc/term[not(Is-Replaced-By) and substring-after(Type-of-Term, '#') = 'Property']">
					<xsl:sort select="Name"/>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', Name-for-Table)"/>
						</xsl:attribute>
						<xsl:value-of select="Name"/>
					</a>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
		<tr>
			<td>Properties in the legacy <i>/elements/1.1/</i> namespace</td>
			<td>
				<xsl:for-each select="$sec3-doc/dc/term[not(Is-Replaced-By) and substring-after(Type-of-Term, '#') = 'Property']">
					<xsl:sort select="Name"/>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', Name-for-Table)"/>
						</xsl:attribute>
						<xsl:value-of select="Name"/>
					</a>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
		<tr>
			<td>Vocabulary Encoding Schemes</td>
			<td>
				<xsl:for-each select="$sec4-doc/dc/term[not(Is-Replaced-By)]">
					<xsl:sort select="Name"/>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', Name-for-Table)"/>
						</xsl:attribute>
						<xsl:value-of select="Name"/>
					</a>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
		<tr>
			<td>Syntax Encoding Schemes</td>
			<td>
				<xsl:for-each select="$sec5-doc/dc/term[not(Is-Replaced-By)]">
					<xsl:sort select="Name"/>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', Name-for-Table)"/>
						</xsl:attribute>
						<xsl:value-of select="Name"/>
					</a>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
		<tr>
			<td>Classes</td>
			<td>
				<xsl:for-each select="$sec6-doc/dc/term[not(Is-Replaced-By)]">
					<xsl:sort select="Name"/>
					<a>
						<xsl:attribute name="href">
							<xsl:value-of select="concat('#', Name-for-Table)"/>
						</xsl:attribute>
						<xsl:value-of select="Name"/>
					</a>
					<xsl:if test="position() != last()">
						<xsl:text>, </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="print-section1">
	<a name="H1"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 1: Introduction and Definitions</h2>
	<xsl:apply-templates select="$intro/xhtml:html" />
</xsl:template>
	
<xsl:template name="print-section2">
	<a name="H2"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 2: Properties in the <i>/terms/</i> namespace</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec2-doc/dc/term[not(Is-Replaced-By) and substring-after(Type-of-Term, '#') = 'Property']">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print-section3">
	<a name="H3"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 3: Properties in the legacy <i>/elements/1.1/</i> namespace</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec3-doc/dc/term[not(Is-Replaced-By) and substring-after(Type-of-Term, '#') = 'Property']">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print-section4">
	<a name="H4"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 4: Vocabulary Encoding Schemes</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec4-doc/dc/term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print-section5">
	<a name="H5"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 5: Syntax Encoding Schemes</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec5-doc/dc/term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print-section6">
	<a name="H6"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 6: Classes</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec6-doc/dc/term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template name="print-section7">
	<a name="H7"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 7: DCMI Type Vocabulary</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec7-doc/dc/term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>          
</xsl:template>

<xsl:template name="print-section8">
	<a name="H8"><xsl:text disable-output-escaping='yes'> </xsl:text></a>
	<h2>Section 8: Terms related to the DCMI Abstract Model</h2>
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="$sec8-doc/dc/term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>          
</xsl:template>

<xsl:template match="term">
	<tr>
		<th colspan="2">
			<!-- set anchor point -->
			<a>
				<xsl:attribute name="name">
					<!--<xsl:value-of select="Name"/>-->
					<xsl:value-of select="Name-for-Table"/>
				</xsl:attribute>
			</a>
			<xsl:text disable-output-escaping='yes'></xsl:text>

			<xsl:value-of select="'Term Name: '"/>
			<xsl:text disable-output-escaping='yes'></xsl:text>
			<xsl:value-of select="Name"/>
		</th>
	</tr>
	<xsl:for-each select="descendant::node()">
		<xsl:choose>
			<xsl:when test="local-name() = ''"/>
			<xsl:when test="local-name() = 'Anchor'"/>
			<xsl:when test="local-name() = 'Namespace'"/>
			<!--
			<xsl:when test="local-name() = 'Version'"/>
			-->
			<xsl:when test="local-name() = 'Publisher'"/>
			<xsl:when test="local-name() = 'Replaces'"/>
			<xsl:when test="local-name() = 'Qualifies'"/>
			<xsl:when test="local-name() = 'Is-Replaced-By'"/>
			<xsl:when test="local-name() = 'Date-Issued'"/>
			<xsl:when test="local-name() = 'Date-Modified'"/>
			<xsl:when test="local-name() = 'Decision'"/>
			<xsl:when test="local-name() = 'Status'"/>
			<xsl:when test="local-name() = 'Name-for-Table'"/>
			<xsl:when test="local-name() = 'Name'"/>
			<xsl:when test="(local-name() = 'Type-of-Term') or (local-name() = 'Status')">
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
								<xsl:when test="contains(.,'#')">
									<xsl:value-of select="substring-after(., '#')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="."/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
					</td>
					<td>
						<xsl:choose>
							<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
								<xsl:choose>
									<xsl:when test="@label">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:value-of select="@label"/>
										</a>
									</xsl:when>
									<xsl:otherwise>
										<a>
											<xsl:attribute name="href">
												<xsl:value-of select="."/>
											</xsl:attribute>
											<xsl:value-of select="."/>
										</a>
									</xsl:otherwise>
								</xsl:choose>		
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="."/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
</xsl:template>

</xsl:transform>
