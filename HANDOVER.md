# Overdracht — Labelbundel

Bijgewerkt: 30 augustus 2026

## Waar staat wat

- **Werkmap (deze chat):** `OneDrive\OneDriveClaude-Code-Projecten\labelbundel`
- **GitHub:** https://github.com/peterhoman/labelbundel (openbaar)
- **Webadres van de tool:** https://peterhoman.github.io/labelbundel/

De map op OneDrive en de GitHub-repo zijn hetzelfde project. Wat hier wordt
aangepast, wordt met een commit + push naar GitHub gestuurd, en staat een paar
minuten later op het webadres.

## Wat is het

Zie [README.md](README.md). Kort: één HTML-bestand dat losse verzendlabel-PDF's
tot één PDF bundelt. Draait volledig in de browser, geen server, geen upload.

## Achtergrond

Het programma is gemaakt in de gewone Claude-chat en op 29 augustus 2026 naar
Claude Code verhuisd. Reden: het stond alleen op deze PC. Nu staat het op
GitHub, dus bij een kapotte of nieuwe PC is het er gewoon weer.

Op 29 augustus 2026 getest vanaf het webadres: werkt goed. De oude chat in de
gewone Claude is daarna verwijderd. Alle communicatie over Labelbundel loopt
vanaf nu via deze Claude Code-chat.

## Nieuwe PC — zo haal je het terug

```bash
git clone https://github.com/peterhoman/labelbundel.git
```

Of gewoon de tool openen op https://peterhoman.github.io/labelbundel/ —
daar is helemaal niets voor nodig.

Let op: `Verzendlabels opruimen.bat` verwijst naar
`%USERPROFILE%\Dropbox\#####verzendlabels`. Op een nieuwe PC moet Dropbox er
dus staan, of dat pad bovenin het bat-bestand aangepast worden.

## Labels uit DeliveryMatch (eigen website)

De grote groene **Print label**-knop print direct; daar komt geen bestand van.
Gebruik in plaats daarvan het kleine **Label**-knopje onderaan bij de barcode
(onder *Packages*). Dat levert `Shipping_Label-<barcode>.pdf`.

Voorwaarde: Chrome moet PDF's downloaden in plaats van openen. Ingesteld op
30 augustus 2026 via `chrome://settings/content/pdfDocuments`. Op een nieuwe PC
moet dat opnieuw.

Het opruimknopje herkent `Shipping_Label-` sinds 30 augustus 2026.

Omdat Chrome nu downloadt in plaats van opent, is **Edge** ingesteld als vaste
PDF-opener in Windows. Dubbelklikken op een PDF opent Edge, printen met Ctrl+P.
Op een nieuwe PC moet dat opnieuw ingesteld worden.

**De naam van de ontvanger is bij deze labels niet te lezen.** DeliveryMatch
maakt ze met Labelary: één afbeelding, geen tekst, ook niet in de
PDF-eigenschappen. Nagelopen op 30 augustus 2026 — Printer Settings biedt alleen
PDF of PrintNode, More options heeft geen download, en Export gaat over
vervoerder-instellingen. De tool toont daarom het trackingnummer met een
kopieerknop. Dat nummer plak je in DeliveryMatch bij *Search shipment*.

## Let op bij Select & print

De knop **Print Selected** op de pagina *Select & print* **boekt de zendingen
direct**. Daar betaal je voor, ook als je ze niet verstuurt. Niet gebruiken om
even iets uit te proberen.

Op 30 augustus 2026 zijn er zo twee per ongeluk geboekt. Welke dat waren staat
in DeliveryMatch zelf — niet hier, want deze repo is openbaar en er horen geen
klantgegevens in.

## Openstaand

- Niets.
