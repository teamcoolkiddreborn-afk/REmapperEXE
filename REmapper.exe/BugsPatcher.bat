@echo off
if not exist "%~dp0AppsDec" (
    mkdir "%~dp0AppsDec"
    color 2
    echo dossier 1 cree
)
if not exist "%~dp0AppsAdresses" (
    mkdir "%~dp0AppsAdresses"
    color 2
    echo dossier 2 cree
)
color 2
echo dossier 2/2
cls
color 6
echo verification des DLL...
if not exist "%~dp0Iced.dll" (
    color C
    echo [MANQUANT] Iced.dll
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/Iced.dll' -OutFile '%~dp0Iced.dll'"
    color 2
    echo [OK] Iced.dll installe
) else (
    color 2
    echo [OK] Iced.dll deja present
)
echo dll 1/5
if not exist "%~dp0System.Buffers.dll" (
    color C
    echo [MANQUANT] System.Buffers.dll
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Buffers.dll' -OutFile '%~dp0System.Buffers.dll'"
    color 2
    echo [OK] System.Buffers.dll installe
) else (
    color 2
    echo [OK] System.Buffers.dll deja present
)
cls
echo dll 2/5
if not exist "%~dp0System.Memory.dll" (
    color C
    echo [MANQUANT] System.Memory.dll
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Memory.dll' -OutFile '%~dp0System.Memory.dll'"
    color 2
    echo [OK] System.Memory.dll installe
) else (
    color 2
    echo [OK] System.Memory.dll deja present
)
cls
echo dll 3/5
if not exist "%~dp0System.Numerics.Vectors.dll" (
    color C
    echo [MANQUANT] System.Numerics.Vectors.dll
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Numerics.Vectors.dll' -OutFile '%~dp0System.Numerics.Vectors.dll'"
    color 2
    echo [OK] System.Numerics.Vectors.dll installe
) else (
    color 2
    echo [OK] System.Numerics.Vectors.dll deja present
)
cls
echo dll 4/5
if not exist "%~dp0System.Runtime.CompilerServices.Unsafe.dll" (
    color C
    echo [MANQUANT] System.Runtime.CompilerServices.Unsafe.dll
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Runtime.CompilerServices.Unsafe.dll' -OutFile '%~dp0System.Runtime.CompilerServices.Unsafe.dll'"
    color 2
    echo [OK] System.Runtime.CompilerServices.Unsafe.dll installe
) else (
    color 2
    echo [OK] System.Runtime.CompilerServices.Unsafe.dll deja present
)
cls
echo dll 5/5
if not exist "%~dp0REmapperEXE.exe" (
    color C
    echo [MANQUANT] REmapperEXE.exe
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/REmapperEXE.exe' -OutFile '%~dp0REmapperEXE.exe'"
    color 2
    echo [OK] REmapperEXE.exe installe
) else (
    color 2
    echo [OK] REmapperEXE.exe deja present
)

set "desktop=%USERPROFILE%\Desktop"
set "file=REmapper.exe"
set "src=%~dp0"
set "bat=%~nx0"

if /i not "%src:~0,-1%"=="%desktop%\%file%" (
    color 6
    echo [DEPLACEMENT] Dossier en cours de deplacement sur le bureau...

    powershell -Command ^
        "$src = '%src:~0,-1%'; $dst = '%desktop%\%file%'; $bat = '%bat%'; " ^
        "Start-Process powershell -ArgumentList \"-NoProfile -Command Start-Sleep 2; Move-Item -Path '$src' -Destination '$dst' -Force; Start-Process '$dst\$bat'\" -WindowStyle Hidden"

    exit
)

color 2
echo REmapperEXE --STATUS-- OP
echo DLL --STATUS-- OP
echo File --STATUS-- OP
echo if still doesn t work please contact the support in the discord serveur thanks https://discord.gg/6eReDWSGeW
pause
