del /s /q *.~*
del /s /q *.raw
del /s /q *.cir
del /s /q *.dcu
del /s /q *.log
del /s /q *.ppu
del /s /q *.bak
del /s /q *.obj
del /q .\src-lazarus\*.o
copy .\src-lazarus\MrTArduino1.exe .\
copy .\src-lazarus\SerialReader1.exe .\
strip.exe SerialReader1.exe
strip.exe MrTArduino1.exe
