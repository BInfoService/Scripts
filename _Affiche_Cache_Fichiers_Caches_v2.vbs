'+----------------------------------------------------------------------------+
'| Fichier     : AfficheCacheFichiersCaches.vbs                               |
'+----------------------------------------------------------------------------+
'| Version     : 0.2                                                          |
'+----------------------------------------------------------------------------+
'| Description :                                                              |
'|                                                                            |
'| Affiche/Cache les fichiers cachés.                                         |
'|                                                                            |
'|    - On modifie des clés du registre (voir dans le code).                  |
'+----------------------------------------------------------------------------+



' Force la déclaration des variables : on est obligé de faire : `Dim Variable`
Option Explicit

' Empêche les erreurs de s'afficher (à supprimer lors du débogage)
' Doit être ajouté dans chaque routine
'On Error Resume Next

' Déclaration des variables obligatoire
Dim result, strEnTeteScript, strTitre ' Ne pas toucher à ces variables
Dim strNomScript, strVersionScript, strDescription ' Ne pas toucher à ces variables

' Initialisation des variables
strNomScript               = "AfficheCacheFichiersCaches.vbs"
strVersionScript           = "0.2"
strDescription             = "Affiche/Cache les fichiers cachés."
strTitre                   = "AfficheCacheFichiersCaches.vbs"
strEnTeteScript            = ""
strEnTeteScript            = strEnTeteScript & strNomScript & " - V" & strVersionScript & vbNewLine
strEnTeteScript            = strEnTeteScript & strDescription & vbNewLine





' Demande de validation pour l'exécution du script
'result = MsgBox ("Ce script va afficher le contenu du dossier " _
'                 & strFolder & " ." _
'                 & vbNewLine & "Voulez-vous continuer ?", _
'                 vbYesNo+vbQuestion, strTitre)

result = MsgBox (strEnTeteScript _
                 & vbNewLine & "Voulez-vous continuer ?", _
                 vbYesNo+vbQuestion, strTitre)

If result = 6 Then

  Call Main()

End If

' Message d'avertissement de fin de script.
result = MsgBox ("Script Terminé", vbOKOnly+vbInformation, strTitre)



'------------------------------------------------------------------------------
' Programme principal
'------------------------------------------------------------------------------

'- Clés du registre :
'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden
'         =1 (dword)
'         Afficher les fichiers, dossiers et lecteurs cachés
'         =2 (dword)
'         Ne pas afficher les fichiers, dossiers ou lecteurs cachés

'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden*
'         =1 (dword) => décoché
'         Masquer les fichiers protégés du système d'exploitation
'         =0  (dword) ou clé n'existe pas => coché

'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\SuperHidden*
'         =1 (dword)
'         Affichés
'         =0 (dword)
'         Cachés


Sub Main()

  dim strRegistre, strCle1, str1, strCle2, str2, strCle3, str3, objShell
    
  strRegistre = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"

  strCle1 = "Hidden"
  str1 = ReadFromRegistry(strRegistre & strCle1, "ha")
  strCle2 = "ShowSuperHidden"
  str2 = ReadFromRegistry(strRegistre & strCle2, "ha")
  strCle3 = "SuperHidden"
  str3 = ReadFromRegistry(strRegistre & strCle3, "ha")

  ' WScript.echo "Hidden = " & str1
  ' WScript.echo "ShowSuperHidden = " & str2

  Set objShell = CreateObject("WScript.Shell")


  If str1 = "1" Or str2 = "1"  Then 
    ' WScript.echo "Fichiers cachés affichés. On les cache."
    objShell.RegWrite strRegistre & strCle1,2,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle2,0,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle3,0,"REG_DWORD"
  Else
    ' WScript.echo "Fichiers cachés PAS affichés. On les affiche."
    objShell.RegWrite strRegistre & strCle1,1,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle2,1,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle3,1,"REG_DWORD"
  End If


  call RafraichitExplorateur()

  set objShell = Nothing

End Sub

'------------------------------------------------------------------------------
' Nom              : ReadFromRegistry.
' strRegistryKey   : Nom complet de la clé du registre.
' strDefault       : Valeur à renvoyer si erreur.
' retour           : La valeur de la clé ou strDefault si erreur.
'------------------------------------------------------------------------------
function ReadFromRegistry (strRegistryKey, strDefault )
	dim objShell, value
	
	'On Error Resume Next

	set objShell = CreateObject("WScript.Shell")
	value        = objShell.RegRead( strRegistryKey )
	
	If Err.number <> 0 Then
		ReadFromRegistry = strDefault
	Else
		ReadFromRegistry = value
	End If
	
	set objShell = nothing
end function


'------------------------------------------------------------------------------
' Nom              : RafraichitExplorateur.
' Description      : Actualise toutes les fenêtres ouvertes de l'explorateur windows.
'------------------------------------------------------------------------------
function RafraichitExplorateur() 
   dim WshShellX, objShell, objIE, objShellWindows
   
   set objShell        = CreateObject("Shell.Application")
   set WshShellX       = CreateObject("WScript.Shell")
   set objShellWindows = objShell.Windows
   
   ' Attention !
   ' Cet objet contient les fenêtres explorateur window + internet explorer
   If objShellWindows.Count <> 0 Then
   
      for each objIE in objShellWindows
      'For i = 0 to objShellWindows.Count - 1
      
          'Set objIE = objShellWindows.Item(i)
          
          'strURL = objIE.LocationURL
          ' WScript.Echo strURL & vbCrLf & objIE.Path
          
          ' Si l'URL commence par "file:///",
          ' alors c'est une fenêtre de l'explorateur windows
          'If InStr(strURL, "file:///") Then
         if InStr(objIE.LocationURL, "file:///") then
            objIE.Refresh
         end if
          
         'Set objIE = Nothing
      next

   end if

   ' Actualise le bureau
   call RafraichitBureau()
      
   set objShell  = nothing
   set WshShellX = nothing

end function

'------------------------------------------------------------------------------
' Nom              : RafraichitBureau.
' Description      : Actualise le bureau l'explorateur windows.
'------------------------------------------------------------------------------
function RafraichitBureau() 
   Dim WshShellX, objShell, objIE, objShellWindows
   
   set objShell        = CreateObject("Shell.Application")
   set WshShellX       = CreateObject("WScript.Shell")
   
   objShell.ToggleDesktop
   WScript.Sleep 100
   WshShellX.SendKeys "{F5}"
   WScript.Sleep 100
   objShell.ToggleDesktop
   
   set objShell  = nothing
   set WshShellX = nothing

end function
