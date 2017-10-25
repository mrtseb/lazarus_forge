@ECHO OFF
CLS
set NLM=^


set NL=^^^%NLM%%NLM%^%NLM%%NLM%
SET projet=default
SET serie=COM3
SET baud=115200
SET options=-c -g -Os -w -fno-exceptions -ffunction-sections -fdata-sections -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=22
SET prefix=.
SET AVR_CPP=%prefix%\hardware\tools\avr\bin\avr-c++.exe
SET AVR_GCC=%prefix%\hardware\tools\avr\bin\avr-gcc.exe  
SET AVR_AR=%prefix%\hardware\tools\avr\bin\avr-ar.exe
SET AVR_OBJCOPY=%prefix%\hardware\tools\avr\bin\avr-objcopy.exe
SET dir=%prefix%\hardware\arduino\avr
SET ldir=%prefix%\libraries
SET ts=%ldir%\TS
SET mb=%ldir%\makeblock\src
SET ldir2=%prefix%\hardware\arduino\avr\libraries
echo %time%
DEL prod\%USERNAME%_%USERDOMAIN%_%projet%.*
echo #include "Arduino.h"%NL%  > prod\%USERNAME%_%USERDOMAIN%_%projet%.cpp
echo "PATCH DE ./ino/%projet%.ino vers prod\%USERNAME%_%USERDOMAIN%_%projet%.cpp"
copy /B prod\%USERNAME%_%USERDOMAIN%_%projet%.cpp + .\ino\%USERNAME%_%USERDOMAIN%_%projet%.ino prod\%USERNAME%_%USERDOMAIN%_%projet%.cpp

ECHO "COMPILATION DU PROJET"
%AVR_CPP% -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -MMD -flto -mmcu=atmega328p -DF_CPU=16000000L -DARDUINO=10801 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR -I%dir%\cores\arduino -I%dir%\variants\standard -I%ldir2%/Wire -I%ldir2%/Wire/utility/ -I%ldir2%/SoftwareSerial -I %ldir%/Firmata/ -I %ldir%/Firmata/utility/ -I %ldir%/Servo/src/ -I%ts% -I%mb% -o prod\%USERNAME%_%USERDOMAIN%_%projet%.o prod\%USERNAME%_%USERDOMAIN%_%projet%.cpp 

ECHO "Edition des liens"
%AVR_GCC% -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=atmega328p -o "prod\%USERNAME%_%USERDOMAIN%_%projet%.elf" "prod\%USERNAME%_%USERDOMAIN%_%projet%.o" "core\core.a" "-Lcore" -lm
echo "Génération du fichier HEX"
%AVR_OBJCOPY% -O ihex -R .eeprom prod\%USERNAME%_%USERDOMAIN%_%projet%.elf prod\%USERNAME%_%USERDOMAIN%_%projet%.hex
echo %time%