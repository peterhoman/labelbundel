# Labelbundel

Bundelt losse verzendlabel-PDF's tot één PDF, klaar om te mailen of te appen.
Alles wordt rechtop gedraaid en er passen meerdere labels op een pagina, zodat
degene die ze scant niet ieder label apart hoeft te openen.

Alles gebeurt in de browser van de gebruiker. Er wordt geen enkel bestand
geüpload — er is dan ook geen server nodig.

## De bestanden

| Bestand | Waarvoor |
|---|---|
| `index.html` | De tool zelf. Alles zit in dit ene bestand. |
| `Verzendlabels opruimen.bat` | Verplaatst verzendlabels uit Downloads naar de gedeelde map. |

## Gebruiken

Open `index.html` (dubbelklikken werkt, of via een webadres — zie hieronder),
sleep de labels of de hele map erin en klik op **Bundel tot één PDF**.

Instellingen: 1, 2 of 4 labels per pagina. Twee per A4 is de standaard —
de barcodes blijven dan vrijwel op ware grootte en scannen het betrouwbaarst.

## Wat de tool zelf al regelt

- **Draaien.** Labels die staand in de PDF zitten worden een kwartslag gedraaid,
  zodat alles dezelfde kant op staat.
- **Dubbele labels.** Wordt hetzelfde label twee keer gedownload (bijvoorbeeld
  door twee mensen), dan is het bestand identiek. Dat wordt herkend en telt
  maar één keer mee.
- **Ampère Same-day.** Die labels horen niet in de bundel. Ze zijn te herkennen
  aan `Order ID` en een `AMPVBSD`-code in de PDF en blijven er automatisch buiten.
- **Pakbonnen.** Herkend aan het woord *Pakbon* en aan een A4 vol tekst.

Alles is per label met een vinkje om te zetten, mocht het een keer misgaan.

De naam en plaats van de ontvanger worden uit het label gelezen, zodat je in de
lijst ziet naar wie elk pakket gaat. Bij labels uit DeliveryMatch lukt dat niet:
die zijn met Labelary gemaakt en bestaan uit één afbeelding zonder tekst. Daar
valt niets uit te lezen — ook niet uit de PDF-eigenschappen. Voor die labels
toont hij wat wél in de bestandsnaam staat:

- `Shipment _ 26-47509` → **Bestelling 26-47509**
- `Shipping_Label-3SCSXY...` → **Track 3SCSXY...**, met één klik te kopiëren.
  Dat nummer plak je in DeliveryMatch bij *Search shipment* om te zien wie het is.

## Het opruimknopje

`Verzendlabels opruimen.bat` verplaatst alle bestanden uit Downloads die
beginnen met `verzendzegel-`, `Shipment _ ` of `Shipping_Label-` naar de
gedeelde map. Andere downloads blijven staan — ook pakbonnen, want die heten
`shipment_ship...` zonder spatie.

`Shipping_Label-` is het label dat je krijgt via het kleine **Label**-knopje in
DeliveryMatch, bij de barcode onder *Packages*. Chrome moet dan wel op
*PDF's downloaden* staan (`chrome://settings/content/pdfDocuments`), anders
opent hij het label in een tabblad in plaats van het te downloaden.

De doelmap staat bovenin het bestand:

```bat
set "DOEL=%USERPROFILE%\Dropbox\#####verzendlabels"
```

Het script haalt ook het "afkomstig van internet"-vlaggetje weg, zodat Verkenner
een voorbeeld van de labels laat zien.

## Op een webadres zetten

Met GitHub Pages krijgt `index.html` een eigen adres, zodat iedereen de tool kan
openen zonder iets te installeren:

1. Zet deze map in een GitHub-repository.
2. Ga in de repository naar **Settings → Pages**.
3. Kies bij *Source* de branch `main` en map `/ (root)`, en sla op.
4. Na een paar minuten staat de tool op `https://<gebruikersnaam>.github.io/<repo>/`.

## Onder de motorkap

Eén HTML-bestand, geen build-stap. De enige externe afhankelijkheid is
[pdf-lib](https://pdf-lib.js.org/) (1.17.1), dat via een CDN wordt geladen en
het samenvoegen en draaien van de PDF's doet. Tekst uit de labels wordt
uitgelezen door de PDF-streams uit te pakken met `DecompressionStream` en de
lettertabellen (`ToUnicode`) uit de PDF zelf te gebruiken.
