@echo off
setlocal enabledelayedexpansion
title Verzendlabels opruimen

REM ============================================================
REM  Haalt alle verzendlabels uit Downloads en zet ze in de map
REM  hieronder. Al je andere downloads blijven gewoon staan.
REM
REM  Verhuist de map ooit? Pas dan ALLEEN de regel
REM  "set DOEL=..." hieronder aan, bijvoorbeeld:
REM     set "DOEL=D:\ergens anders\verzendlabels"
REM ============================================================

set "BRON=%USERPROFILE%\Downloads"
set "DOEL=%USERPROFILE%\Dropbox\#####verzendlabels"

REM ------------------------------------------------------------
REM  Dropbox blijft op deze PC niet uit zichzelf draaien: hij
REM  start wel mee met Windows, maar valt daarna weer stil. Dan
REM  komen de labels van een ander niet binnen. Daarom kijken we
REM  eerst of hij draait en starten we hem anders alsnog.
REM  Vastgesteld op 22 september 2026, zie HANDOVER.md.
REM ------------------------------------------------------------
set "DBX=%ProgramFiles(x86)%\Dropbox\Client\Dropbox.exe"
if not exist "%DBX%" set "DBX=%ProgramFiles%\Dropbox\Client\Dropbox.exe"

if not exist "%DBX%" goto dropboxklaar

REM  Een net afgesloten Dropbox hangt nog een paar seconden in de
REM  processenlijst. Zonder deze pauze denkt het script dat hij draait
REM  en slaat het starten ten onrechte over.
timeout /t 4 >nul

call :draaitdropbox
if not errorlevel 1 goto dropboxklaar

echo.
echo   Dropbox stond uit. Hij wordt gestart - even geduld...
REM  Dropbox blijft in dit venster schrijven zolang hij eraan vastzit,
REM  ook nadat dit script klaar is. Daarom starten we hem los van dit
REM  venster, met zijn eigen werkmap - anders laat hij ook nog een
REM  debug.log achter in de labelmap.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%DBX%' -WorkingDirectory (Split-Path '%DBX%')" >nul 2>&1
timeout /t 25 >nul
cls

REM  Niet zomaar melden dat het gelukt is - eerst kijken of hij er ook
REM  echt staat.
call :draaitdropbox
echo.
if errorlevel 1 (
  echo   LET OP: Dropbox kon niet worden gestart. Start hem zelf,
  echo   anders komen labels van een ander niet binnen.
) else (
  echo   Dropbox is gestart.
)
:dropboxklaar

if not exist "%DOEL%" mkdir "%DOEL%"
if not exist "%BRON%" goto geenmap

set /a AANTAL=0
pushd "%BRON%"
for /f "delims=" %%F in ('dir /b /a-d "verzendzegel-*.pdf" "Shipment _*.pdf" "Shipping_Label-*.pdf" 2^>nul') do call :verplaats "%%F"
popd

REM Windows markeert gedownloade bestanden als "afkomstig van internet",
REM waardoor Verkenner geen voorbeeld toont. Dat vlaggetje halen we weg.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -LiteralPath '%DOEL%' -Filter *.pdf | Unblock-File" >nul 2>&1

echo.
if !AANTAL!==0 (
  echo   Geen nieuwe verzendlabels gevonden in Downloads.
) else (
  echo   !AANTAL! verzendlabel^(s^) verplaatst naar:
  echo   %DOEL%
)
echo.

start "" "%DOEL%"
timeout /t 5 >nul
exit /b

REM  Draait Dropbox? Volledige paden gebruiken, anders pakt Windows soms
REM  een gelijknamig hulpprogramma dat via het PATH voorrang krijgt.
:draaitdropbox
"%SystemRoot%\System32\tasklist.exe" /fi "imagename eq Dropbox.exe" /nh 2>nul | "%SystemRoot%\System32\find.exe" /i "Dropbox.exe" >nul
if errorlevel 1 exit /b 1
exit /b 0

:verplaats
set "BESTAND=%BRON%\%~1"
if not exist "%BESTAND%" goto :eof
set "DOELPAD=%DOEL%\%~nx1"
set /a T=1
:zoekvrij
if exist "!DOELPAD!" (
  set "DOELPAD=%DOEL%\%~n1 (!T!)%~x1"
  set /a T+=1
  goto zoekvrij
)
move "!BESTAND!" "!DOELPAD!" >nul 2>&1
if not errorlevel 1 set /a AANTAL+=1
goto :eof

:geenmap
echo.
echo   De map Downloads is niet gevonden.
echo.
timeout /t 8 >nul
