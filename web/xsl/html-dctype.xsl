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
	doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-2.dtd"
	doctype-public="-//W3C//DTD XHTML+RDFa 1.1//EN"
	/>

<xsl:param name="todaysDate" select="substring-before(document('http://xobjex.com/service/date.xsl')/date/utc/@stamp,'T')"/>

<xsl:param name="datestamp.dir" select="concat('../../',$todaysDate)" />
<xsl:param name="header" select="concat($datestamp.dir,'/headers/header-doc-dctype.xml')" />

<xsl:param name="ns">http://purl.org/dc/dcmitype/</xsl:param>

<xsl:param name="test.hostname" /> <!-- set to "http://dublincore.org" to use its CSS when testing -->

<xsl:variable name="heading" select="document($header)"/>

<xsl:key name="map" match="match[not(../@context)]" use="@element" />

<xsl:include href="html-common.xsl" />
<xsl:include href="html-regular.xsl" />

<xsl:template match="/">
	<html prefix="dcam: http://purl.org/dc/dcam/" lang="en">
		<head>
			<title>
				<xsl:apply-templates select="$heading/H1/Title"/>
			</title>
			<xsl:comment>#exec cgi="/cgi-bin/metawriter.cgi" </xsl:comment>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<link rel="stylesheet" href="{$test.hostname}/css/default.css" type="text/css" />
			<style type="text/css"> <!-- FIXME: this inline style is for development only, and it should be placed inside the stylesheet referenced above -->
				<![CDATA[
				tr.attribute th {
					background-color: #fff;
				}
				]]>
			</style>
		</head>
		<body resource="http://purl.org/dc/dcmitype/">
			<xsl:comment>#include virtual="/ssi/header.shtml" </xsl:comment>
			<h1><xsl:apply-templates select="$heading/H1/Title" /></h1>
			<xsl:apply-templates select="$heading/H1" mode="docinfo" />
			<xsl:apply-templates select="dc"/>
			<xsl:comment>#include virtual="/ssi/footer.shtml" </xsl:comment>
		</body>
	</html>
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
		<tbody id="{Anchor}" class="term" resource="{URI}">
			<tr>
				<th colspan="2" scope="rowgroup">
					<xsl:text>Term Name: </xsl:text>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;</xsl:text>
					<span>
						<xsl:apply-templates select="key('map','Name')" />
						<xsl:value-of select="Name"/>
					</span>
					<!-- FIXME: really can't work out why I should need to populate @select here. Would be more robust without it. If I leave it out, the text contents of every other <term/> child node are output. halp! -->
					<xsl:apply-templates select="Date-Modified | Date-Issued" mode="content" />
				</th>
			</tr>
			<xsl:apply-templates />
		</tbody>
	</xsl:if>
</xsl:template>

</xsl:transform>
