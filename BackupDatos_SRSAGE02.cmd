CLS
@ECHO OFF
COLOR 0A
SET INICIO= %date%-%time%
PROMPT $G
TITLE -=BACKUP data SRSAGE02
SET COPYCMD=Y



@ECHO ===============================================
@ECHO Backup Data SRSAGE02
@ECHO (c) Previlabor 2018
@ECHO Author: Angel Pescador Portas
@ECHO email: apescador@previlabor.com
@ECHO email: tic@previlabor.com
@ECHO scripts name: BackupDatos_SRSAGE02.cmd
@ECHO Location: C:\Scripts\BackupSAGE02\
@ECHO Version 1.1
@ECHO Date: 22/01/2018
@ECHO ===============================================
@ECHO.
@ECHO.
PING 127.0.0.1 >NULL
PING 127.0.0.1 >NULL

REM El disco USB destino tiene que estar pinchado en la maquina que ejecuta este script y tener la letra K:\



@ECHO Borrando copias anteriores a 61 dias, encontradas:
@ECHO.
REM keep only 61 backup
forfiles -p "K:\BackupDatos\SRSAGE02" -d -61 -c "cmd /c rmdir /s /q @PATH" 2>nul | find ":" /c
@ECHO.
@ECHO.



SET _my_datetime=%date%_%time%
SET _my_datetime=%_my_datetime: =_%
SET _my_datetime=%_my_datetime::=%
SET _my_datetime=%_my_datetime:/=_%
SET _my_datetime=%_my_datetime:.=_%
SET OnlyDate=%date:/=-%



@ECHO =====================================================================================
@ECHO ORIGEN:  [ Disco D: SRSAGE02 \\192.168.110.49\D$\SAGE\PREVX3 ]
@ECHO ORIGEN:  [ Disco D: SRSAGE02 [\\192.168.110.58\D$\SAGE\SafeX3\MongoDB ]
@ECHO DESTINO: [ Disco USB K: SRVM02 \\192.168.110.21\k$\BackupDatos\SRSAGE02\%OnlyDate% ]
@ECHO =====================================================================================
@ECHO.



ECHO S|NET USE S: /DELETE /Y  2>NULL
NET USE S: \\192.168.110.49\D$  2>NULL
PING 127.0.0.1 >NULL



@ECHO Stoping Services
@ECHO ================
@ECHO Stoping "Agent Sage Syracuse - NODE0" Service
SC \\192.168.110.49 STOP "Agent Sage Syracuse - NODE0"
@ECHO Stoping "PREVX3" Service
SC \\192.168.110.49 STOP "PREVX3"
@ECHO Stoping "MongoDB Enterprise for Sage X3 - MONGO01" Service
SC \\192.168.110.49 STOP "MongoDB Enterprise for Sage X3 - MONGO01"



@ECHO ==================
@ECHO HACIENDO BACKUP...
@ECHO ==================
@ECHO.
@ECHO.



MKDIR K:\BackupDatos\SRSAGE02\%OnlyDate%
ROBOCOPY "S:\SAGE\PREVX3" "K:\BackupDatos\SRSAGE02\%OnlyDate%\PREVX3" /MIR /NJH /NJS /R:1 /W:1 /MT:8 /XD S:\SAGE\PREVX3\folders\PREVILAB\TRA\ S:\SAGE\PREVX3\folders\PREVILAB\SVG\ S:\SAGE\PREVX3\folders\PREVILAB\SVG_ADOCCLB\ S:\SAGE\PREVX3\folders\PREVILAB\SVG77701\ S:\SAGE\PREVX3\folders\COPIA\
ROBOCOPY "S:\SAGE\SafeX3\MongoDB" "K:\BackupDatos\SRSAGE02\%OnlyDate%\MongoDB" /MIR /NJH /NJS /R:1 /W:1 /MT:8



ECHO S|NET USE S: /DELETE 2>NULL
PING 127.0.0.1 >NULL



@ECHO Starting Services
@ECHO =================
@ECHO Starting "MongoDB Enterprise for Sage X3 - MONGO01" Service
SC \\192.168.110.49 START "MongoDB Enterprise for Sage X3 - MONGO01"
@ECHO Starting "PREVX3" Service
SC \\192.168.110.49 START "PREVX3"
@ECHO Starting "Agent Sage Syracuse - NODE0" Service
SC \\192.168.110.49 START "Agent Sage Syracuse - NODE0"



TITLE -=COMPRIMIENDO BACKUPS SRSAGE02=-



K:
CD K:\BackupDatos\SRSAGE02\%OnlyDate%



for /d %%X in (*) do (
 	ECHO %%X
 	MKDIR "%%X_7ZA"
 	ECHO S|DEL "K:\BackupDatos\SRSAGE02\%OnlyDate%\%%X_7ZA\*.*" /S /Q
 	C:\Scripts\BackupINTEGRA\7za.exe a "K:\BackupDatos\SRSAGE02\%OnlyDate%\%%X_7ZA\%%X.7z" "K:\BackupDatos\SRSAGE02\%OnlyDate%\*.*" -r -V1G -bt -y -mx=9 -ms=on -pTxindoki1346 -mhe -sdel
 	ECHO S|RD "K:\BackupDatos\SRSAGE02\%OnlyDate%\%%X" /S /Q
)



SET FIN= %date%-%time%


C:
CD C:\Scripts\BackupSAGE02



@ECHO.
@ECHO ===============================
@ECHO FIN DEL SCRIPT
@ECHO ===============================
@ECHO INICIO: %INICIO%
@ECHO FIN:    %FIN%
@ECHO ===============================
@ECHO.



DEL bodymail.txt



@ECHO Realizado el Backup de datos SRSAGE02: >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO ORIGEN:  [ Disco D: SRSAGE02 \\192.168.110.49\D$\SAGE\PREVX3 ] >>bodymail.txt
@ECHO ORIGEN:  [ Disco D: SRSAGE02 \\192.168.110.58\D$\SAGE\SafeX3\MongoDB ] >>bodymail.txt
@ECHO DESTINO: [ Disco USB K: SRVM02 \\192.168.110.21\k$\BackupDatos\SRSAGE02\%OnlyDate% ] >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO        Los backup destino se han comprimido con 7za para ahorrar espacio >>bodymail.txt
@ECHO        Usar 7za para descomprimir >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO Este correo esta automatizado, no responda a la direccion de origen. >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO ===============================  >>bodymail.txt
@ECHO INICIO: %INICIO% >>bodymail.txt
@ECHO FIN:    %FIN% >>bodymail.txt
@ECHO ===============================  >>bodymail.txt
@ECHO. >>bodymail.txt
@ECHO IT Team >>bodymail.txt



BLAT -INSTALL previlabor-com.mail.protection.outlook.com Backup_Datos_SRSAGE02@previlabor.com 10
BLAT bodymail.txt -subject "Fin del Backup de datos SRSAGE02 %OnlyDate%" -tf EmailsAddress.txt



PING 127.0.0.1 >NULL
PING 127.0.0.1 >NULL

EXIT