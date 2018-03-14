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
@ECHO Version 1.904
@ECHO Date: 22/01/2018
@ECHO ===============================================
@ECHO.
@ECHO.
PING 127.0.0.1 -n 8>NUL


REM The destination USB disk has to be in the machine that executes this script whit the letter K:

SET _my_datetime=%date%_%time%
SET _my_datetime=%_my_datetime: =_%
SET _my_datetime=%_my_datetime::=%
SET _my_datetime=%_my_datetime:/=_%
SET _my_datetime=%_my_datetime:.=_%
SET OnlyDate=%date:/=-%
SET WorkingDIR=%~d0%~p0


VARIABLES (Change and review please)
************************************
SET SOURCEDIR1=\\192.168.110.49\D$\SAGE\PREVX3
SET SOURCEDIR2=\\192.168.110.49\D$\SAGE\SafeX3\MongoDB
SET TARGETDIR=\\192.168.110.21\k$\BackupDatos\SRSAGE02\%OnlyDate%
SET LABEL1=Disco D: SRSAGE02
SET LABEL2=Disco USB K: SRVM02
SET LABEL3=
SET IPSAGESrv=192.168.110.49
SET Pwd7zaEncript=Txindoki1346
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
@ECHO Stopping "ImportacionDatosINTEGRA" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% STOP "ImportacionDatosINTEGRA" | FIND /I "STA"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "ImportacionDatosINTEGRA" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "Agent Sage Syracuse - NODE0" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% STOP "Agent_Sage_Syracuse_-_NODE0" | FIND /I "STA"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "Agent_Sage_Syracuse_-_NODE0" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "PREVX3" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% STOP "PREVX3" | FIND /I "STA"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "PREVX3" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "MongoDB Enterprise for Sage X3 - MONGO01" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% STOP "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "STA"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "STA"
@ECHO ===========================================================
@ECHO Stopping "MSSQL$SAGE" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% STOP "MSSQL$SAGE" | FIND /I "STA"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "MSSQL$SAGE" | FIND /I "STA"
@ECHO ===========================================================

@ECHO.
@ECHO.
PING 127.0.0.1 -n 120 >NUL



@ECHO.
@ECHO ==================================================
@ECHO Borrando copias anteriores a 61 dias, encontradas:
REM keep only 61 backup
forfiles -p "K:\BackupDatos\SRSAGE02" -d -61 -c "cmd /c rmdir /s /q @PATH" 2>nul | find ":" /c
@ECHO ==================================================
@ECHO.
@ECHO.



@ECHO =====================
@ECHO BACKUP in progress...
@ECHO =====================
@ECHO.
@ECHO.



MKDIR K:\BackupDatos\SRSAGE02\%OnlyDate%



%WorkingDIR%7za.exe a K:\BackupDatos\SRSAGE02\%OnlyDate%\PREVX3.7z %SOURCEDIR1%\*.* -r -V1G -bt -y -mx=9 -ms=on -t7z -xr@%WorkingDIR%exclude.txt -p%Pwd7zaEncript% -mhe >%WorkingDIR%7za_log_PREVX3.txt
%WorkingDIR%7za.exe a K:\BackupDatos\SRSAGE02\%OnlyDate%\SafeX3.7z %SOURCEDIR2%\*.* -r -V1G -bt -y -mx=9 -ms=on -t7z -xr@%WorkingDIR%exclude.txt -p%Pwd7zaEncript% -mhe >%WorkingDIR%7za_log_SafeX3.txt
@ECHO.
@ECHO.



@ECHO Starting Services
@ECHO =================
@ECHO Starting "MSSQL$SAGE" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% START "MSSQL$SAGE" | FIND /I "ESTADO"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "MSSQL$SAGE" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "MongoDB Enterprise for Sage X3 - MONGO01" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% START "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "ESTADO"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "MongoDB Enterprise for Sage X3 - MONGO01" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "PREVX3" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% START "PREVX3" | FIND /I "ESTADO"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "PREVX3" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "Agent Sage Syracuse - NODE0" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% START "Agent_Sage_Syracuse_-_NODE0" | FIND /I "ESTADO"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "Agent_Sage_Syracuse_-_NODE0" | FIND /I "ESTADO"
@ECHO ===========================================================
@ECHO Starting "ImportacionDatosINTEGRA" Service
@ECHO ===========================================================
SC \\%IPSAGESrv% START "ImportacionDatosINTEGRA" | FIND /I "ESTADO"
PING 127.0.0.1 -n 20>NULL
SC \\%IPSAGESrv% QUERY "ImportacionDatosINTEGRA" | FIND /I "ESTADO"
@ECHO.
@ECHO.



SET ENDSCRIPT= %date%-%time:~0,-6%



Change the text of the end backup if you want! :)

DEL bodymail.txt
@ECHO Realizado el Backup de datos SRSAGE02: >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR1% ] >>%WorkingDIR%bodymail.txt
@ECHO SOURCE:  [ %LABEL1% %SOURCEDIR2% ] >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO TARGET:  [ %LABEL2% %TARGETDIR% ] >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO        Los backup destino se han comprimido con 7za para ahorrar espacio >>%WorkingDIR%bodymail.txt
@ECHO        Usar 7za para descomprimir >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO Este correo esta automatizado, no responda a la direccion de origen. >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
@ECHO ================================================  >>%WorkingDIR%bodymail.txt
@ECHO scripts name: %~nx0% >>%WorkingDIR%bodymail.txt
@ECHO Location: %~d0%~p0 >>%WorkingDIR%bodymail.txt
@ECHO ================================================  >>%WorkingDIR%bodymail.txt
@ECHO START: %STARTSCRIPT%h >>%WorkingDIR%bodymail.txt
@ECHO END:   %ENDSCRIPT%h >>%WorkingDIR%bodymail.txt
@ECHO ===============================  >>%WorkingDIR%bodymail.txt
@ECHO LOG 7za: >>%WorkingDIR%bodymail.txt
@ECHO ===============================  >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt
MORE 7za_log_PREVX3.txt >>%WorkingDIR%bodymail.txt
@ECHO ===============================================================  >>%WorkingDIR%bodymail.txt
MORE 7za_log_SafeX3.txt >>%WorkingDIR%bodymail.txt
@ECHO ===============================================================  >>%WorkingDIR%bodymail.txt
@ECHO IT Team >>%WorkingDIR%bodymail.txt
@ECHO. >>%WorkingDIR%bodymail.txt



%WorkingDIR%BLAT -INSTALL %SMTP_SERVER% %EMAIL_FROM% 10
%WorkingDIR%BLAT %WorkingDIR%bodymail.txt -subject "%SUBJECT_EMAIL%" -tf %WorkingDIR%EmailsAddress.txt



@ECHO.
@ECHO ===============================
@ECHO END OF SCRIPT
@ECHO ===============================
@ECHO START: %STARTSCRIPT%
@ECHO END:   %ENDSCRIPT%
@ECHO ===============================
@ECHO.
PING 127.0.0.1 -n 8>NUL


EXIT
