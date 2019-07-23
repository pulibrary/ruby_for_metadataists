<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ead="urn:isbn:1-931666-22-9" exclude-result-prefixes="ead">
  <xsl:template match="/">
    <arkurl><xsl:value-of select="//ead:eadid/@url"/></arkurl>
  </xsl:template>
</xsl:stylesheet>
