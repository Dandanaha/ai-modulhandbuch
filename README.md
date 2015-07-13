# Modulhandbuch Angewandte Informatik

Dieses Repository enthält die erforderlichen Dateien, um das
Modulhandbuch des Studiengangs Angewandte Informatik der Hochschule
Worms zu generieren.

Das Modulhandbuch wird im Format PDF und XML bereitgestellt.



## Arbeitsablauf zur Modifizierung des Modulhandbuchs

In diesem Repository ist eine Webseite enthalten, mit der die Rohdaten des Modulhandbuchs bearbeitet werden können, ohne XML Kenntnisse zu besitzen.

Der generelle Arbeitsablauf ist wie folgt:

1. Aufrufen der Website
2. Importieren der Rohdaten (von lokal oder vom Server)
3. Bearbeiten der Module
4. Exportieren der aktualisierten Rohdaten auf eigene Maschine
5. Einchecken in Repository (src/hs-data.xml überschreiben)



## Bedienung des Editors (Website)
### Öffnen der Rohdaten
Nachdem die Website aufgerufen wurde, ist die einzige verfügbare Funktion "IMPORTIEREN". Alle anderen Optionen sind entweder versteckt oder ausgegraut. Mit einem Klick auf den IMPORTIEREN Button öffnet sich ein modaler Dialog. Hier hat der Nutzer nun die Wahl, seine eigene XML mit Moduldaten zu öffnen, oder die aktuellste Version vom Server zu laden. In beiden Fällen führt der erfolgreiche Importvorgang zur Schließung des Dialogs und zur Anzeige der geladenen Module.

### Die Bedienelemente 
Die Verwaltung der Daten geschieht in zwei Tabs, der Strukturtab und der Modultab, wobei Module als Standard ausgewählt ist. Über die beiden gleichnamigen Buttons direkt über den Daten kann die Ansicht gewechselt werden. Die "Struktur" des Modulhandbuchs an sich kann in dieser Version nicht verändert werden, hier sind lediglich die Beschreibungstexte jeweils unter einem neuen Abschnitt editierbar.

Die Filterfunktion wird dafür verwendet, bestimmte Module innerhalb der Liste besser zu finden und kann nach verschiedenen Parametern filtern. Der aktive Parameter wird mit dem Auswahl-Dropdown direkt rechts neben dem Eingabefeld festgelegt.

In der Kopfzeile sind schließlich die beiden bisher ausgegrauten Buttons aktivierbar. Durch Klick auf "MODUL HINZUFÜGEN" öffnet sich ein modaler Dialog, in dem die Untergruppe festgelegt wird, zu der das neue Modul gehören soll. Das neue Modul wird an die letzte Stelle der gewählten Kategorie gesetzt und sein Code automatisch auf die nächste freie Stelle gesetzt. (z.B. 1.1.4)

Mit "EXPORTIEREN" wird der Download der neuen Rohdaten in XML Form ausgelöst. Das Verhalten bei Dateidownloads ist in den Einstellungen des verwendeten Browsers festgelegt.


### Bearbeiten der Struktur
Wenn der Strukturtab gewählt ist, erscheinen alle Kategorien mit ihrer Nummer und die Module sind ausgeblendet. Unter jeder Kategorie befindet sich ein Textfeld, in dem die passende Beschreibung eingegeben werden kann. Derzeit gibt es außer des im Browser eingebauten 'Strg+Z' keine Möglichkeit, die Änderungen rückgängig zu machen. 

Die Änderungen in den Textfeldern werden ohne explizite Bestätigung für den neuen Datensatz übernommen und werden beim Export berücksichtigt.


### Bearbeiten eines Moduls
Ist der Modultab ausgewählt, so werden alle Module und Kategorien, die im geöffneten Datensatz vorkommen, angezeigt. Um ein Modul zu bearbeiten, muss mit einem Klick auf das Bleistift Symbol des Moduls der Bearbeitungsmodus aktiviert werden. Danach sind alle Felder des Moduls editierbar.

#### Reintext
Textfelder werden wie gewohnt bearbeitet.

#### Listen
Listenelemente, erkennbar am vorausgehenden schwarzen Punkt, werden hinzugefügt, indem der neue Eintrag in das leere Feld am Ende der Liste geschrieben wird. Mit der Enter Taste wird das neue Element an die Liste angefügt und das Eingabefeld wird geleert.
Mit einem Klick auf das X wird das entsprechende Listenelement gelöscht.
Die bestehenden Listenelemente können wie die Reintext Elemente nach Belieben editiert werden.
Mit Listenelementen zweiter Ebene wird genauso verfahren.

__Der Inhalt des leeren Feldes wird beim verlassen des Berbeitungsmodus verworfen, die Elemente müssen also unbedingt mit Enter der entsprechenden Liste hinzugefügt werden.__


Nachdem alle Änderungen vorgenommen wurden, hat der Nutzer zwei Optionen, die über die Buttons in der oberen rechten Ecke des Moduls ausgelöst werden. Beide beenden den Bearbeitungsmodus.

Der GRÜNE HAKEN übernimmt alle Änderungen und aktualisiert den Inhalt des Moduls.

Das ROTE KREUZ verwirft alle Änderungen und versetzt das Modul in seinen Urzustand.



## Technisches
### PDF-Generierung

Das Modulhandbuch wird über einen Jenkins-Job generiert (siehe unten).
Zum Testen, ob die Generierung funktioniert, kann dies auch lokal auf
einem Linux-Rechner durchgeführt werden:

    cd src
    ./run-fop

### Website
#### Daten

Die aus dem Editor exportierte XML-Datei muss nach src/hs-data.xml
verschoben werden. Nach git commit und git push wird das Modulhandbuch
auf Jenkins automatisch erzeugt und auf den Webserver transferiert.

Das Ergebnis ist dann z.B. per wget abholbar (analog zur App):

    wget http://ai.it.hs-worms.de/mm/mm.xml
    wget http://ai.it.hs-worms.de/mm/modulhandbuch-aninf.pdf

#### Bereitstellung

Es wird sowohl der Quellcode der Website als auch eine fertig gebaute Version bereitgestellt. Die gebaute Version befindet sich in folgendem Ordner:

> config/website/dist

Um die Website zu verwenden, kann sie entweder über die verwendete Buildumgebung gestartet (Erklärung weiter unten) oder auf einem beliebigen HTTP Server gehostet werden. Die Seite verfügt über keinerlei Nutzerverwaltung, weswegen auch die öffentliche Bereitstellung der Website keine Sicherheitsprobleme darstellt.

#### Bauen des Quellcodes
Die Website ist mithilfe zahlreicher Buildtools realisiert, die sich mit bower (http://http://bower.io/) und dem Node Package Manager (https://www.npmjs.com/) installieren lassen. Für letzteres wird Node.js (https://nodejs.org/) benötigt.

Unter Ubuntu Linux:

    apt-get install npm
    ln -s /usr/bin/nodejs /usr/local/bin/node

Nachdem Node.js auf der Maschine installiert ist, die den Buildprozess ausführen soll, müssen u.U. zunächst bower und dann die bereits festgelegten Abhängigkeiten installiert werden.

Installiere Bower

    npm install --global bower

Installiere gulp

    npm install --global gulp
    npm install --save-dev gulp

Installiere sass

    apt-get install ruby-sass

Installiere fehlende npm Pakete (definiert in package.json)

    npm install

Installiere fehlende bower Pakete (definiert in bower.json, benötigt git)

    bower install

Nachdem alle Abhängigkeiten installiert sind, kann entweder der Bauvorgang ausgelöst oder eine lokale Serverinstanz gestartet werden, auf der die Website laufen kann.

Auslösen des Bauvorgangs

    gulp clean
    gulp build

Starten des lokalen Servers (Öffnet nach erfolgreichem Bau ein Browserfenster mit der Website)

    gulp serve


(c) 2015 Hochschule Worms, aninf-mm@hs-worms.de

