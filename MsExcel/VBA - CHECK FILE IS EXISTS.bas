
''' LỆNH EXCEL VBA -> CHECK FILE IS EXISTS

    Function CHECK_FILE_IS_EXISTS(sFileName As String) As Boolean
        Dim oFSO As Object
        Set oFSO = CreateObject("Scripting.FileSystemObject")
        CHECK_FILE_IS_EXISTS = oFSO.fileExists(sFileName)
    End Function
