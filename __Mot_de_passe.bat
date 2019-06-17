CLS REM On efface l'‚cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : Mot_de_passe.bat                                              ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 17/06/2019                                                    ^|
echo ^| Description : Ouvre les fenˆtres pour d‚sactiver le mot de passe Windows.   ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faites Ctrl+C pour quitter le programme ou appuyez sur une touche pour continuer.

REM On fait une pause pour que la fenˆtre reste affich‚e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

echo(

echo 1- Ouverture de la fenˆtre pour d‚sactiver le mot de passe … l'ouverture de la session
echo (Appuyez sur une touche pour afficher la fenˆtre)
pause>nul

netplwiz

echo(

echo 2- Ouverture de la fenˆtre pour d‚sactiver le mot de passe pour la sortie de veille
echo (Appuyez sur une touche pour afficher la fenˆtre)
pause>nul

start ms-settings:signinoptions


REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fenˆtre reste affich‚e
echo Appuyez sur une touche pour quitter le programme.
pause>nul 