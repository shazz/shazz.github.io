Title: Die Viren kommen 
Slug: dievirenkommen 
Name: Die Viren kommen
Date: 1987-04-01 12:34
Location: Germany
Category: Atari ST, Virus
Lang: de
Author: Eckhard Krabel
status: published
summary: C'T article on link viruses
image: {filename}../images/ct-0788-2pages.png
Tags: archives

<img src="{attach}../images/ct_virus1.png" width="70%"/>

## Computer-Viren und Abwehrprogramme

**Eckhard Krabel**

Bislang sorgten Computer-Viren nur bei Systemoperatoren und Programmierern von Großrechnern für schlaflose Nächte.
Neuerdings gibt es Viren auch für Personalcomputer. Wir zeigen Ihnen, wie sie funktionieren und wie man sich dagegen schützen kann.

> 'Januar 1987. Endlich, nachdemich vier Wochen auf das neue Super-Lechz-Programm gewartet habe, schalte ich meinen Computer ein, um eine Kopie auf die Hard-Disk zu ziehen. Kurz nachdem das Kopierprogramm, das ich von einem befreundeten Hacker geschenktbekam, gestartet ist, spielenplötzlich alle Laufwerke verrückt, und gleich danach erscheinen merkwürdige Bilderauf dem Bildschirm... ?'

So oder ähnlich könnte die ersteBegegnung mit einem Computer-Virus abgelaufen sein. Nachzutragen wäre noch, daßnatürlich alle Dateien auf denDisketten und der Festplatte irreparabel zerstört sind. Nur absolute Profis sind in der Lage, mit Hilfe diverser Monitor-und Debug-Programme die Wurzeldes Übels, einen Computer-Virus, zu erkennen. Beseitigen können sie ihn nur in Einzelfällen.
Der Otto-Normal-Benutzersteht vor schier unlösbaren Problemen. Die verseuchten Disketten sind praktisch nicht mehrzu verwenden, der Inhalt derFestplatte ist verloren.

Wer jedoch beizeiten Schutzmaßnahmen trifft, der kann einigermaßen sicher sein, bei einem Befall mit Computer-Viren nicht den gesamten Programm bestand zu verlieren. Umjedoch wirksame Strategien gegen dieViren entwickeln zu können,muß zuerst die Funktion eines Virusprogramms geklärt sein.

## Historisches

Die ersten Computer-Viren entstanden im Großrechnerbereich. Dort haben einst System Programmierer Programmeent worfen, die sich in den Bereich anderer Kollegen kopierten, um dann dort, je nach Intention des Autors, Daten zumanipulieren, zu kopieren odergar zu löschen.
Später griffenHacker, meist aus der amerikanischen College-Szene stammend, diese Idee auf und schrieben Programme, die sich übersämtliche Bereiche des Großrechners verteilten und diesen108dann lahmlegten. Aus dieserZeit stammen auch genauere Untersuchungen über Viren auf Großrechnern. 

Über Computer-Viren auf PC-öder Homecomputer-Basis istbislang wenig bekannt. Andersals bei Großrechnern bestehthier nicht die Möglichkeit, denVirus auf andere Benutzer imSystem loszulassen. Wer investiert schon jede Menge Arbeitin ein Programm, das anschließend nur den Programmiererselbst nervt. Ein denkbarerWeg, auf dem sich auch PC-Viren verbreiten können, istder Programm-Tausch unter Hackern.

## Virus-Technisches

Bevor der Programmierer je doch seinen Virus 'guten Gewissens' in die weite Welt entlassenkann, muß er ihn mit Eigen schaften versehen, die ihm dasÜberleben dort erleichtern:Zuerst einmal muß das Programm sich selbst reproduzieren können. Darüber hinausmuß es klein sein und darf sichnicht durch überlange Diskettenzugriffe zu erkennen geben. Auch darf sich die Länge einesProgramms durch die 'Infizierung' mit dem Virus nicht ändern. Schließlich sollte er in der Lagesein, ein bestimmtes Kriteriumabzufragen -das Datum etwa -,um dann, wenn dieses Merkmalvorhanden ist, eine 'Killer-Routine' anzuspringen.DieseRoutine kann, je nach moralischem Befinden des Programmierers, eine einfache Meldung auf dem Bildschirm ausgeben oder aber die Disketten formatieren. Der Ausdruck 'formatieren' trifft dabei nicht ganz genauzu.Damit dem geschockten Virusopfer keine Gelegenheit gegeben wird, noch in einem Anfall letzten Aufbäumens die Diskette aus dem Laufwerk zu reißen, muß die Zerstörung innerhalb von Sekunden vonstattengehen. Formatieren wäre da vielzu langsam. Ganz abgebrühte'Computer-Gangster' werdennatürlich hierbei auch eine eventuell vorhandene Festplatte beim Löschen nicht vergessen.

Vorab sei gesagt, daß der hier vorgestellte Virus nicht alle diese Forderungen erfüllt. So ändert sich zum Beispiel die Programmlänge des 'verseuch ten' Programms. Damit soll ver mieden werden, daß skrupellose 'Zeitschriftenabprogrammierer' ein Werkzeug in die Hand bekommen, mit dem sie nur sich und anderen schaden. Wer je doch trotzdem aus rein per sönlichem Interesse natürlich - genauer wissen will, wie denn solch ein 'reiner' Virus im ein zelnen arbeitet, wird auch dazu Hinweise finden.

## Spiel mit dem Feuer

Naturgemäß erhitzt das Thema Software-Viren die Gemüter. Wer Viren pro grammieren kann, wird nur noch vom eigenen morali schen Empfinden davon abge halten, seine oft hilflosen Mit menschen zu schädigen. Des halb wird ein Artikel wie der vorliegende zwangsläufig ins Kreuzfeuer der Kritik geraten. 'Muß man diese Hacker auch noch mit der Nase darauf sto ßen ?' - Sicher nicht, aber die Redaktion ist der Meinung, daß es niemand nützt, wenn brisante Themen einfach tot geschwiegen werden. Nur wer weiß, wie die Gefahr aussieht, kann sich auch davor schüt zen. Wenn sich dagegen nur eine Handvoll Insider mit dem Thema auseinandersetzt und sonst nur Gerüchte kursieren, wird der angerichtete Schaden am Ende größer sein. Dieser Beitrag beweist, daß man die Entwicklung von Virus-Pro grammen nicht vermeiden kann. Der hier abgedruckte Virus ist sicherlich nicht der erste für den Atari, allenfalls die Vorstellung eines Antivi rus ist neu. Niemand steht den Viren hilflos gegenüber. Wer die Software auf 'offiziellen' Wegen bezieht und seine Dis ketten mit Schreibschutz ver sieht, braucht sich vor dem Virus-Fiasko nicht zu fürchten. 

## Mit Köpfchen

Um einen Virus auf Programme loslassen zu können, muß man wissen, wie diese aufgebaut sind. Die ersten 28 Bytes eines Programms auf Diskette wer den vom sogenannten Header beansprucht. Im Header stehen Zeiger auf die verschiedenen Programmsegmente. Jeder die ser Pointer ist vier Bytes lang. So steht ab dem dritten Byte der Pointer 'Textlen'. 'Textlen' be inhaltet die Länge des ausführ baren Programmcodes. Nach dem Zeiger Textlen' steht ab siebter Stelle die Länge des vor defmierten Data-Bereichs in 'Datalen'. Danach folgt die Länge des Bss-Segments, reprä sentiert durch 'Bsslen'. Hinter diesem Zeiger findet man 'Commentlen'. 

An den Header schließt sich das Text-Segment an. Hier steht der Maschinencode des eigentlichen Programms. Dem Textbereich folgt das Data-Segment mit den initialisierten Variablen (oder Konstanten), die beim Pro grammstart einen bestimmten Anfangswert aufweisen müssen. 

Das Bss-Segment, der Speicher bereich für alle nicht initialisier ten Variablen, steht nicht expli zit auf Diskette. Dies wäre ja auch reine Speicherplatzver schwendung, da die Anfangs werte dieses Speicherbereichs ohnehin unbedeutend sind. Es wird lediglich durch den Bss-Pointer im Header vertreten und dann bei der Speicherplatz reservierung des Programms be rücksichtigt.

An den Data-Sektor schließt sich daher gleich die Kommen tartabelle an. Hier werden für Debugger (das sind Hilfsprogramme, die die Fehlersuche er leichtern) Informationen abge legt, die die Erstellung eines ei nigermaßen dokumentierten (sprich kommentierten) Disas sembler-Listings ermöglichen. 

An sich müßte, wenn man die drei Pointer (Textlen, Datalen, Commentlen) mit der HeaderLänge (28 Bytes) addiert, genau die Programmlänge heraus kommen. Daß dies nicht der Fall ist, liegt am TOS. Dieses moderne Betriebssystem muß die Programme an jeder Stelle des Speichers ausführen kön nen. Also müssen die Pro gramme relokatibel abgespei chert werden. Das wird gelöst, indem alle absoluten Adressen relativ zum Programmstart an gegeben werden. Nach dem La den wird dann zu jeder dieser Offsetadressen die aktuelle Startadresse hinzuaddiert. So ist das Programm an jeder Stelle im Speicher lauffähig. Damit nun das Betriebssystem weiß, wo Offsetadressen stehen, werden die Positionen dieser Offsets in der Loader-Tabelle vermerkt. Diese Tabelle steht ganz am Ende eines jeden Programms, wo sie nach dem Laden und der Anpassung der absoluten Adressen gelöscht wird. 

## Milzbrand 

Den hier vorgestellten Virus für den Atari ST habe ich Milz brand genannt. Einmal gestar tet, prüft er zuerst das aktuelle Datum. Falls schon das Jahr 1987 angebrochen ist, wird in ein Unterprogramm verzweigt, welches die Dateien auf den Disketten in beiden Laufwerken irreparabel zerstört. Jedenfalls war es mir nicht möglich, zwei in der Entwicklungsphase zer störte Disketten wieder zu re staurieren. 

<center><img src="{attach}../images/ct_virus2.png" width="40%"/></center>
<center><b>Milzbrand has struck.</b></center>

Das Unterprogramm benutzt dabei die Eigenschaft des TOS, die Directory und FAT (File Allocation Table) in den ersten Sektoren auf der Diskette zu speichern. Diese werden einfach überschrieben. Das sollte genü gen. Denn die Arbeit, eine Dis kette ohne FAT und Directory korrekt wiederherzustellen, ent spricht in etwa dem Aufwand, ein 1 5000 Teile großes, den Wohnzimmerboden bedecken des Gras-und-Wiesen-Puzzle zusammenzusetzen. 

Ist das Jahreskriterium nicht er füllt, so sucht Milzbrand in dem aktuellen Disketteninhaltsver zeichnis nach Dateien, die die Extension '.PRG' haben. Findet er dergleichen, so wird die Datei auf ihre Länge hin überprüft. Denn bei kleinen Programmda teien entdeckt man einen Virus wesentlich eher anhand der Pro grammlänge als bei großen Milzbrand hat zugeschlagen. Files. Ist die Länge des gefun denen Programms kleiner als 10000 Bytes, so wird es einfach ignoriert und die nächste Datei gesucht. 

Falls das Programm lang genug ist, wird anhand einiger Prüf bytes untersucht, ob das File schon 'infiziert' ist. Denn es ist sinnlos, ein Programm mehr fach zu 'behandeln', auch wenn es theoretisch möglich ist. In Versuchen habe ich eine Datei 16mal verseucht. Die Infek tionsquote steigt dann exponen-tiell. Die gefundene Programm datei wird jetzt geöffnet, und der Virus ersetzt die ersten Pro grammbytes durch einen Sprungbefehl in seine späterere Kopie, die er dann an das Pro gramm anhängt. 

Damit der Virus auch funktio niert und unbemerkt bleibt, wenn er aus einem beliebigen, verseuchten Programm heraus aufgerufen wird, muß man das alte Programm wieder 'restau rieren', nachdem der Virus sein schändliches Handwerk ver richtet hat. Deshalb werden die durch den Sprungbefehl ersetz ten Startbytes im Virus zwi schengespeichert. 

## Ran an die Loader-Tabelle

Ein so infiziertes Programm würde jedoch nur unter be stimmten Umständen funktio nieren. Für den Virus wird es problematisch, sobald in den er sten Programmbytes des zu ver seuchenden Programms eine ab solute Adresse auftaucht. Dann wird der Sprungbefehl in den Virus nach dem Laden durch die Addition der Startadresse zer stört. Spätestens nach einer Re staurierung des ursprünglichen Programmkopfes unterscheidet sich dann die absolute Adresse durch die fehlende Addition der Startadresse. In beiden Fällen stürzt das Programm ab. Die Loader-Tabelle muß also auch manipuliert werden. Sie befin det sich am Ende des Pro gramms nach dem BSS-Segment. 

<center>
<img src="{attach}../images/ct_virus3.png" width="60%"/><br/>
<img src="{attach}../images/ct_virus4.png" width="60%"/>
</center>
<center><b>The length of a program affected by Milzbrand changes</b></center>

Die Loader-Tabelle beginnt mit der Distanz der ersten absoluten Adresse zum Programmstart. Für die folgenden absoluten Adressen ist jeweils der Abstand zur vorhergehenden angegeben. Angenommen, im Maschinen programm stehen an den Stellen 2, 10 und 18 absolute Adressen. Dann sieht die entsprechende Loader-Tabelle folgenderma ßen aus: 2, 8, 8. Man muß also höchstens den ersten Wert der Tabelle ändern. Dabei wird nur die Länge des 'angebauten' Sprungbefehls aufaddiert. 

Jetzt addiert man zum 'Data-len'-Pointer im Header die Länge des Virusprogramms, das hinter das Data-Segment und vor die Kommentar- und Loader-Tabelle geschrieben wird. Dabei werden beide Ta bellen in ihrer Position um die Viruslänge nach hinten verscho ben. Dehalb muß auch noch der Commentlen-Pointer korrigiert werden. Die Commentlen-Ta-belle selbst bleibt 'unberührt'. Mit dem Schließen der Datei ist das üble Werk beendet. 

Die Arbeit von Milzbrand wird durch das Restaurieren der ihn aufrufenden Programmdatei beendet. Dazu werden die ent sprechenden Startbytes zurück kopiert und eventuelle absolute Adressen wieder korrigiert. Zum Schluß erfolgt der Sprung an den Programmanfang - und niemand hat's gemerkt.

Aber echte Computer-Viren verraten sich im Gegensatz zu Milzbrand nicht durch die Än derung der Programmlänge. Die Arbeitsweise eines solchen Virus ist in der Abbildung sche matisch dargestellt. 

<center><img src="{attach}../images/ct_virus5.png" width="60%"/></center>
<center><b>This virus does not change the program length, but copies the data section to another location</b></center>

Das Betriebssystem liest nur die Bytes eines Files von Diskette ein, die sich innerhalb der im Verzeichnis angegebenen Datei länge befinden. Am Ende dieses Bereichs muß die Loader-Ta belle stehen, damit der Lade vorgang ordnungsgemäß abge schlossen werden kann. Ein Vi rus, der den Eintrag der Pro grammlänge nicht ändern soll, muß also solche Programmteile an einer beliebigen Stelle auf der Diskette verstecken, die für die Relokation keine Bedeutung haben. Dafür kommt eigentlich nur das Data-Segment in Frage. In dem freigewordenen Bereich setzt sich dann der Virus fest. Nach dem Laden des Pro gramms arbeitet er dann genau wie Milzbrand, nur daß er na türlich beim Restaurieren das Data-Segment nachlädt.  

Die nächste Steigerung sind RAM-residente Viren. Diese Virus-Spezies ist im 'Auto Ordner' oder als 'ACC'-File auf Diskette verborgen und kopiert sich selbst ins RAM. Dort klinkt sich der Virus über ver bogene Exception-Zeiger in die zyklischen Abläufe des Be triebssystems ein (siehe c't ll/ 86, Seite 144 und c't 1/87, Seite 136 - 'Das Betriebssystem des Atari ST'). Jedesmal wenn dann eine Diskette gewechselt wird oder irgendein Diskettenzugriff erfolgt, breitet sich Milzbrand II weiter aus. In Anbetracht dieser Möglichkeiten muß der Com puter also unbedingt nach Ent decken eines Virus ausgeschal tet werden. Ein normaler Reset reicht nicht aus. 

## Gegenmaßnahmen

Wie aber kann man sich vor Computer-Viren, über deren ge naue Struktur man nichts weiß, schützen? Meistens wird der Virus ja erst entdeckt, wenn er sein zerstörerisches Werk voll bracht hat. Dann ist es jedoch zu spät. 

Als elementare Schutzmaß nahme sollte man unnützes Um herkopieren von Programmen auf den eigenen Disketten ver meiden. Dies hilft jedoch herz lich wenig gegen RAM-residente Viren. Auch das Auslagern neuer Programme auf eine 'Quarantäne-Diskette' ist bei dieser Virenart wirkungslos. Bei 'normalen' Computer-Viren hilft das zumindest, die Ausbrei tungsgeschwindigkeit zu redu zieren. 

Verläßliche Informationen über den 'Gesundheitszustand' eines Programms gibt eine Prüf summe, die zu einer Zeit berech net werden muß, zu der mit Si cherheit noch kein Virus zuge schlagen hat. Diese Summe wird dann bei jedem Programmauf ruf verglichen. Sollte das Pro gramm zwischenzeitlich durch einen Virus verseucht worden sein, so kommt es zu einer Prüf summendifferenz, die den Virus verrät. Ein entsprechendes Pro gramm für den Atari ST wird später noch näher erklärt.

Eine andere Prüfsummen-Schutzmethode ist ein Pro gramm, das die gesamten Prüf summen aller Files auf der Dis kette in eine Datei schreibt. Die ses Programm wird dann von Zeit zu Zeit aufgerufen (späte stens aber nach Befall durch ei nen Virus) und gibt alle inzwi schen verseuchten Programme aus. So können von Disketten, auf denen einzelne Programme schon verseucht sind, wenig stens noch die unverseuchten Programme gerettet werden. Dabei muß jedoch darauf geachtet werden, daß der Name der Prüfsummendatei immer anders gewählt wird. So können sich die Computer-Viren nicht auf einen Dateinamen einstel len, um dann dieses File in ihrem Sinne - sprich Prüfsummenkor rektur zu manipulieren  

## Penicillin contra Milzbrand

Der Antivirus, sinnigerweise Penicillin genannt, arbeitet zum Teil nach einem ähnlichen Schema wie Milzbrand. Penicil lin ist als TTP'-Anwendung (TOS Takes Parameter) konzi piert. Wenn der Antivirus auf gerufen wird, muß der Datei name des zu schützenden Pro gramms angegeben werden. Grundsätzlich sollte Penicillin nur auf Sicherungskopien ange setzt werden, da es sich nach Murphy gerade mit dem wich tigsten Programm nicht ver trägt. 

Nach dem obligatorischen Test, ob dieses File überhaupt exi stiert, wird anhand von Prüf bytes untersucht, ob diese Datei schon geschützt ist. Nach dem Motto 'Viele Antiviren verder ben das Programm' erhält der Anwender in diesem Falle nur eine lapidare Fehlermeldung auf dem Bildschirm. Dagegen wird nicht überprüft, ob es sich bei der genannten Datei um ein Programm handelt. Es steht also jedem frei, auch seine GEM-Draw-Grafiken zu schüt zen, wodurch die Bilder jedoch zerstört werden. 

Bei noch ungeschützten Files geht der Antivirus ähnlich vor wie sein Antagonist. Die ersten Programmbytes werden durch einen Sprungbefehl in die spä tere Kopie des Antivirus ausge tauscht. Die Behandlung des Header und der Loader-Tabelle erfolgt nach dem gleichen Prin zip wie bei Milzbrand. Auch die Routinen zum Restaurieren des aufrufenden Programms sind im wesentlichen mit denen des Virus identisch. Sie sollen des halb hier nicht weiter bespro chen werden. 

Im Antivirus wird ein Unterpro gramm aufgerufen, das von der ausgewählten Programmdatei eine Prüfsumme bildet. Der Ab stand zwischen den Bytes, wel che in die Prüfsumme eingehen, liegt bei 512 Bytes. Es wird also jedes 512. Byte des zu schützen den Programms addiert, zusam men ergibt das die Prüfsumme. 

## Abstand halten

Der Abstand von 512 Bytes ist frei gewählt, muß allerdings eingehend überdacht werden. Die meisten Viren dürften zwar bei allem, was sie leisten müssen, länger als 512 Bytes sein, jedoch bleibt die Möglichkeit, daß das Programm nur mit einer kurzen Laderoutine verseucht wird, die den eigentlichen Virus erst spä ter nachlädt. So würde eine Prüfsumme, die mit der Schritt weite von 512 Bytes ermittelt wurde, den Virus nicht mit Si cherheit verraten. Jeder sollte bei der Programmierung eines Antivirus eine individuelle Schrittweite eintragen. Dies hat auch den Vorteil, daß sich Com puter-Viren nicht auf eine Schrittweite 'einschießen' kön nen, um dann die Prüfsumme selbst zu manipulieren. 

Bei der Auswahl des Abstands hat man jedoch nicht vollkommen freie Hand. Die Prüf summe muß vom schon ge schützten Programm erstellt werden, da sich der Antivirus sonst später selbst als Virus er kennen würde. Danach muß die Prüfsumme im Programm ver merkt werden. Dazu wird sie im zehnten und elften Byte des Pro grammkopfes abgelegt. Zusam men mit dem Header ergibt das die Positionen 38 und 39 in der Programmdatei. Diese Bytes dürfen zur Prüfsummenbildung nicht herangezogen werden, da sie ja nachträglich geändert wer den. 

Eine weitere Erhöhung der Si cherheit gegen solche Viren, die sich aufhäufig benützte Schritt weiten einstellen, könnte da durch erzielt werden, daß man der Prüfsumme einen Anfangs wert gibt. Beim hier vorgestell ten Antivirus ist der Startwert gleich Null. Es müßte also eine Initialisierung der Prüfsumme ungleich Null vorgenommen werden. Dadurch erreicht man mehr Sicherheit vor 'intelligen ten' Viren

Die hier vorgestellten Maßnah-mem sind nicht nur ein guter Schutz gegen zerstörende Viren, sondern sie helfen auch gegen alle kleinen Programme, die ähnlich arbeiten wie Viren, je doch andere Ziele verfolgen. 

## Zeitnahme

Die erste Tabelle zeigt die La dezeiten verseuchter Pro gramme. Auf der linken Seite stehen die Programme, die auf gerufen wurden. Diese haben eine bestimmte Dateilänge vor und nach der 'Infizierung' mit Milzbrand. In den nächsten Spalten sind die Ladezeiten der Programme angegeben. Die er ste Zeit gibt die Einladedauer des unverseuchten Programms an. Daneben steht die Zeit, die das Betriebssystem braucht, um ein verseuchtes Programm ein zuladen, welches aber seiner- seits kein weiteres Programm zur Infizierung findet.

Runtime if the following program is infected after startup:

| Program | AS68 | LINK68 | RELMOD |  SID |
|---------|:----:|:------:|:------:|:----:|
| AS68    |   -  |  14.5  |  15.0  | 15.5 |
| LINK68  | 13.5 |    -   |  14.0  | 14,5 |
| RELMOD  | 11.0 |  11.0  |    -   | 11.5 |
| SID     | 12.5 |  12.5  |  13.0  |   -  |

<center><b>If the virus starts working after loading, the time between the start of the loading process and the start of the actual program can almost double.</b></center>

Die zweite Tabelle bezieht sich auf das Laden und Starten eines verseuchten Programms, das dabei die angegebene Datei mit Milzbrand infiziert. Diese Zei ten sind jedoch mit Vorsicht zu betrachten, denn einerseits sind sie 'handgestoppt', andererseits kommt es immer darauf an, wie viel Programme sich auf der Diskette befinden und an wel cher Stelle sie im Directory ste hen. Die Ladezeiten können sich so um bis zu hundert Pro zent erhöhen. Daran kann ein geübter Computerbenutzer durchaus festellen, welche Pro gramme mit einem Virus 'kon taminiert' wurden. 


| Program | Size without MB in KB | Size with MB in KB | Loading time<br>without MB in seconds | Loading time<br>with MB in seconds |
|---------|:---------------------:|:------------------:|:-------------------------------------:|:----------------------------------:|
| AS68    |         52 864        |        54 126      |                  8,5                  |                10,5                |
| LINK68  |         35 072        |        36 334      |                  7,0                  |                 9,0                |
| RELMOD  |         12 928        |        14 190      |                  5,0                  |                 6,5                |
| SID     |          2 880        |        30 062      |                  6,5                  |                 8,                 |

<center><b>Although the program length changes only minimally, there is a significant increase in loading time. (MB: Milzbrand)</b></center>


## Fazit

Gute Programmierer können sicher weit leistungsfähigere Vi ren schreiben als die hier abge druckten. Solche Viren erfüllen dann alle Forderungen an Kom paktheit und Schnelligkeit. An dieser Stelle möchte ich alle Hacker eindringlich warnen, die die Fähigkeit und Ausdauer ha ben, solche Programme zu ent wickeln. Viren würden, falls ab sichtlich oder unabsichtlich au ßer Kontrolle geraten, einen großen Schaden anrichten. Für den Programmierer ist es dabei wichtig zu wissen, daß die ak tuelle Gesetzgebung die mutwil lige Beschädigung fremder Soft ware unter Strafe stellt. 

Ein altes, aktualisiertes Sprich wort sagt: 'Vorsicht ist besser, als neue Software zu kaufen'. Darum ist es angeraten, den hier vorgestellten Antivirus bei allen wichtigen Programmen anzu wenden. So ist man wenigstens frühzeitig gewarnt. 

Zum Schluß noch eine Warnung an alle, die den Virus ausprobie ren wollen: Seien Sie vorsichtig und packen Sie alle wichtigen Programmdisketten vorher weg. Ich habe während der Ent wicklung mehrfach wichtige Programmme verloren.   

