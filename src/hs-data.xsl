 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!-- Definition of reusable styles -->
  <!-- Header of a module page -->
  <xsl:attribute-set name="module-header">
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-family">Liberation Sans</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="line-height">24pt</xsl:attribute>
    <xsl:attribute name="space-after.optimum">15pt</xsl:attribute>
    <xsl:attribute name="background-color">#8BA8E1</xsl:attribute>
    <xsl:attribute name="color">black</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="padding-top">5pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
    <xsl:attribute name="padding-left">3pt</xsl:attribute>
    <xsl:attribute name="border">1.2pt outset black</xsl:attribute>

  </xsl:attribute-set>

  <!-- Table cell of a module page -->
  <xsl:attribute-set name="module-table-cell-reg">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="font-family">Arial</xsl:attribute>
    <xsl:attribute name="border-color">black</xsl:attribute>
    <xsl:attribute name="border-width">0.8pt</xsl:attribute>
    <xsl:attribute name="border-style">inset</xsl:attribute>
    <xsl:attribute name="padding-left">2pt</xsl:attribute>
    <xsl:attribute name="padding-right">2pt</xsl:attribute>
    <xsl:attribute name="padding-top">2pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">1pt</xsl:attribute>
    <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
  </xsl:attribute-set>

  <!-- First table cell of a module page - the only one that needs an upper border-->
  <xsl:attribute-set name="module-table-cell-first" use-attribute-sets="module-table-cell-reg">
     <xsl:attribute name="border-top">0.5pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <!-- layout information -->
        <fo:simple-page-master master-name="manual-intro"
                      page-height="29.7cm"
                      page-width="21cm"
                      margin-top="2cm"
                      margin-bottom="2cm"
                      margin-left="2cm"
                      margin-right="2cm">
          <fo:region-body/>
          <fo:region-before extent="1cm"/>
          <fo:region-after extent="1.27cm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="module-page"
                      page-height="29.7cm"
                      page-width="21cm"
                      margin-top="1.27cm"
                      margin-bottom="0cm"
                      margin-left="2.5cm"
                      margin-right="1.3cm">
          <fo:region-body margin-top="1.27cm" margin-bottom="1.5cm"/>
          <fo:region-before extent="1cm"/>
          <fo:region-after extent="1.27cm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <!-- end: defines page layout -->
      <xsl:apply-templates/>
    </fo:root>
  </xsl:template>

  <xsl:template match="info">
    <!-- Frontpage -->
    <fo:page-sequence master-reference="manual-intro" id="frontpage" force-page-count="no-force">
      <fo:flow flow-name="xsl-region-body">
        <fo:table border-collapse="collapse" table-layout="fixed" width="100%" border="1pt solid black">
          <fo:table-column column-width="60%"/>
          <fo:table-column column-width="40%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell background-color="#ED7E00"
                padding-left="5pt"
                padding-top="15pt"
                padding-bottom="12pt"
                font-weight="bold">
                <fo:block font-size="18pt">
                  Bachelor of Science
                </fo:block>
                <fo:block font-size="24pt">
                  Angewandte Informatik
                </fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block>
                  <fo:external-graphic src="url(img/powered_by_mm.png)" content-height="27.3mm" content-width="66.9mm" scaling="non-uniform">
                  </fo:external-graphic>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
        <fo:block font-size="8pt"
          line-height="15pt"
          margin-left="10pt">
          Stand: <xsl:value-of select="substring(changed,4,2)"/>.<xsl:value-of select="substring(changed,1,2)"/>.<xsl:value-of select="substring(changed,7,4)"/>
        </fo:block>
        <fo:block text-align="center"
          font-size="48pt"
          space-before.optimum="195pt">
          Modulhandbuch
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>

  <xsl:template match="modules">
    <!-- Table of contents -->
    <fo:page-sequence master-reference="module-page" id="toc" format="i" force-page-count="no-force" initial-page-number="1">
      <!-- Header -->
      <fo:static-content flow-name="xsl-region-before" font-size="11pt" font-family="Arial">
        <fo:block text-align-last="justify">
          Modulhandbuch Angewandte Informatik B.Sc.
          <fo:leader leader-pattern="space" />
          Hochschule Worms, Fachbereich Informatik
        </fo:block>
      </fo:static-content>

      <!-- Footer -->
      <fo:static-content flow-name="xsl-region-after" font-size="8pt" font-family="Arial" >
       <fo:block text-align-last="justify">
        Fassung vom <xsl:value-of select="substring(../info/changed,4,2)"/>.<xsl:value-of select="substring(../info/changed,1,2)"/>.<xsl:value-of select="substring(../info/changed,7,4)"/>, <xsl:value-of select="substring(../info/changed,12,8)"/>
        <fo:leader leader-pattern="space" />
        <fo:leader leader-pattern="space" />
        <fo:page-number format="i"/>
       </fo:block>
      </fo:static-content>

      <fo:flow flow-name="xsl-region-body" >
        <fo:block font-size="16pt"
          font-family="Liberation Sans"
          color="#004485"
          page-break-before="always">
          Inhalt
        </fo:block>
        <fo:block font-size="12pt"
              font-family="Arial"
              color="black"
              text-align="left"
              >
          <fo:block text-align-last="justify"
              margin-top="10pt"
              line-height="20pt"
              margin-left="8pt">  
               <fo:basic-link internal-destination="structure">
                  <fo:inline padding-left="5pt">Struktur des Studiengangs</fo:inline>
                  <fo:leader leader-pattern="dots" />
                  <fo:page-number-citation ref-id="structure"/>                        
               </fo:basic-link>     
          </fo:block>
          <xsl:for-each select="part">
            <fo:block text-align-last="justify"
              margin-top="10pt"
              line-height="20pt">  
                 <fo:basic-link internal-destination="{generate-id()}">
                    <fo:inline> <xsl:value-of select="./@code"/></fo:inline>
                    <fo:inline padding-left="5pt"><xsl:value-of select="./@name"/></fo:inline>
                    <fo:leader leader-pattern="dots" />
                    <fo:page-number-citation ref-id="{generate-id()}"/>                        
                 </fo:basic-link>     
            </fo:block>
            <xsl:for-each select="sub">
              <xsl:if test="./@code != 2 and ./@code &lt; 4">
                <fo:block margin-left="18pt"
                  font-size="12pt"
                  text-align-last="justify"
                  font-family="Arial"
                  line-height="20pt"
                  margin-top="3pt">  
                   <fo:basic-link internal-destination="{generate-id()}">
                      <fo:inline> <xsl:value-of select="./@code"/></fo:inline>
                      <fo:inline padding-left="10pt"><xsl:value-of select="./@name"/></fo:inline>
                      <fo:leader leader-pattern="dots" />
                      <fo:page-number-citation ref-id="{generate-id()}"/>                        
                   </fo:basic-link>     
                </fo:block>
              </xsl:if>
              <xsl:for-each select="module">
                <fo:block margin-left="45pt"
                  font-size="11pt"
                  line-height="12pt"
                  text-align-last="justify"
                  font-family="Arial"
                  color="#404040">  
                   <fo:basic-link internal-destination="{generate-id()}">
                      <fo:inline>Modul <xsl:value-of select="./@code"/>:</fo:inline>
                      <fo:inline padding-left="10pt"><xsl:value-of select="name/title"/></fo:inline>
                      <fo:leader leader-pattern="dots" />
                      <fo:page-number-citation ref-id="{generate-id()}"/>                        
                   </fo:basic-link>     
                </fo:block>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:for-each>
        </fo:block>
      </fo:flow>
    </fo:page-sequence>

    <!-- Module pages -->
    <fo:page-sequence master-reference="module-page" id="module-pages" initial-page-number="1">
      <!-- Header -->
      <fo:static-content flow-name="xsl-region-before" font-size="11pt" font-family="Arial">
        <fo:block text-align-last="justify">
          Modulhandbuch Angewandte Informatik B.Sc.
          <fo:leader leader-pattern="space" />
          Hochschule Worms, Fachbereich Informatik
        </fo:block>
      </fo:static-content>

      <!-- Footer -->
      <fo:static-content flow-name="xsl-region-after" font-size="8pt" font-family="Arial">
       <fo:block text-align-last="justify">
        Fassung vom <xsl:value-of select="substring(../info/changed,4,2)"/>.<xsl:value-of select="substring(../info/changed,1,2)"/>.<xsl:value-of select="substring(../info/changed,7,4)"/>, <xsl:value-of select="substring(../info/changed,12,8)"/>
        <fo:leader leader-pattern="space" />
        Seite <fo:page-number/> / <fo:page-number-citation-last ref-id="module-pages"/>
       </fo:block>
     </fo:static-content>
  
      <fo:flow flow-name="xsl-region-body">
        <!-- Preamble, which will be kept static for that moment -->
        <fo:block font-size="20pt"
                    line-height="15pt"
                    space-after.optimum="3pt"
                    text-align="justify"
                    color="#355E90"
                    font-family="Liberation Sans"
                    margin-bottom="15pt"
                    id="structure">
            Struktur des Studiengangs
          </fo:block>
          <fo:block>
            Der Studiengang ist in folgende Bereiche gegliedert:
          </fo:block>
          <fo:list-block font-family="Arial">
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Die Vermittlung von Grundkompetenzen in je 6 Modulen im ersten und zweiten Semester, in 4 Modulen im 3. Semester und in den als aufeinanderfolgende Blockveranstaltung durchgeführten Modulen Projektmanagement und Teamorientiertes Projekt im 6. Semester. 
                  Diese Module werden in Kapitel 1 beschrieben.
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Anwendungsbezogene Technologien in je zwei Modulen im 4. und 5. Semester (Modulbeschreibungen in Kapitel 2)
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Module, die einen wählbaren Qualifikationsschwerpunkt darstellen: je 2 Module im 3., 4. und 5. Semester (siehe Kapitel 3)
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Je zwei Wahlmodule im 4. und 5. Semester (Kapitel 4)
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Praxis- oder Auslandssemester (Kapitel 5)
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
            <fo:list-item>
              <fo:list-item-label end-indent="label-end()">
                <fo:block>
                  <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                </fo:block>
              </fo:list-item-label>
              <!-- list text -->
              <fo:list-item-body start-indent="body-start()">
                <fo:block>
                  Abschlussarbeit und Kolloquium (Kapitel 6)
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
          </fo:list-block>
          <fo:block font-family="Arial">
            CP: Credit Points im ECTS (European Credit Transfer System) ≙ Leistungspunkte
          </fo:block>
          <fo:block text-align="center">
            <fo:external-graphic src="url(img/modules-simple.PNG)" content-height="160mm" content-width="190mm">
                  </fo:external-graphic>
          </fo:block>
          <fo:block font-family="Arial">
            Die einzelnen Module sind in den folgenden Grafiken dargestellt.
          </fo:block>

          <!-- Page 2 -->
          <fo:block text-align="center" page-break-before="always">
            <fo:external-graphic src="url(img/modules-detailed.PNG)" content-width="185mm">
            </fo:external-graphic>
          </fo:block>

          <fo:block font-family="Arial">
            Die Module bestehen in der Regel aus einer Vorlesung und einem Praktikum. Für die Praktika stehen modern ausgestattete Labore zur Verfügung, die u.a. mit modernen Servern und PCs (Betriebssysteme Windows, Linux) sowie Apple iMacs (Betriebssystem OS X) ausgestattet sind.
          </fo:block>

          <!-- Page 3 -->
          <fo:block font-family="Arial" page-break-before="always">
            Im Bereich der Qualifikations-Schwerpunkte müssen die Studierenden 6 Module (30 CP) aus den (derzeit 9-10) Modulen des jeweiligen Bereichs auswählen. Am Ende des Studiums müssen die Studierenden nachweisen, dass sie mindestens 6 Module eines bestimmten Qualifikationsschwerpunktes erfolgreich absolviert haben; dieser Qualifikationsschwerpunkt wird dann im Zeugnis genannt.
          </fo:block>
          <fo:block font-family="Arial" margin-top="5pt">
            Das Angebot der wählbaren Module pro Schwerpunkt kann sich in Abhängigkeit von Nachfrage und vorhandenen Ressourcen ändern, solange dadurch die Möglichkeit des Abschlusses eines angestrebten Schwerpunkts für die Studierenden bestehen bleibt.
          </fo:block>
          <fo:block font-family="Arial" margin-top="10pt" margin-bottom="5pt" font-size="18pt">
            Qualifikations-Schwerpunkte (wählbar):
          </fo:block>
          <fo:block text-align="center">
            <fo:external-graphic src="url(img/majors.PNG)" content-height="160mm" content-width="190mm">
                  </fo:external-graphic>
          </fo:block>
          <fo:block font-family="Arial" margin-top="10pt" margin-bottom="5pt" font-size="18pt">
            Beispiele für Wahlmodule:
          </fo:block>
          <fo:block text-align="center">
            <fo:external-graphic src="url(img/electives.png)" content-height="160mm" content-width="190mm">
            </fo:external-graphic>
          </fo:block>
          <fo:block font-family="Arial" margin-top="5pt">
            Im Bereich der Wahlmodule müssen Module im Umfang von 20 CP gewählt werden. Hierfür können neben den als Wahlmodule ausgewiesenen Modulen auch Module aus dem Bereich der Qualifikationsschwerpunkte verwendet werden, wenn sie nicht schon für den Nachweis des gewählten Qualifikationsschwerpunkts benötigt werden. 
          </fo:block>
               
          <!-- End of Preamble -->

        <!-- Actual module pages -->
        <xsl:for-each select="part">
          <fo:block font-size="20pt"
                    line-height="15pt"
                    space-after.optimum="3pt"
                    text-align="justify"
                    color="#355E90"
                    font-family="Liberation Sans"
                    margin-bottom="15pt"
                    id="{generate-id()}"
                    page-break-before="always">
            <xsl:value-of select="./@code"/>
            <fo:inline padding-left="10pt"><xsl:value-of select="./@name"/></fo:inline>
          </fo:block>
          <fo:block>
            <xsl:value-of select="description"/>
          </fo:block>
          <xsl:for-each select="./sub">
            <xsl:if test="./@code != 2 and ./@code &lt; 4">
              <fo:block font-size="16pt"
                      line-height="15pt"
                      space-after.optimum="3pt"
                      text-align="justify"
                      color="#4E80BC"
                      font-family="Liberation Sans"
                      margin-bottom="10pt"
                      id="{generate-id()}">
                <xsl:value-of select="./@code"/>
                <fo:inline padding-left="10pt"><xsl:value-of select="./@name"/></fo:inline>
              </fo:block>
              <fo:block>
                <xsl:value-of select="description"/>
              </fo:block>
            </xsl:if>
            <xsl:for-each select="./module">            
              <fo:table break-after="page" border-collapse="collapse" table-layout="fixed" width="100%" id="{generate-id()}">
                <fo:table-column column-width="33.33%"/>
                <fo:table-column column-width="66.66%"/>
                <fo:table-header space-after.optimum="2cm">
                  <fo:table-row>
                    <fo:table-cell number-columns-spanned="2" xsl:use-attribute-sets="module-header">
                      <fo:block>Modul <xsl:value-of select="name/code"/>: <xsl:value-of select="name/title"/></fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <!-- Empty row to separate Header from table content -->
                  <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                      <fo:block><fo:leader/></fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-header>
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
                        <xsl:variable name="processed-sem">
                          <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="sem" />
                            <xsl:with-param name="replace" select="'3,4,5'" />
                            <xsl:with-param name="by" select="'3.-5. Semester'" />
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:call-template name="string-replace-all">
                          <xsl:with-param name="text" select="$processed-sem" />
                          <xsl:with-param name="replace" select="'4,5'" />
                          <xsl:with-param name="by" select="'4.-5. Semester'" />
                        </xsl:call-template>
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
                        <xsl:variable name="mand">
                          <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="type" />
                            <xsl:with-param name="replace" select="'mandatory'" />
                            <xsl:with-param name="by" select="'Pflichtveranstaltung'" />
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="elec">
                          <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="$mand" />
                            <xsl:with-param name="replace" select="'elective'" />
                            <xsl:with-param name="by" select="'Wahlmodul'" />
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="maj">
                          <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="$elec" />
                            <xsl:with-param name="replace" select="'major'" />
                            <xsl:with-param name="by" select="'Qualifikationsschwerpunkt'" />
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:variable name="pra">
                          <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="$maj" />
                            <xsl:with-param name="replace" select="'practical'" />
                            <xsl:with-param name="by" select="'Praxissemester'" />
                          </xsl:call-template>
                        </xsl:variable>
                        <xsl:call-template name="string-replace-all">
                          <xsl:with-param name="text" select="$pra" />
                          <xsl:with-param name="replace" select="'thesis'" />
                          <xsl:with-param name="by" select="'Bachelorthesis'" />
                        </xsl:call-template>
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
                        -
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
                        <xsl:call-template name="string-replace-all">
                          <xsl:with-param name="text" select="offered-semesters" />
                          <xsl:with-param name="replace" select="'all'" />
                          <xsl:with-param name="by" select="'Semesterweise'" />
                        </xsl:call-template>
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
                      <xsl:choose>
                          <xsl:when test="other-majors!=''">
                            <fo:list-block>
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="other-majors"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                              </fo:list-block>
                          </xsl:when>
                          <xsl:otherwise>
                            <fo:block> - </fo:block>
                          </xsl:otherwise> 
                        </xsl:choose>
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
                      <xsl:choose>
                          <xsl:when test="workload!=''">
                            <fo:list-block>
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="workload"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                              </fo:list-block>
                          </xsl:when>
                          <xsl:otherwise>
                            <fo:block> - </fo:block>
                          </xsl:otherwise> 
                        </xsl:choose>
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
                            <xsl:choose>
                              <xsl:when test=".='written'">
                                <fo:block>Schriftliche Klausur</fo:block>
                              </xsl:when>
                              <xsl:when test=".='practical'">
                                <fo:block>Praktische Studienleistung</fo:block>
                              </xsl:when>
                              <xsl:when test=".='oral'">
                                <fo:block>Mündliche Prüfung / Kolloqium</fo:block>
                              </xsl:when>
                              <xsl:when test=".='presentation'">
                                <fo:block>Präsentation / Vortrag</fo:block>
                              </xsl:when>
                              <xsl:when test=".='paper'">
                                <fo:block>Schriftliche Ausarbeitung</fo:block>
                              </xsl:when>
                              <xsl:when test=".='external'">
                                <fo:block>Hochschulexterne Leistungsfeststellung</fo:block>
                              </xsl:when>
                              <xsl:otherwise>
                                <fo:inline><xsl:value-of select="."/></fo:inline>
                              </xsl:otherwise> 
                            </xsl:choose>
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
                      <fo:list-block>
                        <xsl:choose>
                          <xsl:when test="boolean(description/target)">
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="description/target"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                          </xsl:when>
                          <xsl:otherwise> - </xsl:otherwise> 
                        </xsl:choose>
                      </fo:list-block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                      <fo:block>
                        Inhalte des Moduls
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                      <fo:list-block>
                        <xsl:choose>
                          <xsl:when test="boolean(description/content)">
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="description/content"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                          </xsl:when>
                          <xsl:otherwise>
                            <fo:block> - </fo:block>
                          </xsl:otherwise> 
                        </xsl:choose>
                      </fo:list-block>
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
                     <xsl:choose>
                          <xsl:when test="scripts!=''">
                            <fo:list-block>
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="scripts"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                              </fo:list-block>
                          </xsl:when>
                          <xsl:otherwise>
                            <fo:block> - </fo:block>
                          </xsl:otherwise> 
                        </xsl:choose>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg">
                      <fo:block>
                        Zusätzlich empfohlene Literatur
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="module-table-cell-reg"> 
                        <xsl:choose>
                          <xsl:when test="literature!=''">
                            <fo:list-block>
                              <xsl:call-template name="tokenizeString">
                                  <xsl:with-param name="list" select="literature"/>
                                  <xsl:with-param name="delimiter" select="'=NL'"/>
                                  <xsl:with-param name="isRecursive" select="0"/>
                              </xsl:call-template>
                              </fo:list-block>
                          </xsl:when>
                          <xsl:otherwise>
                            <fo:block> - </fo:block>
                          </xsl:otherwise> 
                        </xsl:choose>   
                    </fo:table-cell>
                  </fo:table-row>
                </fo:table-body>
              </fo:table>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </fo:flow> <!-- closes the flow element-->
      
    </fo:page-sequence> <!-- closes the page-sequence -->
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="string-replace-all">
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--############################################################-->
  <!--## Template to tokenize strings                           ##-->
  <!--############################################################-->
  <xsl:template name="tokenizeString">
  <!--passed template parameter -->
      <xsl:param name="list"/>
      <xsl:param name="delimiter"/>
      <xsl:param name="isRecursive"/>
      <xsl:choose>
          <xsl:when test="contains($list, $delimiter)"> 
              <fo:list-item>
                <fo:list-item-label end-indent="label-end()">
                  <fo:block>
                    <fo:inline font-size="18pt" padding-left="3pt">&#x2022;</fo:inline>
                  </fo:block>
                  </fo:list-item-label>
                  <!-- list text -->
                  <fo:list-item-body start-indent="body-start()">
                    <xsl:variable name="subItems">
                      <!-- Replace =SL with carriage return and bullet point to declare subitem -->
                      <xsl:call-template name="string-replace-all">
                        <xsl:with-param name="text" select="substring-before($list,$delimiter)" />
                        <xsl:with-param name="replace" select="'=SL'" />
                        <xsl:with-param name="by" select="'&#xA;&#x25E6;&#x9;'" />
                      </xsl:call-template>
                    </xsl:variable>
                  <fo:block linefeed-treatment="preserve" white-space-collapse="false" white-space-treatment="preserve">               
                      <xsl:value-of select="$subItems"/>
                  </fo:block>
                </fo:list-item-body>
              </fo:list-item>
              <xsl:call-template name="tokenizeString">
                  <!-- store anything left in another variable -->
                  <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
                  <xsl:with-param name="delimiter" select="$delimiter"/>
                  <xsl:with-param name="isRecursive" select="1"/>
              </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
              <xsl:choose>
                  <xsl:when test="$list = ''">
                      <xsl:text/>
                  </xsl:when>
                  <xsl:otherwise>
                    <fo:list-item>
                      <fo:list-item-label end-indent="label-end()">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="$isRecursive=1">
                              <fo:inline padding-left="3pt" font-size="18pt">&#x2022;</fo:inline>
                            </xsl:when>
                            <xsl:otherwise>
                              <fo:inline></fo:inline>
                            </xsl:otherwise>            
                          </xsl:choose>
                        </fo:block>
                      </fo:list-item-label>
                      
                      <xsl:choose>
                        <xsl:when test="$isRecursive=1">
                          <!-- list text when list contains more than one item-->
                          <fo:list-item-body start-indent="body-start()" provisional-distance-between-starts="inherit">
                            <xsl:variable name="subItems">
                              <!-- Replace =SL with carriage return and bullet point to declare subitem -->
                              <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="$list" />
                                <xsl:with-param name="replace" select="'=SL'" />
                                <xsl:with-param name="by" select="'&#xA;&#x25E6;&#x9;'" />
                              </xsl:call-template>
                            </xsl:variable>
                          <fo:block>                 
                                <xsl:value-of select="$subItems"/>
                          </fo:block>
                        </fo:list-item-body>
                        </xsl:when>
                        <xsl:otherwise>
                          <!-- list text when list contains only one item-->
                          <fo:list-item-body start-indent="body-start()" provisional-distance-between-starts="0">
                            <xsl:variable name="subItems">
                              <!-- Replace =SL with carriage return and bullet point to declare subitem -->
                              <xsl:call-template name="string-replace-all">
                                <xsl:with-param name="text" select="$list" />
                                <xsl:with-param name="replace" select="'=SL'" />
                                <xsl:with-param name="by" select="'&#xA;&#x25E6;&#x9;'" />
                              </xsl:call-template>
                            </xsl:variable>
                            <fo:block>                 
                                  <xsl:value-of select="$subItems"/>
                            </fo:block>
                          </fo:list-item-body>
                        </xsl:otherwise>
                      </xsl:choose>
                    </fo:list-item>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
</xsl:stylesheet>