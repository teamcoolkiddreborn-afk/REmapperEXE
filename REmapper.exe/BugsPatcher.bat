@echo off

if not exist "%~dp0AppsDec" (
    mkdir "%~dp0AppsDec"
    echo dossier 1 cree
)

if not exist "%~dp0AppsAdresses" (
    mkdir "%~dp0AppsAdresses"
    echo dossier 2 cree
)
echo dossier 2/2
echo verification des DLL...

if not exist "%~dp0Iced.dll" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/Iced.dll' -OutFile '%~dp0Iced.dll'"
    echo Iced installed
)

echo dll 1/5

if not exist "%~dp0System.Buffers.dll" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Buffers.dll' -OutFile '%~dp0System.Buffers.dll'"
    echo System.Buffers.dll installed
)
cls
echo dll 2/5

if not exist "%~dp0System.Memory.dll" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Memory.dll' -OutFile '%~dp0System.Memory.dll'"
    echo System.Memory.dll installed
)
cls
echo dll 3/5

if not exist "%~dp0System.Numerics.Vectors.dll" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Numerics.Vectors.dll' -OutFile '%~dp0System.Numerics.Vectors.dll'"
    echo System.Numerics.Vectors.dll installed
)
cls
echo dll 4/5

if not exist "%~dp0System.Runtime.CompilerServices.Unsafe.dll" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/System.Runtime.CompilerServices.Unsafe.dll' -OutFile '%~dp0System.Runtime.CompilerServices.Unsafe.dll'"
    echo System.Runtime.CompilerServices.Unsafe.dll installed
)
cls
echo dll 5/5
echo checking for 
if not exist "%~dp0REmapperEXE.exe" (
    powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/teamcoolkiddreborn-afk/REmapperEXE/main/REmapper.exe/REmapperEXE.exe' -OutFile '%~dp0REmapperEXE.exe'"
    echo REmapperEXE.exe installed
)
echo REmapperEXE.exe installed
echo if still doesn t work please contact the support in the discord serveur thanks

pause