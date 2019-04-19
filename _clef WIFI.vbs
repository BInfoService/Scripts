'Show_Wifi_Keys by Hackoo 2014
Option Explicit
Dim MyCmd,Temp,Titre,MsgTitre,MsgAttente,Copyright,oExec,ws,WshNetwork,NomMachine
Copyright = "Exportation du résumé des informations du système sans fil avec les clés de sécurité © Hackoo 2014"
Set ws = CreateObject("WScript.Shell")
Set WshNetwork = CreateObject("WScript.Network")
NomMachine = WshNetwork.ComputerName
Temp = ws.ExpandEnvironmentStrings("%Temp%")
Titre = Copyright
MsgAttente = "Veuillez patienter. Exportation du résumé des informations du système sans fil avec les clés de sécurité . . . . "
Call CreateProgressBar(Titre,MsgAttente)
Call LancerProgressBar()
Call Pause(1)
Call Show_Wifi_Keys()
Call FermerProgressBar()
'**************************************************************************************
Function Executer(StrCmd,Console)
	Dim ws,MyCmd,Resultat
	Set ws = CreateObject("wscript.Shell")
'La valeur 0 pour cacher la console MS-DOS
	If Console = 0 Then
		MyCmd = "CMD /C " & StrCmd & ""
		Resultat = ws.run(MyCmd,Console,True)
		If Resultat = 0 Then
'MsgBox "Success"
		Else
			MsgBox "Une erreur inconnue est survenue !",16,"Une erreur inconnue est survenue !"
		End If
	End If
'La valeur 1 pour montrer la console MS-DOS
	If Console = 1 Then
		MyCmd = "CMD /K " & StrCmd & ""
		Resultat = ws.run(MyCmd,Console,True)
		If Resultat = 0 Then
'MsgBox "Success"
		Else
			MsgBox "Une erreur inconnue est survenue !",16,"Une erreur inconnue est survenue !"
		End If
	End If
	Executer = Resultat
End Function
'**************************************************************************************
Sub Show_Wifi_Keys()
	Dim objShell,fso,File,strContents,objRegEx,objMatch,colMatches
	Dim UnicodeFile,AsciiFile
	UnicodeFile = "Unicode_Cles_Wifi.txt"
	AsciiFile = "Cles_Wifi_"& NomMachine & ".txt"
	set objShell = CreateObject("WScript.Shell")
	Set fso = CreateObject("Scripting.FileSystemObject") 
	Call Executer("netsh wlan show all > Cles_WifiTmp.txt",0)
	Set File = fso.OpenTextFile("Cles_WifiTmp.txt",1)
	strContents = File.ReadAll
	File.Close
	Set objRegEx = New RegExp
	objRegEx.IgnoreCase = True
	objRegEx.Global = True
	objRegEx.Multiline = True
	objRegEx.Pattern = """([^""]+)"""
	set colMatches = objRegEx.Execute(strContents)
	Call Executer("Echo ****************************************************************** > Cles_WifiTmp.txt"_
	& "& echo Clés Wifi de sécurité avec les SSID enregistrés sur %ComputerName% >> Cles_WifiTmp.txt"_
	& "& echo. & echo ****************************************************************** >> Cles_WifiTmp.txt",0)
	For each objMatch in colMatches
		Call Executer("echo "& objMatch.Value &" >> Cles_WifiTmp.txt & echo. >> Cles_WifiTmp.txt & Netsh wlan show profiles name="& objMatch.Value &" key=clear | Findstr /i ""Conten"" >> Cles_WifiTmp.txt"_
		& "& echo. & echo ******************************************************************>> Cles_WifiTmp.txt & cmd /U /C Type Cles_WifiTmp.txt > "& UnicodeFile & "",0)
	Next
	Call Convert(UnicodeFile,AsciiFile)
	Call Executer("Start "& AsciiFile & "& Del Cles_WifiTmp.txt & Del "& UnicodeFile & "",0)
End sub
'***************************************************************************************
Sub WLAN_Networks()
	If Executer("netsh wlan show profiles > Wlan_tmp.txt & netsh wlan show networks >> Wlan_tmp.txt & netsh wlan show interfaces >> Wlan_tmp.txt & cmd /U /C Type Wlan_tmp.txt > Wlan_Networks.txt",0) = 0 Then
		Call Executer("Start Wlan_Networks.txt & Del Wlan_tmp.txt",0)
	End If
End Sub
'***************************************************************************************
Function DblQuote(Str)
	DblQuote = Chr(34) & Str & Chr(34)
End Function
'***************************************************************************************
'Pour Convertir le LogFile de Unicode en Ascii
Sub Convert(UnicodeFile,AsciiFile)
	Const ForReading = 1, ForWriting = 2, ForAppending = 8
	Const ModeAscii = 0, ModeUnicode = -1
	Dim fso, f_in, f_out
	Set fso = CreateObject("Scripting.FileSystemObject" )
	Set f_in = fso.OpenTextFile(UnicodeFile, ForReading,, ModeUnicode)
	Set f_out = fso.OpenTextFile(AsciiFile, ForWriting, true, ModeAscii)
	Do Until f_in.AtEndOfStream
		f_out.Write f_in.Read(1)
	Loop
	f_in.Close
	f_out.Close
End Sub
'****************************************************************************************
Sub CreateProgressBar(Titre,MsgAttente)
	Dim ws,fso,f,f2,ts,ts2,Ligne,i,fread,LireTout,NbLigneTotal,Temp,PathOutPutHTML,fhta,oExec
	Set ws = CreateObject("wscript.Shell")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Temp = WS.ExpandEnvironmentStrings("%Temp%")
	PathOutPutHTML = Temp & "\Barre.hta"
	Set fhta = fso.OpenTextFile(PathOutPutHTML,2,True)
	fhta.WriteLine "<HTML>"
	fhta.WriteLine "<HEAD>"
	fhta.WriteLine "<Title>  " & Titre & "</Title>"
	fhta.WriteLine "<HTA:APPLICATION"
	fhta.WriteLine "ICON = ""magnify.exe"" "
	fhta.WriteLine "BORDER=""THIN"" "
	fhta.WriteLine "INNERBORDER=""NO"" "
	fhta.WriteLine "MAXIMIZEBUTTON=""NO"" "
	fhta.WriteLine "MINIMIZEBUTTON=""NO"" "
	fhta.WriteLine "SCROLL=""NO"" "
	fhta.WriteLine "SYSMENU=""NO"" "
	fhta.WriteLine "SELECTION=""NO"" "
	fhta.WriteLine "SINGLEINSTANCE=""YES"">"
	fhta.WriteLine "</HEAD>"
	fhta.WriteLine "<BODY text=""white""><CENTER>"
	fhta.WriteLine "<marquee DIRECTION=""LEFT"" SCROLLAMOUNT=""3"" BEHAVIOR=ALTERNATE><font face=""Comic sans MS"">" & MsgAttente &"</font></marquee>"
	fhta.WriteLine "<br><img src=""data:image/gif;base64,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"" />"
	fhta.WriteLine "</CENTER></BODY></HTML>"
	fhta.WriteLine "<SCRIPT LANGUAGE=""VBScript""> "
	fhta.WriteLine "Set ws = CreateObject(""wscript.Shell"")"
	fhta.WriteLine "Temp = WS.ExpandEnvironmentStrings(""%Temp%"")"
	fhta.WriteLine "Sub window_onload()"
	fhta.WriteLine "    CenterWindow 600,100"
	fhta.WriteLine "    Self.document.bgColor = ""DarkOrange"" "
	fhta.WriteLine " End Sub"
	fhta.WriteLine " Sub CenterWindow(x,y)"
	fhta.WriteLine "    Dim iLeft,itop"
	fhta.WriteLine "    window.resizeTo x,y"
	fhta.WriteLine "    iLeft = window.screen.availWidth/2 - x/2"
	fhta.WriteLine "    itop = window.screen.availHeight/2 - y/2"
	fhta.WriteLine "    window.moveTo ileft,itop"
	fhta.WriteLine "End Sub"
	fhta.WriteLine "</script>"
	fhta.close
End Sub
'**********************************************************************************************
Sub LancerProgressBar()
	Set oExec = Ws.Exec("mshta.exe " & Temp & "\Barre.hta")
End Sub
'**********************************************************************************************
Sub FermerProgressBar()
	oExec.Terminate
End Sub
'**********************************************************************************************
Sub Pause(NSeconds)
	Wscript.Sleep(NSeconds*1000)
End Sub  
'**********************************************************************************************