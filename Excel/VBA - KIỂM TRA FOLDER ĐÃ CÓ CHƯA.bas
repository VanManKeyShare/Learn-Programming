
LỆNH EXCEL VBA -> KIỂM TRA FOLDER ĐÃ CÓ CHƯA

    Function Check_Folder_Is_EXISTS(sFolderName As String) As Boolean
        Dim oFSO As Object
        Set oFSO = CreateObject("Scripting.FileSystemObject")
        Check_Folder_Is_EXISTS = oFSO.FolderExists(sFolderName)
    End Function
