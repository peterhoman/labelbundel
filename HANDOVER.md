# Overdracht — Labelbundel

Bijgewerkt: 29 augustus 2026

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

Vanaf nu loopt alle communicatie over Labelbundel via deze Claude Code-chat.
De oude chat in de gewone Claude mag weg zodra het vanaf GitHub goed werkt.

## Nieuwe PC — zo haal je het terug

```bash
git clone https://github.com/peterhoman/labelbundel.git
```

Of gewoon de tool openen op https://peterhoman.github.io/labelbundel/ —
daar is helemaal niets voor nodig.

Let op: `Verzendlabels opruimen.bat` verwijst naar
`%USERPROFILE%\Dropbox\#####verzendlabels`. Op een nieuwe PC moet Dropbox er
dus staan, of dat pad bovenin het bat-bestand aangepast worden.

## Openstaand

- Niets.
