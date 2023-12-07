@echo off
setlocal enabledelayedexpansion
chcp 65001

rem Hedef klasörü belirle
set "targetFolder=updatefiles"

rem Bat dosyasının bulunduğu dizini al
set "scriptDir=%~dp0"

rem Zip dosyasını çıkart
powershell -command "& {Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%scriptDir%update.zip', '%targetFolder%');}"

timeout /nobreak /t 1 >nul

rem Dosya isimlerindeki Ÿ harfini ş harfi ile değiştir
for %%a in ("%targetFolder%\*Ÿ*") do (
  set file=%%~nxa
  set "newName=!file:Ÿ=ş!"
  ren "%%a" "!newName!"
)

timeout /nobreak /t 1 >nul

xcopy /Y /S "%targetFolder%" "%scriptDir%" 

timeout /nobreak /t 1 >nul

rmdir /s /q "%targetFolder%"
del /F /Q "%scriptDir%update.zip"

exit /b
