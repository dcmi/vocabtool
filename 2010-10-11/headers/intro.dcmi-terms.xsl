<?xml version='1.0' encoding='UTF-8'?>

<xsl:stylesheet version="1.0"	
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

<xsl:template name="terms_intro">

<p/>
This document is an up-to-date, authoritative specification
of all metadata terms maintained by the Dublin Core Metadata
Initiative.  Included are the fifteen terms of the Dublin Core
Metadata Element Set, which have also been published as IETF
RFC 5013 [<a href="#RFC5013">RFC5013</a>], ANSI/NISO Standard
Z39.85-2007 [<a href="#NISOZ3985">NISOZ3985</a>], and ISO
Standard 15836:2009 [<a href="#ISO15836">ISO15836</a>].

<p/>
Each term is specified with the following minimal set of attributes:
<p/>
<table width="95%" border="0" align="center">

<tr><td width="20%">
<b>Name:</b>
</td><td width="80%">
A token appended to the URI of a DCMI namespace to create the URI of the term.
</td></tr>

<tr><td width="20%">
<b>Label:</b>
</td><td width="80%">
The human-readable label assigned to the term.
</td></tr>

<tr><td width="20%">
<b>URI:</b>
</td><td width="80%">
The Uniform Resource Identifier used to uniquely identify a term.
</td></tr>

<tr><td width="20%">
<b>Definition:</b>
</td><td width="80%">
A statement that represents the concept and essential nature of the term.
</td></tr>

<tr><td width="20%">
<b>Type of Term:</b>
</td><td width="80%">
The type of term as described in the DCMI Abstract Model [<a href="#DCAM">DCAM</a>].
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
Authoritative documentation related to the term.
</td></tr>

<tr><td width="20%">
<b>References:</b>
</td><td width="80%">
A resource referenced in the Definition or Comment.
</td></tr>

<tr><td width="20%">
<b>Refines:</b>
</td><td width="80%">
A Property of which the described term is a Sub-Property.
</td></tr>

<tr><td width="20%">
<b>Broader Than:</b>
</td><td width="80%">
A Class of which the described term is a Super-Class.
</td></tr>

<tr><td width="20%">
<b>Narrower Than:</b>
</td><td width="80%">
A Class of which the described term is a Sub-Class.
</td></tr>

<tr><td width="20%">
<b>Has Domain:</b>
</td><td width="80%">
A Class of which a resource described by the term is an Instance.
</td></tr>

<tr><td width="20%">
<b>Has Range:</b>
</td><td width="80%">
A Class of which a value described by the term is an Instance.
</td></tr>

<tr><td width="20%">
<b>Member Of:</b>
</td><td width="80%">
An enumerated set of resources (Vocabulary Encoding Scheme) of which the term is a Member.
</td></tr>

<tr><td width="20%">
<b>Instance Of:</b>
</td><td width="80%">
A Class of which the described term is an instance.
</td></tr>

<tr><td width="20%">
<b>Version:</b>
</td><td width="80%">
A specific historical description of a term.
</td></tr>

<tr><td width="20%">
<b>Equivalent<br>Property:</b>
</td><td width="80%">
A Property to which the described term is equivalent.
</td></tr>

</table>

<p/>
The current release of "DCMI Metadata Terms" reflects editorial
changes approved since January 2008, notably:<ul>
<li>Deletes misleading usage comment for dcterms:creator, dcterms:contributor, and
dcterms:publisher.</li>
<li>Specifies formal range rdfs:Literal for dcterms:title and dcterms:alternative.</li>
<li>Erratum: domain of dcterms:accrualMethod, dcterms:accrualPeriodicity, and dcterms:accrualPolicy
is dcmitype:Collection (not dcterms:Collection).</li>
<li>Adds new datatype, dcterms:RFC5646.</li>
<li>In description of dcterms:DCMIType, adds "See:" reference to http://purl.org/dc/dcmitype/.</li>
<li>Specifies formal range dcam:VocabularyEncodingScheme for dcam:memberOf (overlooked in previous version).</li>
<li>Declares dcterms:creator to be a property equivalent to http://xmlns.com/foaf/0.1/maker (using
owl:equivalentProperty).</li>
</ul>
These changes are described more fully in the
document "Maintenance changes to DCMI Metadata Terms" [<a
href="#REVISIONS">REVISIONS</a>].

<p/>
This document reflects the terminology used in the DCMI Abstract 
Model [<a href="#DCAM">DCAM</a>].
Further information about change history
is documented in "DCMI Metadata Terms: A complete
historical record" [<a href="#HISTORY">HISTORY</a>].
DCMI maintains a Web page with pointers to known translations
of semantic specifications and related DCMI documents [<a
href="#TRANSLATIONS">TRANSLATIONS</a>]

<p/>
<h4>References</h4>
<table width="95%" border="0" align="center">

<tr><td width="20%">
<a name="DCAM"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[DCAM]
</td><td width="80%">
<a href="/documents/2007/06/04/abstract-model/">http://dublincore.org/documents/2007/06/04/abstract-model/</a>
</td></tr>

<tr><td width="20%">
<a name="HISTORY"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[HISTORY]
</td><td width="80%">
<a href="/usage/terms/history/">http://dublincore.org/usage/terms/history/</a>
</td></tr>

<tr><td width="20%">
<a name="ISO15836"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[ISO15836]
</td><td width="80%">
<a href="http://www.iso.org/iso/search.htm?qt=15836&searchSubmit=Search&sort=rel&type=simple&published=on">http://www.iso.org/iso/search.htm?qt=15836&searchSubmit=Search&sort=rel&type=simple&published=on</a>
</td></tr>

<tr><td width="20%">
<a name="NAMESPACE"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[NAMESPACE]
</td><td width="80%">
<a href="/documents/dcmi-namespace/">http://dublincore.org/documents/dcmi-namespace/</a>
</td></tr>

<tr><td width="20%">
<a name="NISOZ3985"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[NISOZ3985]
</td><td width="80%">
<a href="http://www.niso.org/standards/z39-85-2007/">http://www.niso.org/standards/z39-85-2007/</a>
</td></tr>

<tr><td width="20%">
<a name="REVISIONS"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[REVISIONS]
</td><td width="80%">
<a href="/usage/decisions/2010/dcterms-changes/">http://dublincore.org/usage/decisions/2010/dcterms-changes/</a>
</td></tr>

<tr><td width="20%">
<a name="RFC5013"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[RFC5013]
</td><td width="80%">
<a href="http://www.ietf.org/rfc/rfc5013.txt">http://www.ietf.org/rfc/rfc5013.txt</a>
</td></tr>

<tr><td width="20%">
<a name="TRANSLATIONS"><xsl:text disable-output-escaping='yes'>&amp;nbsp;</xsl:text></a>[TRANSLATIONS]
</td><td width="80%">
<a href="/resources/translations/">http://dublincore.org/resources/translations/</a>
</td></tr>


</table>
</xsl:template>
</xsl:stylesheet>

