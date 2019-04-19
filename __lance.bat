CLS REM On efface l'‚cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : lance.bat                                                     ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 05/04/2019                                                    ^|
echo ^| Description : Lance des programmes pour arrˆter un "Virus"                  ^|
echo ^| Remarques   :                                                               ^|
echo ^|               1. Lance Process Explorer                                     ^|
echo ^|               2. Lance Invite de commandes                                  ^|
echo ^|               3. Lance ‚diteur de registre                                  ^|
echo ^|               Le fichier doit ˆtre sauvegard‚ dans l'encodage ANSI(cp1252). ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faire Ctrl+C pour quitter le programme ou appuyer sur une touche pour continuer.

REM On fait une pause pour que la fenˆtre reste affich‚e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

procexp.exe
cmd.exe
regedit.exe

REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fenˆtre reste affich‚e
echo Appuyer sur une touche pour quitter le programme.
pause>nul 




