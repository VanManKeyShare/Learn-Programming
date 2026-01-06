
LỆNH EXCEL VBA -> GET FOLDER

    Sub SHOW_GET_FOLDER()
        MsgBox GET_FOLDER("C:\"), , "Message"
    End Sub

    Public Function GET_FOLDER(IniFolder As String) As String
        Dim FileDl As FileDialog
        Dim zITEM As String
        Set FileDl = Application.FileDialog(msoFileDialogFolderPicker)
        With FileDl
            .Title = "Please Choose Folder"
            .AllowMultiSelect = False
            .InitialFileName = IniFolder
            If .Show <> -1 Then GoTo NEXT_CODE
            zITEM = .SelectedItems(1)
        End With
    NEXT_CODE:
        GET_FOLDER = zITEM
        Set FileDl = Nothing
    End Function
