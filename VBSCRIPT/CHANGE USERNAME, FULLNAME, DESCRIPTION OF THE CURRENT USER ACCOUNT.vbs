
''' VBSCRIPT -> CHANGE USERNAME, FULLNAME, DESCRIPTION OF THE CURRENT USER ACCOUNT -> Version 2023.12.16
'''
''' THIS SCRIPT ALLOWS YOU TO CHANGE THE USERNAME, FULL NAME, AND DESCRIPTION OF THE CURRENT USER ACCOUNT ON A WINDOWS SYSTEM.
''' IT PROMPTS FOR THE NEW VALUES AND APPLIES THE CHANGES USING WMIC AND NET USER COMMANDS.

Option Explicit

Dim TITLE, COMPUTER
TITLE = "Change UserName + FullName - Version 2023.12.16"
COMPUTER = "."

Function DOUBLE_QUOTES(STR)
    DOUBLE_QUOTES = Chr(34) & STR & Chr(34)
End Function

If Not WScript.Arguments.Named.Exists("elevate") Then
    CreateObject("Shell.Application").ShellExecute DOUBLE_QUOTES(WScript.FullName), DOUBLE_QUOTES(WScript.ScriptFullName) & " /elevate", "", "runas", 1
    WScript.Quit
End If

Call CHANGE_FULLNAME_FOR_USERNAME()
Call CHANGE_DESCRIPTION_FOR_USERNAME()
Call RENAME_USERNAME()

Function GET_CURRENT_USERNAME()
	Dim WSH_SHELL
	Set WSH_SHELL = CreateObject( "WScript.Shell" )
	GET_CURRENT_USERNAME = WSH_SHELL.ExpandEnvironmentStrings("%USERNAME%")
End Function

Sub RENAME_USERNAME()
	Dim Curr_UserName, New_UserName

	Curr_UserName = GET_CURRENT_USERNAME()
	If Curr_UserName = "" Then Exit Sub

    New_UserName = InputBox("CURRENT USERNAME IS " & UCase(Curr_UserName) & vbCrlf & vbCrlf & "PLEASE ENTER THE NEW USERNAME", TITLE, "")
    If New_UserName = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "WMIC USERACCOUNT where name=" & DOUBLE_QUOTES(Curr_UserName) & " rename " & DOUBLE_QUOTES(New_UserName)
	RESULT = WS.run(COMMAND,0,True)
End Sub

Sub CHANGE_FULLNAME_FOR_USERNAME()
	Dim Curr_UserName, New_FullName

	Curr_UserName = GET_CURRENT_USERNAME()
	If Curr_UserName = "" Then Exit Sub

    New_FullName = InputBox("CURRENT USERNAME IS " & UCase(Curr_UserName) & vbCrlf & vbCrlf & "PLEASE ENTER THE NEW FULL NAME", TITLE, "")
    If New_FullName = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "WMIC USERACCOUNT where name=" & DOUBLE_QUOTES(Curr_UserName) & " set FullName=" & DOUBLE_QUOTES(New_FullName)
	RESULT = WS.run(COMMAND,0,True)
End Sub

Sub CHANGE_DESCRIPTION_FOR_USERNAME()
	Dim Curr_UserName, New_DESCRIPTION

	Curr_UserName = GET_CURRENT_USERNAME()
	If Curr_UserName = "" Then Exit Sub

    New_DESCRIPTION = InputBox("CURRENT USERNAME IS " & UCase(Curr_UserName) & vbCrlf & vbCrlf & "PLEASE ENTER THE NEW DESCRIPTION", TITLE, "")
    If New_DESCRIPTION = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "NET USER " & DOUBLE_QUOTES(Curr_UserName) & " /comment:" & DOUBLE_QUOTES(New_DESCRIPTION)
	RESULT = WS.run(COMMAND,0,True)
End Sub
