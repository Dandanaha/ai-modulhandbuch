﻿ <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:template match="/">
      <!-- example for a simple fo file. At the beginning the page layout is set.
      Below fo:root there is always
    - a single fo:layout-master-set which defines one or more page layouts
    - an optional fo:declarations
    - and a sequence of one or more fo:page-sequences containing the text and formatting instructions
    -->

    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

      <fo:layout-master-set>
      <!-- fo:layout-master-set defines in its children the page layout:
           the pagination and layout specifications
          - page-masters: have the role of describing the intended subdivisions
                           of a page and the geometry of these subdivisions
                          In this case there is only a simple-page-master which defines the
                          layout for all pages of the text
      -->
        <!-- layout information -->
        <fo:simple-page-master master-name="simple"
                      page-height="29.7cm"
                      page-width="21cm"
                      margin-top="1cm"
                      margin-bottom="2cm"
                      margin-left="2.5cm"
                      margin-right="2.5cm">
          <fo:region-body margin-top="3cm"/>
          <fo:region-before extent="3cm"/>
          <fo:region-after extent="1.5cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <!-- end: defines page layout -->


      <!-- start page-sequence
           here comes the text (contained in flow objects)
           the page-sequence can contain different fo:flows
           the attribute value of master-name refers to the page layout
           which is to be used to layout the text contained in this
           page-sequence-->
      <fo:page-sequence master-reference="simple">

          <!-- start fo:flow
               each flow is targeted
               at one (and only one) of the following:
               xsl-region-body (usually: normal text)
               xsl-region-before (usually: header)
               xsl-region-after  (usually: footer)
               xsl-region-start  (usually: left margin)
               xsl-region-end    (usually: right margin)
               ['usually' applies here to languages with left-right and top-down
                writing direction like English]
               in this case there is only one target: xsl-region-body
            -->
        <fo:flow flow-name="xsl-region-body">

          <!-- each paragraph is encapsulated in a block element
               the attributes of the block define
               font-family and size, line-heigth etc. -->

          <!-- this defines a title -->
          <fo:block font-size="18pt"
                font-family="sans-serif"
                line-height="24pt"
                space-after.optimum="15pt"
                background-color="blue"
                color="white"
                text-align="center"
                padding-top="3pt">
            Extensible Markup Language (XML) 1.0
          </fo:block>


          <!-- this defines normal text -->
          <fo:block font-size="12pt"
                    font-family="sans-serif"
                    line-height="15pt"
                    space-after.optimum="3pt"
                    text-align="justify">
            The Extensible Markup Language (XML) is a subset of SGML that is completely described in this document. Its goal is to
            enable generic SGML to be served, received, and processed on the Web in the way that is now possible with HTML. XML
            has been designed for ease of implementation and for interoperability with both SGML and HTML.
          </fo:block>

          <!-- this defines normal text -->
          <fo:block font-size="12pt"
                    font-family="sans-serif"
                    line-height="15pt"
                    space-after.optimum="3pt"
                    text-align="justify">
            The Extensible Markup Language (XML) is a subset of SGML that is completely described in this document. Its goal is to
            enable generic SGML to be served, received, and processed on the Web in the way that is now possible with HTML. XML
            has been designed for ease of implementation and for interoperability with both SGML and HTML.
          </fo:block>

        </fo:flow> <!-- closes the flow element-->
      </fo:page-sequence> <!-- closes the page-sequence -->
    </fo:root>
    </xsl:template>
</xsl:stylesheet>