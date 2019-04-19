CLS REM On efface l'‚cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : cache_disque_D.bat                                            ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 05/04/2019                                                    ^|
echo ^| Description : Cache le disque D.                                            ^|
echo ^| Remarques   :                                                               ^|
echo ^| Remarques   : Ajoute une cl‚ dans le registre (NoDrives)                    ^|
echo ^| Remarques   : Le fichier doit ˆtre sauvegard‚ dans l'encodage ANSI(cp1252). ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faire Ctrl+C pour quitter le programme ou appuyer sur une touche pour continuer.

REM On fait une pause pour que la fenˆtre reste affich‚e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

echo "Cache le disque D"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\
Explorer" /v "NoDrives" /t REG_DWORD /d 16


REM A: 1, B: 2, C: 4, D: 8, E: 16, F: 32, G: 64, H: 128, I: 256, J: 512, K: 1024, L: 2048, M: 4096, N: 8192, O: 16384, P: 32768, Q: 65536, R: 131072, S: 262144, T: 524288, U: 1048576, V: 2097152, W: 4194304, X: 8388608, Y: 16777216, Z: 33554432, ALL: 67108863

REM Il faut additionner les valeurs si on veut ajouter des disques (A et D => 9)

REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fenˆtre reste affich‚e
echo Appuyer sur une touche pour quitter le programme.
pause>nul 


