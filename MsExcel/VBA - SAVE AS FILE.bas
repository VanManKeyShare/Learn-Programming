
''' LỆNH EXCEL VBA -> SHOW SAVE AS FILE

    Sub SHOW_SAVE_AS_FILE()
        Const iniDir As String = "C:\"
        Dim ShowSaveAsFile As Variant
        ShowSaveAsFile = Application.GetSaveAsFilename( _
            FileFilter:="Excel Files, *.xls;*.xlsx", _
            Title:="Save As", _
            InitialFileName:=iniDir _
        )
        If ShowSaveAsFile <> False Then
            MsgBox ShowSaveAsFile, , "Message"
        End If
    End Sub
