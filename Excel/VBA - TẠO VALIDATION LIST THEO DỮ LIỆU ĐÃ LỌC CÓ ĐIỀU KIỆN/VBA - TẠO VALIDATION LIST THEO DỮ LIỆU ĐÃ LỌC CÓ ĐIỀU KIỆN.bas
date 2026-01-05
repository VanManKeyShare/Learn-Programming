
LỆNH EXCEL VBA -> TẠO VALIDATION LIST THEO DỮ LIỆU ĐÃ LỌC CÓ ĐIỀU KIỆN

	''' NHẬP LỆNH TRONG SHEET B '''

    Option Explicit

    Const TEN_SHEET_A = "A"
    Const VUNG_DU_LIEU_MA_DON_HANG_TRONG_SHEET_A As String = "A2:A15"
    Const COT_MA_VAT_TU_TRONG_SHEET_A As String = "B"

    Const VUNG_DU_LIEU_MA_DON_HANG_TRONG_SHEET_B As String = "A2:A15"
    Const COT_MA_VAT_TU_TRONG_SHEET_B As String = "B"

    Private Sub Worksheet_Change(ByVal Target As Range)
        'On Error Resume Next
        If Not Intersect(Target, Range(VUNG_DU_LIEU_MA_DON_HANG_TRONG_SHEET_B)) Is Nothing Then
            If Target.Value = vbEmpty Or Target.Value = "" Then
                Range(COT_MA_VAT_TU_TRONG_SHEET_B & Target.Row).ClearContents
                Range(COT_MA_VAT_TU_TRONG_SHEET_B & Target.Row).Validation.Delete
            Else
                If Trim(Target.Value) <> "" Then
                    Dim DANH_SACH_MA_VAT_TU As String
                    Dim MA_DON_HANG As String
                    Dim zRANGE As Range
                    
                    ''' LAY MA DON HANG '''
                    MA_DON_HANG = Trim(Target.Value)
                    
                    ''' TAO DANH SACH MA VAT TU TRONG SHEET A THEO MA DON HANG '''
                    DANH_SACH_MA_VAT_TU = CREATE_DANH_SACH_MA_VAT_TU(MA_DON_HANG)
                    
                    ''' TAO VALIDATION CHO COT MA VAT TU '''
                    Set zRANGE = Range(COT_MA_VAT_TU_TRONG_SHEET_B & Target.Row)
                    Call CREATE_VALIDATION(zRANGE, DANH_SACH_MA_VAT_TU)
                End If
            End If
        End If
    End Sub

    Function CREATE_DANH_SACH_MA_VAT_TU(MA_DON_HANG As String) As String
        Dim DS_MA_VAT_TU As String: DS_MA_VAT_TU = ""
        Dim MA_VAT_TU_TEMP As String
        Dim zCell As Range
        For Each zCell In Worksheets(TEN_SHEET_A).Range(VUNG_DU_LIEU_MA_DON_HANG_TRONG_SHEET_A)
            If Trim(zCell.Value) <> "" Then
                If Trim(zCell.Value) = Trim(MA_DON_HANG) Then
                    MA_VAT_TU_TEMP = Trim(Worksheets(TEN_SHEET_A).Range(COT_MA_VAT_TU_TRONG_SHEET_A & zCell.Row).Value)
                    If DS_MA_VAT_TU = "" Then
                        DS_MA_VAT_TU = MA_VAT_TU_TEMP
                    Else
                        DS_MA_VAT_TU = DS_MA_VAT_TU & "," & MA_VAT_TU_TEMP
                    End If
                End If
            Else
                Exit For
            End If
        Next
        CREATE_DANH_SACH_MA_VAT_TU = DS_MA_VAT_TU
    End Function

    Private Sub CREATE_VALIDATION(zRANGE As Range, DATA As String)
        If Trim(DATA) = "" Then
            zRANGE.Validation.Delete
            Exit Sub
        End If
        With zRANGE.Validation
            .Delete
            .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, Formula1:=DATA
            .ErrorTitle = "THÔNG BÁO"
            .ErrorMessage = "YOUR DATA INPUT IS NOT VALID"
            .ShowInput = False
        End With
    End Sub
