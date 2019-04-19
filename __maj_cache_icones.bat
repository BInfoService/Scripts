CLS REM On efface l'‚cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : maj_cache_icones.bat                                          ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 05/04/2019                                                    ^|
echo ^| Description : Mise à jour du cache des icônes.                              ^|
echo ^| Remarques   :                                                               ^|
echo ^| Remarques   :  1. Arrˆte l'explorateur Windows                              ^|
echo ^| Remarques   :  2. Efface le fichier utilisateur IconCache.db                ^|
echo ^| Remarques   :  3. Red‚marre l'explorateur Windows                           ^|
echo ^| Remarques   : Le fichier doit ˆtre sauvegard‚ dans l'encodage ANSI(cp1252). ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faire Ctrl+C pour quitter le programme ou appuyer sur une touche pour continuer.

REM On fait une pause pour que la fenˆtre reste affich‚e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

kill explorer.exe
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
explorer.exe

REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fenˆtre reste affich‚e
echo Appuyer sur une touche pour quitter le programme.
pause>nul 
