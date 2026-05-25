@echo off
title Installation de REmapperEXE (avec OTVDM)
chcp 65001 >nul
setlocal enabledelayedexpansion

:: --- 1. DÉFINITION DES CHEMINS ---
:: Le script récupère le dossier où il se trouve pour y créer le dossier AppsDec
set "SCRIPT_DIR=%~dp0"
set "APP_DIR=%SCRIPT_DIR%AppsDec"
set "EXE_PATH=%APP_DIR%\REmapperEXE.exe"
set "OTVDM_DIR=%APP_DIR%\otvdm"
set "OTVDM_EXE=%OTVDM_DIR%\otvdm.exe"

:: URLs de téléchargement (versions RAW)
set "EXE_URL=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/REmapperEXE.exe"
set "OTVDM_URL=https://github.com/otya128/winevdm/releases/latest/download/otvdm-w64.zip"

:: URLs des DLLs
set "DLL_URLS[0]=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Runtime.CompilerServices.Unsafe.dll"
set "DLL_URLS[1]=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Numerics.Vectors.dll"
set "DLL_URLS[2]=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Memory.dll"
set "DLL_URLS[3]=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Buffers.dll"
set "DLL_URLS[4]=https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/Iced.dll"

:: --- 2. NETTOYAGE DE L'ANCIENNE INSTALLATION ---
echo ============================================================
echo   Installation de REmapperEXE
echo ============================================================
echo.
echo Suppression de l'ancienne installation dans :
echo %APP_DIR%
echo.
if exist "%APP_DIR%" (
    echo Suppression des anciens fichiers...
    rmdir /s /q "%APP_DIR%" 2>nul
    if !errorlevel! neq 0 (
        echo ATTENTION : impossible de supprimer certains fichiers.
        echo Veuillez fermer REmapper s'il est en cours d'execution.
        timeout /t 3 >nul
    )
)
echo.

:: Création des dossiers propres
mkdir "%APP_DIR%" 2>nul
mkdir "%OTVDM_DIR%" 2>nul

:: --- 3. FONCTION DE TÉLÉCHARGEMENT ROBUSTE ---
set "DOWNLOAD_OK=0"
call :TelechargerFichier "%EXE_URL%" "%EXE_PATH%"
if "!DOWNLOAD_OK!"=="0" goto :echec_telechargement

echo.
echo ============================================================
echo   Telechargement des DLLs...
echo ============================================================
for /l %%i in (0,1,4) do (
    set "current_url=!DLL_URLS[%%i]!"
    set "current_file=%APP_DIR%\%%~nxi"
    if not "!current_url!"=="" (
        call :TelechargerFichier "!current_url!" "!current_file!"
        if "!DOWNLOAD_OK!"=="0" goto :echec_telechargement
    )
)

:: --- 4. INSTALLATION D'OTVDM (émulateur) ---
echo.
echo ============================================================
echo   Installation de l'emulateur OTVDM...
echo ============================================================
set "OTVDM_ZIP=%APP_DIR%\otvdm.zip"
call :TelechargerFichier "%OTVDM_URL%" "%OTVDM_ZIP%"
if "!DOWNLOAD_OK!"=="0" goto :echec_telechargement

:: Décompression d'OTVDM
echo Decompression d'OTVDM...
powershell -NoProfile -Command "Expand-Archive -Path '%OTVDM_ZIP%' -DestinationPath '%OTVDM_DIR%' -Force" >nul 2>&1
if !errorlevel! neq 0 (
    echo ERREUR : Impossible de decompresser OTVDM
    pause
    exit /b 1
)
del "%OTVDM_ZIP%" 2>nul

:: --- 5. LANCEMENT AVEC OTVDM ---
echo.
echo ============================================================
echo   Lancement de REmapperEXE (via OTVDM)
echo ============================================================
echo.
echo Le programme va demarrer via l'emulateur 16/32 bits...
"%OTVDM_EXE%" "%EXE_PATH%"
if !errorlevel! neq 0 (
    echo.
    echo ============================================================
    echo   ERREUR : Impossible de lancer REmapperEXE
    echo ============================================================
    echo.
    echo Solutions :
    echo - Verifiez que vous avez bien execute ce script en tant qu'Administrateur.
    echo - Verifiez que votre antivirus n'a pas bloque OTVDM ou REmapperEXE.
    echo - Consultez : https://github.com/otya128/winevdm
    echo.
) else (
    echo L'application est en cours d'execution...
)
pause
exit /b 0

:echec_telechargement
echo.
echo ============================================================
echo   ERREUR : Telechargement impossible
echo ============================================================
echo.
echo Votre connexion internet ou le serveur distant a bloque la requete.
echo.
echo Solution manuelle :
echo 1. Telechargez les fichiers depuis cette page :
echo    https://github.com/teamcoolkiddreborn-afk/REmapperEXE/tree/main/REmapper.exe
echo 2. Placez tous les fichiers dans le dossier :
echo    %APP_DIR%
echo 3. Telechargez OTVDM depuis :
echo    https://github.com/otya128/winevdm/releases/latest
echo 4. Extrayez l'archive otvdm-w64.zip dans %OTVDM_DIR%
echo 5. Lancez ce script a nouveau.
echo.
pause
exit /b 1

:: ------------------------------------------------------------
:: Sous-fonction : Telecharger un fichier avec plusieurs methodes
:: ------------------------------------------------------------
:TelechargerFichier
set "URL=%~1"
set "DEST=%~2"
echo Telechargement de %~nx2...
if exist "%DEST%" del "%DEST%" 2>nul

:: Méthode 1 : PowerShell (TLS 1.2)
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '%URL%' -OutFile '%DEST%' -UseBasicParsing -TimeoutSec 30 } catch { exit 1 }" >nul 2>&1
if exist "%DEST%" if %~z2 neq 0 (
    set "DOWNLOAD_OK=1"
    exit /b
)

:: Méthode 2 : curl
curl -L -o "%DEST%" "%URL%" --silent --connect-timeout 30 >nul 2>&1
if exist "%DEST%" if %~z2 neq 0 (
    set "DOWNLOAD_OK=1"
    exit /b
)

:: Méthode 3 : bitsadmin
bitsadmin /transfer "Telechargement_%~nx2" /download /priority normal "%URL%" "%DEST%" >nul 2>&1
if exist "%DEST%" if %~z2 neq 0 (
    set "DOWNLOAD_OK=1"
    exit /b
)

set "DOWNLOAD_OK=0"
exit /b
