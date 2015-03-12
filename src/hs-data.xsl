 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Definition of reusable styles -->
  <!-- Header of a module page -->
  <xsl:attribute-set name="module-header">
    <xsl:attribute name="font-size">18pt</xsl:attribute>
    <xsl:attribute name="font-family">sans-serif</xsl:attribute>
    <xsl:attribute name="line-height">24pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">15pt</xsl:attribute>
    <xsl:attribute name="background-color">#8BA8E1</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="padding-top">3pt</xsl:attribute>
    <xsl:attribute name="padding-left">2pt</xsl:attribute>
    <xsl:attribute name="border-color">black</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
  </xsl:attribute-set>

  <!-- Table cell of a module page -->
  <xsl:attribute-set name="module-table-cell-reg">
    <xsl:attribute name="border-color">black</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-bottom">none</xsl:attribute>
    <xsl:attribute name="padding-left">2pt</xsl:attribute>
    <xsl:attribute name="padding-right">2pt</xsl:attribute>
    <xsl:attribute name="padding-top">1pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">1pt</xsl:attribute>
  </xsl:attribute-set>
  <!-- First table cell of a module page - the only one that needs an upper border-->
  <xsl:attribute-set name="module-table-cell-first">
    <xsl:attribute name="border-color">black</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="padding-left">2pt</xsl:attribute>
    <xsl:attribute name="padding-right">2pt</xsl:attribute>
    <xsl:attribute name="padding-top">1pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">1pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="/">
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
        <fo:simple-page-master master-name="manual-intro"
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
        <fo:simple-page-master master-name="module-page"
                      page-height="29.7cm"
                      page-width="21cm"
                      margin-top="1cm"
                      margin-bottom="2cm"
                      margin-left="2cm"
                      margin-right="2cm">
          <fo:region-body margin-top="1cm"/>
          <fo:region-before extent="1cm"/>
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
      <fo:page-sequence master-reference="manual-intro">

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
            Modulhandbuch der Hochschule Worms
          </fo:block>


          <!-- this defines normal text -->
          <fo:block font-size="12pt"
                    font-family="sans-serif"
                    line-height="15pt"
                    space-after.optimum="3pt"
                    text-align="justify">
            Es ist zwar noch im Aufbau, aber schlussendlich wird dieses generierte Dokument das komplette Modulhandbuch hier zu lesen sein
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
    <xsl:apply-templates/>
  </fo:root>
  </xsl:template>
  <xsl:template match="modules/part/sub/module">
    <fo:page-sequence master-reference="module-page">
      <fo:flow flow-name="xsl-region-body">
        <fo:block xsl:use-attribute-sets="module-header">
          Modul <xsl:value-of select="name/code"/>: <xsl:value-of select="name/title"/>
        </fo:block>
        <fo:table border-collapse="separate" table-layout="fixed" width="100%">
          <fo:table-column column-width="33.33%"/>
          <fo:table-column column-width="66.66%"/>

          <fo:table-body>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-first">
                <fo:block>
                  Modul-Nr. / Code
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-first">
                <fo:block>
                  Modul <xsl:value-of select="name/code"/> / <xsl:value-of select="name/abbr"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Modulbezeichnung
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="name/title"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Vorgesehenes Semester
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="sem"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Art der Lehrveranstaltung
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="type"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  ggfs. Lehrveranstaltungen des Moduls
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Ich hab immer noch keine Ahnung, was das heißen soll
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Häufigkeit des Angebots
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="offered-semesters"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Zugangsvoraussetzungen
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="requirements"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Verwendbarkeit des Moduls für andere Studiengänge
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="other-majors"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Modulverantwortliche Person
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="responsible"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Lehrende Person
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="professor"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Lehrsprache
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="lang"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Zugeteilte ECTS-Punkte
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="pts"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Gesamtworkload
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="workload"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  SWS
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="sws"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Art der Prüfung
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                  <fo:block>
                    <xsl:for-each select="extype">
                      <xsl:value-of select="."/>  
                    </xsl:for-each>
                  </fo:block>    
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Gewichtung der Note in der Gesamtnote
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="weight"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Qualifikationsziele des Moduls
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="description/target"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Inhalte des Moduls
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="description/content"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Lehr- und Lernmethoden
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="methods"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Besonderes
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="special"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Pflichtlektüre
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="scripts"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  Zusätzlich empfohlene Literatur
                </fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                <fo:block>
                  <xsl:value-of select="literature"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>

      </fo:flow> <!-- closes the flow element-->
    </fo:page-sequence> <!-- closes the page-sequence -->
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>