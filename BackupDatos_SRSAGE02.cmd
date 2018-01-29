CLS
@ECHO OFF
COLOR 0A
SET STARTSCRIPT= %date%-%time:~0,-6%
PROMPT $G
TITLE -=BACKUP data SRSAGE02=-
SET COPYCMD=Y



@ECHO ===============================================
@ECHO Backup Data SRSAGE02
@ECHO (c) Previlabor 2018
@ECHO Author: Angel Pescador Portas
@ECHO email: apescador@previlabor.com
@ECHO email: tic@previlabor.com
@ECHO scripts name: %~nx0%
@ECHO Location: %~d0%~p0
@ECHO Version 1.901
@ECHO Date: 22/01/2018
@ECHO ===============================================
@ECHO.
@ECHO.
PING 127.0.0.1 >NULL
PING 127.0.0.1 >NULL

REM The destination USB disk has to be in the machine that executes this script whit the letter K:

SET _my_datetime=%date%_%time%
SET _my_datetime=%_my_datetime: =_%
SET _my_datetime=%_my_datetime::=%
SET _my_datetime=%_my_datetime:/=_%
SET _my_datetime=%_my_datetime:.=_%
SET OnlyDate=%date:/=-%



VARIABLES (Change and review please)
************************************
SET SOURCEDIR1=\\192.168.110.49\D$\SAGE\PREVX3
SET SOURCEDIR2=\\192.168.110.49\D$\SAGE\SafeX3\MongoDB
SET TARGETDIR=\\192.168.110.21\k$\BackupDatos\SRSAGE02\%OnlyDate%
SET LABEL1=Disco D: SRSAGE02
SET LABEL2=Disco USB K: SRVM02
SET LABEL3=
SET EMAIL_FROM=Backup_Datos_SRSAGE02@previlabor.com
SET SUBJECT_EMAIL=Fin del Backup de datos SRSAGE02 %OnlyDate%
SET SMTP_SERVER=previlabor-com.mail.protection.outlook.com



@ECHO =====================================================================================
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR1% ]
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR2% ]
@ECHO TARGET:  [ %LABEL2% %TARGETDIR% ]
@ECHO =====================================================================================
@ECHO.
@ECHO.


@ECHO Stopping Services
@ECHO ================
@ECHO Stopping "MSSQL$SAGE" Service
@ECHO ===========================================================
SC \\192.168.110.49 STOP "MSSQL$SAGE" | FIND /I "STA"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "MSSQL$SAGE" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "ImportacionDatosINTEGRA" Service
@ECHO ===========================================================
SC \\192.168.110.49 STOP "ImportacionDatosINTEGRA" | FIND /I "STA"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "ImportacionDatosINTEGRA" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "Agent Sage Syracuse - NODE0" Service
@ECHO ===========================================================
SC \\192.168.110.49 STOP "Agent_Sage_Syracuse_-_NODE0" | FIND /I "STA"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "Agent_Sage_Syracuse_-_NODE0" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "PREVX3" Service
@ECHO ===========================================================
SC \\192.168.110.49 STOP "PREVX3" | FIND /I "STA"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "PREVX3" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "MongoDB Enterprise for Sage X3 - MONGO01" Service
@ECHO ===========================================================
SC \\192.168.110.49 STOP "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "STA"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "STA"
@ECHO ===========================================================
@ECHO.
@ECHO.
PING 127.0.0.1 -n 120 >NULL



@ECHO.
@ECHO ==================================================
@ECHO Borrando copias anteriores a 61 dias


































, encontradas:

REM










 keep only 61 backup


forfiles -p "K:\BackupDatos\SRSAGE02" -d -61 -c "cmd /c rmdir /s /q @PATH"
















 2>nul | find ":" /c

@ECHO ==================================================

@ECHO.






















































@ECHO.




@ECHO =====================
@ECHO BACKUP in progress...
@ECHO =====================
@ECHO.
@ECHO.



MKDIR K:\BackupDatos\SRSAGE02\%OnlyDate%



.\7za.exe a K:\BackupDatos\SRSAGE02\%OnlyDate%\PREVX3.7z %SOURCEDIR1%\*.* -r -V1G -bt -y -mx=9 -ms=on -t7z -xr@exclude.txt -pTxindoki1346 -mhe >7za_log_PREVX3.txt
.\7za.exe a K:\BackupDatos\SRSAGE02\%OnlyDate%\SafeX3.7z %SOURCEDIR2%\*.* -r -V1G -bt -y -mx=9 -ms=on -t7z -xr@exclude.txt -pTxindoki1346 -mhe >7za_log_SafeX3.txt
@ECHO.
@ECHO.



Change ever service and server '\\' for the IP Address of the SAGE/Syracuse Service server and the name of the service
**********************************************************************************************************************

@ECHO Starting Services
@ECHO =================
@ECHO Starting "MongoDB Enterprise for Sage X3 - MONGO01" Service
@ECHO ===========================================================
SC \\192.168.110.49 START "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "ESTADO"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "PREVX3" Service
@ECHO ===========================================================
SC \\192.168.110.49 START "PREVX3" | FIND /I "ESTADO"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "PREVX3" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "Agent Sage Syracuse - NODE0" Service
@ECHO ===========================================================
SC \\192.168.110.49 START "Agent_Sage_Syracuse_-_NODE0" | FIND /I "ESTADO"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "Agent_Sage_Syracuse_-_NODE0" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "ImportacionDatosINTEGRA" Service
@ECHO ===========================================================
SC \\192.168.110.49 START "ImportacionDatosINTEGRA" | FIND /I "ESTADO"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "ImportacionDatosINTEGRA" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "MSSQL$SAGE" Service
@ECHO ===========================================================
SC \\192.168.110.49 START "MSSQL$SAGE" | FIND /I "ESTADO"
PING 127.0.0.1 -n 10>NULL
SC \\192.168.110.49 QUERY "MSSQL$SAGE" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO.
@ECHO.



SET ENDSCRIPT= %date%-%time:~0,-6%



Change the text of the end backup if you want! :)

DEL bodymail.txt
@ECHO Realizado el Backup de datos SRSAGE02: >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR1% ] >>bodymail.txt
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR2% ] >>bodymail.txt
@ECHO TARGET:  [ %LABEL2% %TARGETDIR% ] >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO        Los backup destino se han comprimido con 7za para ahorrar espacio >>bodymail.txt
@ECHO        Usar 7za para descomprimir >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO Este correo esta automatizado, no responda a la direccion de origen. >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO ================================================  >>bodymail.txt
@ECHO scripts name: %~nx0% >>bodymail.txt
@ECHO Location: %~d0%~p0 >>bodymail.txt
@ECHO ================================================  >>bodymail.txt
@ECHO START: %STARTSCRIPT%h >>bodymail.txt
@ECHO END:   %ENDSCRIPT%h >>bodymail.txt
@ECHO ===============================  >>bodymail.txt
@ECHO LOG 7za: >>bodymail.txt
@ECHO ===============================  >>bodymail.txt
@ECHO. >>bodymail.txt
MORE 7za_log_PREVX3.txt >>bodymail.txt
MORE 7za_log_SafeX3.txt >>bodymail.txt
@ECHO ===============================================================  >>bodymail.txt
@ECHO IT Team >>bodymail.txt
@ECHO. >>bodymail.txt



BLAT -INSTALL %SMTP_SERVER% %EMAIL_FROM% 10
BLAT bodymail.txt -subject "%SUBJECT_EMAIL%" -tf EmailsAddress.txt



@ECHO.
@ECHO ===============================
@ECHO END OF SCRIPT
@ECHO ===============================
@ECHO START: %STARTSCRIPT%
@ECHO END:   %ENDSCRIPT%
@ECHO ===============================
@ECHO.
PING 127.0.0.1 >NULL
PING 127.0.0.1 >NULL

EXIT
