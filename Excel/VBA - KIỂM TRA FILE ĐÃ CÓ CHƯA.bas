
LỆNH EXCEL VBA -> KIỂM TRA FILE ĐÃ CÓ CHƯA

    Function Check_File_Is_EXISTS(sFileName As String) As Boolean
        Dim oFSO As Object
        Set oFSO = CreateObject("Scripting.FileSystemObject")
        Check_File_Is_EXISTS = oFSO.fileExists(sFileName)
    End Function
