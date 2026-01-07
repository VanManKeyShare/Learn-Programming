
''' VBSCRIPT -> CHECK ADMINISTRATOR PERMISSIONS

    Option Explicit
    On Error Resume Next

    Dim Check_Admin
    Check_Admin = WSShell.RegRead("HKU\S-1-5-19\")

    If err.number <> 0 Then
        Msgbox "PLEASE RUN THIS FILE AS ADMINISTRATOR",,"Hello"
        WScript.Quit
    End if

    Msgbox "RUN AS ADMINISTRATOR PERMISSIONS SUCCESS",,"Hello"
