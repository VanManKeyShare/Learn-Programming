
''' VBSCRIPT -> ALLOWS USER TO SELECT A FOLDER AND RETURNS THE PATH

    Msgbox BrowseForFolder()

    Function BrowseForFolder()
        Dim oShell, oFolder

        Dim BIF_NONEWFOLDERBUTTON
        Dim SSFDESKTOP
        
        BIF_NONEWFOLDERBUTTON = &H00000200
        SSFDESKTOP = &H00

        Set oShell = CreateObject("Shell.Application")
        Set oFolder = oShell.BrowseForFolder(0, "PLEASE SELECT THE DESTINATION FOLDER", BIF_NONEWFOLDERBUTTON, SSFDESKTOP)
        If oFolder Is Nothing Then
            BrowseForFolder = ""
        Else
            BrowseForFolder = oFolder.self.path
        End If
        Set oFolder = nothing
        Set oShell = nothing
    End Function
