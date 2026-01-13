
''' VBSCRIPT -> RENAME THIS PC -> Version 2023.12.16

Option Explicit

Dim TITLE, COMPUTER
TITLE = "Rename This PC - Version 2023.12.16"
COMPUTER = "."

Function DOUBLE_QUOTES(STR)
    DOUBLE_QUOTES = Chr(34) & STR & Chr(34)
End Function

If Not WScript.Arguments.Named.Exists("elevate") Then
    CreateObject("Shell.Application").ShellExecute DOUBLE_QUOTES(WScript.FullName), DOUBLE_QUOTES(WScript.ScriptFullName) & " /elevate", "", "runas", 1
    WScript.Quit
End If

Call RENAME_THIS_PC()
Call CHANGE_DESCRIPTION_FOR_THIS_PC()

Sub RENAME_THIS_PC()
	Dim ERR, COL_COMPUTERS, OBJ_WMISERVICE, NEW_NAME, OBJ_COMPUTER
    Set OBJ_WMISERVICE = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & COMPUTER & "\root\cimv2")
    NEW_NAME = InputBox("PLEASE ENTER THE NEW NAME FOR THIS PC", TITLE, "")
    If NEW_NAME = "" Then Exit Sub
    Set COL_COMPUTERS = OBJ_WMISERVICE.ExecQuery("Select * from Win32_ComputerSystem")
    For Each OBJ_COMPUTER In COL_COMPUTERS
        ERR = OBJ_COMPUTER.Rename(NEW_NAME)
    Next
End Sub

Sub CHANGE_DESCRIPTION_FOR_THIS_PC()
	Dim X, OBJ, DESCRIPTION
    DESCRIPTION = InputBox("PLEASE ENTER DESCRIPTION", TITLE, "Have a nice day :)")
    If DESCRIPTION = "" Then Exit Sub
    Set OBJ = GetObject("winmgmts:\\" & COMPUTER).InstancesOf("Win32_OperatingSystem")
    For Each X In OBJ
        X.Description = DESCRIPTION
        X.Put_
    Next
End Sub
