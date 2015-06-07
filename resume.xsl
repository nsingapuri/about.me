<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"
    indent="yes"
    version="4.0"
/>
    <xsl:template match="/resume">
        <html>
            <head>
                <title><xsl:value-of select="name"/> - Resume</title>
                <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.18.1/build/cssreset/cssreset-min.css"/>
                <link rel="stylesheet" type="text/css" href="assets/contemporary.css"/>
            </head>
            <body>
                <div id="header">
                    <h1 id="title">Resume</h1>
                    <h1 id="candidate"><xsl:value-of select="name"/></h1>

                    <div id="contact">
                        <xsl:copy-of select="phone"/><br/>
                        <xsl:copy-of select="email"/>
                    </div>

                    <div id="links">
                        <xsl:copy-of select="website"/><br/>
                        <xsl:copy-of select="github"/>
                    </div>

                    <div id="address">
                        <xsl:value-of select="address/street"/>
                        <xsl:value-of select="address/city"/>, <xsl:value-of select="address/state"/>. <xsl:value-of select="address/zip"/>
                    </div>

                </div>
                <div id="content">
                    <div id="objective" class="section">
                        <h2><span>Objective</span></h2>
                        <xsl:for-each select="objectives/objective">
                            <p><xsl:call-template name="escapeHtml"/></p>
                        </xsl:for-each>
                    </div>
                    <div id="skills" class="section inline_list">
                        <h2><span>Skills</span></h2>
                        <ul>
                            <xsl:for-each select="skills/group">
                                <xsl:call-template name="unsortedListRecursive"/>
                            </xsl:for-each>
                        </ul>
                    </div>

                    <div id="experience" class="section">
                        <h2><span>Experience</span></h2>
                        <xsl:for-each select="experiences/experience">
                            <div>
                                <div class="header">
                                    <h3>
                                        <xsl:value-of select="employer/name"/>
                                        <xsl:if test="employer/address">
                                            <span class="location"><xsl:value-of select="employer/address/city"/>, <xsl:value-of select="employer/address/state"/></span>
                                        </xsl:if>
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
                                <xsl:for-each select="jobDescriptions/jobDescription">
                                <div class="experience_description">
                                    <h5>
                                        <xsl:value-of select="title"/>
                                    </h5>
                                    <xsl:if test="employer/summary">
                                        <p><em>
                                            <xsl:value-of select="employer/summary"/>
                                        </em></p>
                                    </xsl:if>
                                    <xsl:if test="summary">
                                        <p><em>
                                            <xsl:value-of select="summary"/>
                                        </em></p>
                                    </xsl:if>
                                    <xsl:if test="responsibilities/responsibility">
                                        <div class="responsibilities">
                                            <ul>
                                                <xsl:for-each select="responsibilities/responsibility">
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
                                 </div>
                                </xsl:for-each>
                            </div>
                        </xsl:for-each>
                    </div>

                    <div id="education" class="section inline_list">
                        <h2><span>Education</span></h2>
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

                    <div id="publications" class="section inline_list">
                        <h2><span>Publications</span></h2>
                        <xsl:for-each select="publications/publication">
                            <div>
                                <h3>
                                    <xsl:value-of select="name"/>
                                    <span class="location">
                                        <xsl:value-of select="venue"/>
                                    </span>
                                </h3>
                                <h4>
                                    <xsl:value-of select="startDate"/>
                                </h4>
                                <ul>
                                    <xsl:for-each select="url">
                                        <xsl:call-template name="unsortedListRecursive"/>
                                    </xsl:for-each>
                                </ul>
                            </div>
                        </xsl:for-each>
                    </div>

                    <div id="interests" class="section inline_list">
                        <h2><span>Interests</span></h2>
                        <ul>
                            <xsl:for-each select="interests/interest">
                                <xsl:call-template name="unsortedListRecursive"/>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>
                <br/>
                <br/>
                <br/>
                <br/>
                <div id="footer">
                    <xsl:value-of select="name"/> Resume: <xsl:value-of select="email"/> | <xsl:value-of select="phone"/>
                </div>
                <br/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="escapeHtml">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="em" name="escapeEmphasis">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="strong" name="escapeStrong">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="strike" name="escapeStrike">
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

