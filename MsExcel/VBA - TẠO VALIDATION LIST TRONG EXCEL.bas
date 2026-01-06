
LỆNH EXCEL VBA -> TẠO VALIDATION LIST TRONG EXCEL

    Private Sub CREATE_VALIDATION(zRange As Range, DATA As String, TIEU_DE_THONG_BAO_ERROR As String, NOI_DUNG_THONG_BAO_ERROR As String)
        If Trim(DATA) = "" Then
            zRange.Validation.Delete
            Exit Sub
        End If
        With zRange.Validation
            .Delete
            .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, Formula1:=DATA
            .ErrorTitle = TIEU_DE_THONG_BAO_ERROR
            .ErrorMessage = NOI_DUNG_THONG_BAO_ERROR
            .ShowInput = False
        End With
    End Sub
