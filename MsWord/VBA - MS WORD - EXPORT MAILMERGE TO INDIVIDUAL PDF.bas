
''' LỆNH WORD VBA -> XUẤT MAIL MERGE RA TỪNG FILE PDF RIÊNG BIỆT VỚI TÊN FILE LÀ DỮ LIỆU TRONG MAIL MERGE

Option Explicit

Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As LongPtr)

Sub EXPORT_TO_PDF_ALL_RECORD_FROM_MAIL_MERGE_DATA()
    ActiveDocument.MailMerge.DataSource.ActiveRecord = wdFirstRecord
    Dim I As Integer
    For I = 1 To ActiveDocument.MailMerge.DataSource.RecordCount
        Sleep (1000)
        ActiveDocument.ExportAsFixedFormat OutputFileName:= _
            "D:\" & GET_GROUP_FROM_MAIL_MERGE_DATA() & " - " & GET_HOTEN_FROM_MAIL_MERGE_DATA() & ".PDF", _
            ExportFormat:=wdExportFormatPDF, OpenAfterExport:=False, OptimizeFor:= _
            wdExportOptimizeForPrint, Range:=wdExportAllDocument, From:=1, To:=1, _
            Item:=wdExportDocumentContent, IncludeDocProps:=True, KeepIRM:=True, _
            CreateBookmarks:=wdExportCreateNoBookmarks, DocStructureTags:=True, _
            BitmapMissingFonts:=True, UseISO19005_1:=False
        ActiveDocument.MailMerge.DataSource.ActiveRecord = wdNextRecord
    Next I
    MsgBox "Success", , "Thông báo"
End Sub

Function GET_HOTEN_FROM_MAIL_MERGE_DATA()
    Dim I As Long
    With ActiveDocument
    For I = 1 To .Fields.Count
        If InStr(.Fields(I).Code, "MERGEFIELD HO_TEN") > 0 Then
            GET_HOTEN_FROM_MAIL_MERGE_DATA = .Fields(I).Result
            Exit Function
        End If
    Next I
    End With
End Function

Function GET_GROUP_FROM_MAIL_MERGE_DATA()
    Dim I As Long
    With ActiveDocument
    For I = 1 To .Fields.Count
        If InStr(.Fields(I).Code, "MERGEFIELD GROUP") > 0 Then
            GET_GROUP_FROM_MAIL_MERGE_DATA = .Fields(I).Result
            Exit Function
        End If
    Next I
    End With
End Function
