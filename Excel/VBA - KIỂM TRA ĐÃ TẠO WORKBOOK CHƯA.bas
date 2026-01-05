
LỆNH EXCEL VBA -> KIỂM TRA ĐÃ TẠO WORKBOOK CHƯA

    Public Function Check_WorkBook_Is_Ready(Optional Show_Error As Boolean = True) As Boolean
        On Error Resume Next
        Dim WS As Worksheet
        Set WS = Sheets
        If Err.Number = 1004 Then
            If Show_Error = True Then MsgBox "PLEASE CREATE WORKBOOK", , "THÔNG BÁO"
            Check_WorkBook_Is_Ready = False
        Else
            Check_WorkBook_Is_Ready = True
        End If
    End Function
