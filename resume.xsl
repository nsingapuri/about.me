<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"
    indent="yes"
    version="4.0"
/>
    <xsl:template match="/resume">
        <html>
            <head>
                <title><xsl:value-of select="name"/> - R&#233;sum&#233;</title>
                <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.18.1/build/cssreset/cssreset-min.css"/>
                <link rel="stylesheet" type="text/css" href="assets/contemporary.css"/>
            </head>
            <body>
                <div id="header">
                    <h1 id="title">R&#233;sum&#233;</h1>
                    <h1 id="candidate"><xsl:value-of select="name"/></h1>

                    <div id="contact">
                        <xsl:value-of select="phone"/><br/>
                        <xsl:value-of select="email"/>
                    </div>

                    <div id="address">
                        <xsl:value-of select="address/street"/><br/>
                        <xsl:value-of select="address/city"/>, <xsl:value-of select="address/state"/>. <xsl:value-of select="address/zip"/>
                    </div>

                    <div id="links">
                        <xsl:copy-of select="github"/><br/>
                        <xsl:copy-of select="website"/>
                    </div>
                </div>
                <div id="content">
                    <div id="objective" class="section">
                        <h2>Objective</h2>
                        <xsl:for-each select="objectives/objective">
                            <p><xsl:call-template name="escapeHtml"/></p>
                        </xsl:for-each>
                    </div>

                    <div id="skills" class="section inline_list">
                        <h2>Skills</h2>
                        <ul>
                            <xsl:for-each select="skills/group">
                                <xsl:call-template name="unsortedListRecursive"/>
                            </xsl:for-each>
                        </ul>
                    </div>

                    <div id="experience" class="section">
                        <h2>Experience</h2>
                        <xsl:for-each select="experiences/experience">
                            <div>
                                <div class="header">
                                    <h3>
                                        <xsl:value-of select="employer/name"/>
                                    </h3>
                                    <h4>
                                        <xsl:value-of select="substring(startDate,1,4)"/> -
                                        <xsl:choose>
                                            <xsl:when test="endDate != ''">
                                                <xsl:value-of select="substring(endDate,1,4)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                present
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </h4>
                                </div>
                                <div class="experience_description">
                                    <h5>
                                        <xsl:value-of select="jobDescription/title"/>
                                    </h5>

                                    <xsl:if test="employer/summary">
                                        <p><em>
                                            <xsl:value-of select="employer/summary"/>
                                        </em></p>
                                    </xsl:if>
                                    <xsl:if test="jobDescription/summary">
                                        <p><em>
                                            <xsl:value-of select="jobDescription/summary"/>
                                        </em></p>
                                    </xsl:if>
                                    <xsl:if test="jobDescription/responsibilities/responsibility">
                                        <div class="responsibilities">
                                            <ul>
                                                <xsl:for-each select="jobDescription/responsibilities/responsibility">
                                                    <li>
                                                        <xsl:choose>
                                                            <xsl:when test="@summary">
                                                                <strong><xsl:value-of select="@summary"/></strong>
                                                                <xsl:call-template name="escapeHtml"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:call-template name="escapeHtml"/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="jobDescription/projects/project">
                                        <div class="projects">
                                            <ul>
                                                <xsl:for-each select="jobDescription/projects/project">
                                                    <li>
                                                        <strong>
                                                            <xsl:value-of select="@summary"/>
                                                        </strong>
                                                        <xsl:if test="@role">
                                                            (<xsl:value-of select="@role"/>)
                                                        </xsl:if>
                                                        <ul>
                                                            <xsl:for-each select="description">
                                                                <li>
                                                                    <strong>
                                                                        <xsl:call-template name="CamelCaseWord">
                                                                            <xsl:with-param name="text" select="name(.)"/>
                                                                        </xsl:call-template>:
                                                                    </strong>
                                                                    <xsl:value-of select=".">
                                                                        <xsl:call-template name="escapeHtml"/>
                                                                    </xsl:value-of>
                                                                </li>
                                                            </xsl:for-each>
                                                            <xsl:for-each select="scope">
                                                                <li>
                                                                    <strong>
                                                                        <xsl:call-template name="CamelCaseWord">
                                                                            <xsl:with-param name="text" select="name(.)"/>
                                                                        </xsl:call-template>:
                                                                    </strong>
                                                                    <xsl:value-of select=".">
                                                                        <xsl:call-template name="escapeHtml"/>
                                                                    </xsl:value-of>
                                                                </li>
                                                            </xsl:for-each>
                                                            <xsl:if test="deliverables/deliverable">
                                                                <li>
                                                                    <strong>Deliverables:</strong>
                                                                    <ul>
                                                                        <xsl:for-each select="deliverables/deliverable">
                                                                            <li>
                                                                                <xsl:call-template name="escapeHtml"/>
                                                                            </li>
                                                                        </xsl:for-each>
                                                                    </ul>
                                                                </li>
                                                            </xsl:if>
                                                        </ul>
                                                    </li>
                                                </xsl:for-each>
                                            </ul>
                                        </div>
                                    </xsl:if>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>

                    <div id="education" class="section inline_list">
                        <h2>Education</h2>
                        <xsl:for-each select="education">
                            <div>
                                <h3>
                                    <xsl:value-of select="educator/name"/>
                                </h3>
                                <ul>
                                    <xsl:for-each select="degrees/*">
                                        <xsl:call-template name="unsortedListRecursive"/>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:for-each>
                    </div>

                    <div id="interests" class="section inline_list">
                        <h2>Interests</h2>
                        <ul>
                            <xsl:for-each select="interests/interest">
                                <xsl:call-template name="unsortedListRecursive"/>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>

                <br/>
                <div id="footer">
                    <xsl:value-of select="name"/> R&#233;sum&#233;: <xsl:value-of select="email"/> | <xsl:value-of select="phone"/>
                </div>
                <br/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="*" name="escapeHtml">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="em" name="escapeEmphasis">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="strong" name="escapeStrong">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="strike" name="escapeStrong">
        <strike><xsl:apply-templates/></strike>
    </xsl:template>

    <xsl:template match="br" name="escapeLinebreak">
        <br/><xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="a" name="escapeAnchor">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@href"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template name="CamelCaseWord">
        <xsl:param name="text"/>
        <xsl:value-of select="translate(substring($text,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        <xsl:value-of select="translate(substring($text,2,string-length($text)-1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
    </xsl:template>

    <xsl:template match="*" name="unsortedListRecursive">
        <li>
            <xsl:if test="@name">
                <xsl:value-of select="@name"/>
            </xsl:if>

            <xsl:choose>
                <xsl:when test="*">
                    <ul>
                        <xsl:for-each select="*">
                            <xsl:call-template name="unsortedListRecursive"/>
                        </xsl:for-each>
                    </ul>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="escapeHtml"/>
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>
</xsl:stylesheet>
