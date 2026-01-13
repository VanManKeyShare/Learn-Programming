
''' VBA - MS WORD -> EXPORT PAGE TO PDF

Option Explicit

Sub EXPORT_PAGE_01_TO_PDF()

    Dim O As Document
    Dim File_Name As String
    Dim IniFileName as string

    Set O = ActiveDocument
    If InStrRev(O.Name, ".") <> 0 Then
        File_Name = Left(O.Name, InStrRev(O.Name, ".") - 1)
    Else
        File_Name = O.Name
    End If

    If File_Name = "" Then Exit Sub

    Const Page_From as integer = 1
    Const Page_To as integer = 1
    IniFileName = "C:\P1-" & File_Name

    Dim I As Integer
    Dim FDialog As FileDialog

    Set FDialog = Application.FileDialog(msoFileDialogSaveAs)
    FDialog.Title = "Publish as PDF"
    FDialog.InitialFileName = IniFileName
    For I = 1 To FDialog.Filters.Count
        If FDialog.Filters.Item(I).Description = "PDF" Then
            FDialog.FilterIndex = I
            Exit For
        End If
    Next I

    If FDialog.Show = -1 Then
        ActiveDocument.ExportAsFixedFormat OutputFileName:=FDialog.SelectedItems(1), _
            ExportFormat:=wdExportFormatPDF, OpenAfterExport:=True, OptimizeFor:= _
            wdExportOptimizeForPrint, Range:=wdExportFromTo, From:=Page_From, To:=Page_To, Item:= _
            wdExportDocumentContent, IncludeDocProps:=True, KeepIRM:=True, _
            CreateBookmarks:=wdExportCreateNoBookmarks, DocStructureTags:=True, _
            BitmapMissingFonts:=True, UseISO19005_1:=False
    End If

End Sub
