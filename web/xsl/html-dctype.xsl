<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
<xsl:output method="xml" indent="yes"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
  doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

<xsl:param name="todaysDate" select="' '"/>
<xsl:param name="ns" select="' '"/>
<xsl:param name="tt" select="' '"/>
<xsl:param name="header" select="' '"/>

<xsl:variable name="heading" select="document($header)"/>

<xsl:template match="/">
  <html>
    <head>
      <title>
	<xsl:value-of select="$heading/H1/Title"/>
      </title>
      <xsl:text disable-output-escaping='yes'>&lt;!--#exec cgi="/cgi-bin/metawriter.cgi" --&gt;</xsl:text>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
      <link rel="stylesheet" href="/css/default.css" type="text/css" />
    </head>
    <body>
      <xsl:text disable-output-escaping='yes'>&lt;!--#include virtual="/ssi/header.shtml" --&gt;</xsl:text>
      <xsl:apply-templates select="dc"/>
      <xsl:text disable-output-escaping='yes'>&lt;!--#include virtual="/ssi/footer.shtml" --&gt;</xsl:text>
    </body>
  </html>
</xsl:template>

<xsl:template match="dc">
  <h1>DCMI Type Vocabulary</h1>
  <table cellspacing="0" class="docinfo">
    <xsl:for-each select="$heading/H1/*">
      <xsl:call-template name="print_heading">
	<xsl:with-param name="elem" select="local-name()"/>
	<xsl:with-param name="label" select="@label"/>
	<xsl:with-param name="value" select="."/>
      </xsl:call-template>
    </xsl:for-each>
    <!--
    <tr>
      <th>Date Valid:</th>
      <td><xsl:value-of select="$todaysDate"/></td>
    </tr>
    -->
  </table>

  <table cellspacing="0" class="border">
    <xsl:apply-templates select="term[not(Is-Replaced-By)]">
      <xsl:sort select="Name"/>
    </xsl:apply-templates>
  </table>
</xsl:template>

<xsl:template name="print_heading">
  <xsl:param name="elem"/>
  <xsl:param name="label"/>
  <xsl:param name="value"/>
  <tr>
    <th><xsl:value-of select="translate($elem, '-', ' ')"/>:</th>
    <td>
      <xsl:choose>
	<xsl:when test="(starts-with($value, 'http://')) or (starts-with($value, 'mailto:'))">
	  <xsl:choose>
	    <xsl:when test="$label">
	      <a>
		<xsl:attribute name="href">
		  <xsl:value-of select="$value"/>
		</xsl:attribute>
		<xsl:value-of select="$label"/>
	      </a>
	    </xsl:when>
	    <xsl:otherwise>
	      <a>
		<xsl:attribute name="href">
		  <xsl:value-of select="$value"/>
		</xsl:attribute>
		<xsl:value-of select="$value"/>
	      </a>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:choose>
	    <xsl:when test="$elem='Title'">
	      <xsl:value-of select="$value"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$value"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:otherwise>
      </xsl:choose>
    </td>
  </tr>
</xsl:template>

<xsl:template match="term">
  <xsl:if test="(Namespace = $ns) or ($ns = 'any')">
    <tr>
      <th colspan="2">
	<a>
	  <xsl:attribute name="name">
	    <xsl:value-of select="Anchor"/>
	  </xsl:attribute>
	</a>
	<xsl:value-of select="'Term Name: '"/>
	<xsl:text disable-output-escaping='yes'>&amp;nbsp;&amp;nbsp;</xsl:text>
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
		  <xsl:when test="contains(., '#')">
		    <xsl:value-of select="substring-after(., '#')"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:value-of select="." />
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
			</xsl:attribute><xsl:value-of select="."/>
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
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
