CLS REM On efface l'‚cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : BIOS.bat                                                      ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 05/04/2019                                                    ^|
echo ^| Description : Enregistre et affiche des informations sur le BIOS.           ^|
echo ^| Remarques   :                                                               ^|
echo ^|               Les informations sont enregistrée dans le fichier BIOS.txt    ^|
echo ^|               Lance aussi msinfo32                                          ^|
echo ^|               Le fichier doit ˆtre sauvegard‚ dans l'encodage ANSI(cp1252). ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faire Ctrl+C pour quitter le programme ou appuyer sur une touche pour continuer.

REM On fait une pause pour que la fenˆtre reste affich‚e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

echo USERNAME=%USERNAME% > BIOS.txt
echo COMPUTERNAME=%COMPUTERNAME% >> BIOS.txt
wmic BIOS get name, version, serialnumber >> BIOS.txt

msinfo32

REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fenˆtre reste affich‚e
echo Appuyer sur une touche pour quitter le programme.
pause>nul 

