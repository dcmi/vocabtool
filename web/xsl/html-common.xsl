<?xml version="1.0" encoding="utf-8" ?>

<xsl:transform
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	>

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
								<xsl:apply-templates select="@datatype" />
								<xsl:value-of select="@label"/>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a>
								<xsl:attribute name="href">
									<xsl:apply-templates />
								</xsl:attribute>
								<xsl:apply-templates select="@property" mode="rel" />
								<xsl:apply-templates select="@datatype" />
								<xsl:apply-templates />
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:copy-of select="@*" />
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

<xsl:template match="@property | @datatype">
	<xsl:copy />
</xsl:template>

<xsl:template match="match">
	<xsl:apply-templates select="@property" />
	<xsl:apply-templates select="@datatype" />
</xsl:template>

<xsl:template match="match" mode="rel">
	<xsl:apply-templates select="@property" mode="rel" />
	<xsl:apply-templates select="@datatype" />
</xsl:template>

<!-- apply to all children of term for which there are not specific templates, -->
<!-- thought this would have a default priority lower than other matching templates, but unfortunately needs @priority (slight hack) -->
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

<xsl:template name="fragmentCheckingRow">
	<xsl:param name="context" select="." />
	<tr class="attribute">
		<th scope="row">
			<xsl:value-of select="translate(local-name($context), '-', ' ')"/>:
		</th>
		<td axis="{local-name($context)}">
			<a>
				<xsl:attribute name="href">
					<xsl:apply-templates select="$context/node()" />
				</xsl:attribute>
				<xsl:apply-templates select="key('map',local-name($context))" mode="rel" />
				<xsl:choose>
					<xsl:when test="contains($context/text(), '#')">
						<xsl:value-of select="substring-after($context/text(), '#')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="$context/node()" />
					</xsl:otherwise>
				</xsl:choose>
			</a>
		</td>
	</tr>
</xsl:template>

</xsl:transform>
