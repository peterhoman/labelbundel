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
