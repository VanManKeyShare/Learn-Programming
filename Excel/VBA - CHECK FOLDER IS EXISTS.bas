
LỆNH EXCEL VBA -> CHECK FOLDER IS EXISTS

    Function CHECK_FOLDER_IS_EXISTS(sFolderName As String) As Boolean
        Dim oFSO As Object
        Set oFSO = CreateObject("Scripting.FileSystemObject")
        CHECK_FOLDER_IS_EXISTS = oFSO.FolderExists(sFolderName)
    End Function
