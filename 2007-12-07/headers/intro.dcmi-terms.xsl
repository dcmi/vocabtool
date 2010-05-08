<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0"	
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

<xsl:template name="terms_intro">

<p/>
This document is an up-to-date, authoritative specification
of all metadata terms maintained by the Dublin Core Metadata
Initiative -- elements, element refinements, encoding schemes,
and vocabulary terms (the DCMI Type Vocabulary).  Links to
other relevant documentation may be found on the "Overview
of Documentation for DCMI Metadata Terms" [<a href="#A6">OVERVIEW</a>].

<p/>
Legacy documents covering subsets of this document are
in the public domain, including the IETF
RFC 2413 [<a href="#A1">RFC2413</a>], the CEN Workshop Agreement CWA 13874
[<a href="#A3">CWA13874</a>], NISO Standard Z39.85-2001 [<a href="#A2">Z3985</a>], and a variety
of national standards that include some or all of the Dublin
Core Metadata Set.

<p/>
Each term is specified with the following minimal set of attributes:
<p/>
<table width="95%" border="0" align="center">
<tr><td width="20%">
<b>Name:</b>
</td><td width="80%">
The unique token assigned to the term.
</td></tr>
<tr><td width="20%">
<b>URI:</b>
</td><td width="80%">
The Uniform Resource Identifier used to uniquely identify a term.
</td></tr>
<tr><td width="20%">
<b>Label:</b>
</td><td width="80%">
The human-readable label assigned to the term.
</td></tr>
<tr><td width="20%">
<b>Definition:</b>
</td><td width="80%">
A statement that represents the concept and essential nature of the term.
</td></tr>
<tr><td width="20%">
<b>Type of Term:</b>
</td><td width="80%">
The type of term, such as Element or Encoding Scheme, as described in the DCMI Grammatical Principles.
</td></tr>
<tr><td width="20%">
<b>Status:</b>
</td><td width="80%">
Status assigned to term by the DCMI Usage Board, as described in the DCMI Usage Board Process.
</td></tr>
<tr><td width="20%">
<b>Date issued:</b>
</td><td width="80%">
Date on which a term was first declared.
</td></tr>
</table>

<p/>
Where applicable, the following attributes provide additional information about a term:
<p/>
<table width="95%" border="0" align="center">
<tr><td width="20%">
<b>Comment:</b>
</td><td width="80%">
Additional information about the term or its application.
</td></tr>
<tr><td width="20%">
<b>See:</b>
</td><td width="80%">
A link to authoritative documentation.
</td></tr>
<tr><td width="20%">
<b>References:</b>
</td><td width="80%">
A citation or URL of a resource referenced in the Definition or Comment.
</td></tr>
<tr><td width="20%">
<b>Refines:</b>
</td><td width="80%">
A reference to a term refined by an Element Refinement.
</td></tr>
<tr><td width="20%">
<b>Qualifies:</b>
</td><td width="80%">
A reference to a term qualified by an Encoding Scheme.
</td></tr>
<tr><td width="20%">
<b>Broader Than:</b>
</td><td width="80%">
A reference from a more general to a more specific Vocabulary Term.
</td></tr>
<tr><td width="20%">
<b>Narrower Than:</b>
</td><td width="80%">
A reference from a more specific to a more general Vocabulary Term.
</td></tr>
</table>

<br/><br/>
Anchors have been embedded in this document so
that users may cite a particular entry with the form
"http://dublincore.org/documents/dcmi-terms/#<i>term-name</i>"
(e.g., "http://dublincore.org/documents/dcmi-terms/#title").
While this form of citation is supported for documentary
convenience, note that the URI assigned to each term in
accordance with the DCMI Namespace Policy serves as its unique
identifier (e.g., "http://purl.org/dc/elements/1.1/title")
<a href="#A5">[NAMESPACE]</a>.

<p/>
Readers desiring further information about the change history
or Usage Board decisions that support these terms should
consult the document "DCMI Metadata Terms -- A Complete
Historical Record" [<a href="#A5">HISTORY</a>].

<p/>
This documentation is maintained by the DCMI Usage
Board. Although DCMI is committed to ensuring a high degree
of stability of the specifications it maintains, changes may
occur as a result of the work of the Usage Board.  The policies
and processes governing the identification and maintenance
of metadata terms are described in "DCMI Namespace Policy"
[<a href="#A4">NAMESPACE</a>], "DCMI Grammatical Principles" [<a href="#A7">PRINCIPLES</a>],
and "DCMI Usage Board Administrative Processes" [<a href="#A1">PROCESS</a>].
Usage Board decisions with respect to DCMI metadata terms
are summarized on the Web page "DCMI Usage Board Decisions"
[<a href="#A9">DECISIONS</a>].

Three attributes of terms -- Label, Definition, and Comment
-- have natural-language values which may be translated into
Japanese, Norwegian, or other languages.  Although there is
currently no mechanism in place to validate or certify such
translations in an official sense, DCMI maintains a Web page
with pointers to known translations of semantic specifications
and related DCMI documents [<a href="#A10">TRANSLATIONS</a>]

<p/>
<h4>References</h4>
<table width="95%" border="0" align="center">

<tr><td width="20%">
<a name="A1"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[RFC2413]
</td><td width="80%">
<a href="http://www.ietf.org/rfc/rfc2413.txt">http://www.ietf.org/rfc/rfc2413.txt</a>
</td></tr>

<tr><td width="20%">
<a name="A2"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[Z3985]
</td><td width="80%">
<a href="http://www.niso.org/standards/resources/Z39-85.pdf">http://www.niso.org/standards/resources/Z39-85.pdf</a>
</td></tr>

<tr><td width="20%">
<a name="A3"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[CWA13874]
</td><td width="80%">
CEN Workshop Agreement CWA 13874.  March 2000 (no longer available).
</td></tr>

<tr><td width="20%">
<a name="A4"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[NAMESPACE]
</td><td width="80%">
<a href="/documents/dcmi-namespace/">http://dublincore.org/documents/dcmi-namespace/</a>
</td></tr>

<tr><td width="20%">
<a name="A5"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[HISTORY]
</td><td width="80%">
<a href="/usage/terms/history/">http://dublincore.org/usage/terms/history/</a>
</td></tr>

<tr><td width="20%">
<a name="A6"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[OVERVIEW]
</td><td width="80%">
<a href="/usage/documents/overview/">http://dublincore.org/usage/documents/overview/</a>
</td></tr>

<tr><td width="20%">
<a name="A7"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[PRINCIPLES]
</td><td width="80%">
<a href="/usage/documents/principles/">http://dublincore.org/usage/documents/principles/</a>
</td></tr>

<tr><td width="20%">
<a name="A8"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[PROCESS]
</td><td width="80%">
<a href="/usage/documents/process/">http://dublincore.org/usage/documents/process/</a>
</td></tr>

<tr><td width="20%">
<a name="A9"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[DECISIONS]
</td><td width="80%">
<a href="/usage/decisions/">http://dublincore.org/usage/decisions/</a>
</td></tr>

<tr><td width="20%">
<a name="A10"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[TRANSLATIONS]
</td><td width="80%">
<a href="/resources/translations/">http://dublincore.org/resources/translations/</a>
</td></tr>

</table>
	
</xsl:template>
</xsl:stylesheet>
