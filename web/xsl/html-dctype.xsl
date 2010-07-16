<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:dcam="http://purl.org/dc/dcam/"
	>
	
<xsl:output
	method="xml"
	indent="yes"
	version="1.0"
	encoding="utf-8"
	doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
	doctype-public="-//W3C//DTD XHTML+RDFa 1.0//EN"
	/>

<xsl:param name="ns" select="' '"/> <!-- CHECKME: if this is required, this should have no default to force runtime error?? -->
<xsl:param name="tt" select="' '"/> <!-- CHECKME: as above?? what is this anyway? -->
<xsl:param name="header"/> <!-- executive decision: this should error if not supplied -->

<xsl:variable name="heading" select="document($header)"/>

<xsl:key name="map" match="match" use="@element" />

<xsl:template match="/">
	<html version="XHTML+RDFa 1.0">
		<head>
			<title>
				<xsl:apply-templates select="$heading/H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="stylesheet" href="/css/default.css" type="text/css" />
			<style type="text/css"> <!-- FIXME: this inline style is for development only, and it should be placed inside the stylesheet referenced above -->
				<![CDATA[
				tr.attribute th {
					background-color: #fff;
				}
				]]>
			</style>
		</head>
		<body>
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<h1>DCMI Type Vocabulary</h1>
			<xsl:apply-templates select="$heading/H1" mode="docinfo" />
			<xsl:apply-templates select="dc"/>
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
	</table>
</xsl:template>

<xsl:template match="H1/*" mode="docinfo">
	<!-- TODO: make this a definition list -->
	<tr>
		<th scope="row"><xsl:value-of select="translate(local-name(), '-', ' ')" />:</th>
		<td>
			<xsl:choose>
				<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
					<xsl:choose>
						<xsl:when test="@label">
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates />
								</xsl:attribute>
								<xsl:apply-templates select="@property" mode="rel" />
								<xsl:value-of select="@label"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates />
								</xsl:attribute>
								<xsl:apply-templates select="@property" mode="rel" />
								<xsl:apply-templates />
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="@property" />
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

<xsl:template match="@property" mode="rel">
	<xsl:attribute name="rel">
		<xsl:apply-templates />
	</xsl:attribute>
</xsl:template>

<xsl:template match="dc">
	<table cellspacing="0" class="border">
		<xsl:apply-templates select="term[not(Is-Replaced-By)]">
			<xsl:sort select="Name"/>
		</xsl:apply-templates>
	</table>
</xsl:template>

<xsl:template match="term">
	<xsl:if test="(Namespace = $ns) or ($ns = 'any')">
		<tbody id="{Anchor}" class="term" about="{URI}">
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
			<xsl:apply-templates />
		</tbody>
	</xsl:if>
</xsl:template>

<xsl:template match="Type-of-Term | Status">
	<tr class="attribute">
		<th scope="row">
			<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
		</th>
		<td axis="{local-name()}">
			<a>
				<xsl:attribute name="href">
					<xsl:apply-templates />
				</xsl:attribute>
				<xsl:apply-templates select="key('map',local-name())" mode="rel" />
				<xsl:choose>
					<xsl:when test="contains(., '#')">
						<xsl:value-of select="substring-after(., '#')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates />
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</td>
	</tr>
</xsl:template>

<xsl:template match="match" mode="rel">
	<xsl:apply-templates select="@property" mode="rel" />
</xsl:template>

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
	| term/Name-for-Table
	| Name
	" 
	/>

<!-- apply to all children of term for which there are not specific templates, -->
<!-- thought this would have a default priority lower than templates above, but unfortunately needs @priority (slight hack) -->
<!-- TODO: see how we can put @property here where applicable -->
<xsl:template match="term/*" priority="-1">
	<tr class="attribute">
		<th scope="row">
			<xsl:value-of select="translate(local-name(), '-', ' ')"/>:
		</th>
		<td axis="{local-name()}">
			<xsl:choose>
				<xsl:when test="(starts-with(., 'http://')) or (starts-with(., 'mailto:'))">
					<a>
						<xsl:attribute name="href">
							<xsl:apply-templates />
						</xsl:attribute>
						<xsl:apply-templates select="key('map',local-name())" mode="rel" />
						<xsl:choose>
							<xsl:when test="@label">
								<xsl:value-of select="@label"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:apply-templates />
							</xsl:otherwise>
						</xsl:choose>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="key('map',local-name())" />
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</tr>
</xsl:template>

<xsl:template match="match">
	<xsl:attribute name="property">
		<xsl:value-of select="@property" />
	</xsl:attribute>
</xsl:template>

</xsl:transform>
