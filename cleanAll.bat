ECHO OFF
ECHO "NETTOYAGE DES REP"
FOR /R %%I IN (.) DO (
     
     CD %%I
	 IF EXIST clean.bat clean.bat	 
     
)