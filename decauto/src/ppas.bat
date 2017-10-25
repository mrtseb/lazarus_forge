@echo off
SET THEFILE=C:\decauto\lib\x86_64-win64\decauto.obj
echo Linking %THEFILE%
D:\lazarus2\fpc\3.0.0\bin\x86_64-win64\fpcres.exe -o C:\decauto\lib\x86_64-win64\decauto.obj -a x86_64 -of coff  "@C:\decauto\lib\x86_64-win64\decauto.reslst"
if errorlevel 1 goto linkend
SET THEFILE=decauto.exe
echo Linking %THEFILE%
D:\lazarus2\fpc\3.0.0\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o decauto.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
