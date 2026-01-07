
// CSharp - C# -> EXPORT DATATABLE TO EXCEL XLSX USE EPPLUS

namespace EXPORT_DATATABLE_TO_EXCEL_XLSX_USE_EPPLUSX
{
	public string[] EXPORT_DATATABLE_TO_EXCEL_XLSX_USE_EPPLUS(DataTable DTABLE, string SHEET_NAME, string FILE_EXCEL_XLSX, bool EXPORT_HEADER = true, int Row_Begin = 1, int Column_Begin = 1)
	{
		/*  PLEASE NOTE FOR USE
			-------------------
			STEP 1 - DOWNLOAD EPPLUS FROM EPPLUS.CODEPLEX.COM
			STEP 2 - ADD REFERENCE EPPLUS.DLL TO VISUAL STUDIO
			STEP 3 - SET COPY LOCAL = TRUE
			-------------------

			EXAMPLE FOR USE
			---------------
			DataTable DTABLE = new DataTable();
			DTABLE.Columns.Add("ID", typeof(string));
			DTABLE.Columns.Add("NAME", typeof(string));
			DTABLE.Rows.Add("1", "A");
			DTABLE.Rows.Add("2", "B");
			DTABLE.Rows.Add("3", "C");
			DTABLE.Rows.Add("4", "D");
			DTABLE.Rows.Add("5", "E");
			DTABLE.Rows.Add("6", "F");
			string Excel_File = @"D:\DTable_Excel.xlsx";
			string[] STATUS = EXPORT_DATATABLE_TO_EXCEL_XLSX_USE_EPPLUS(DTABLE, "SHEET 1", Excel_File, true, 2, 3);
			if (STATUS[0] == "ERROR") { MessageBox.Show(STATUS[1], "ALERT"); }
			if (STATUS[0] == "OK") { System.Diagnostics.Process.Start(Excel_File); }
			---------------
		*/

		string[] KQ = { "OK", "" };

		if (Row_Begin <= 0 || Column_Begin <= 0)
		{
			KQ[0] = "ERROR";
			KQ[1] = "REQUIRE ROW AND COLUMN BEGIN GREATER THAN 0";
			return KQ;
		}
		if (SHEET_NAME.Trim() == "")
		{
			KQ[0] = "ERROR";
			KQ[1] = "BIẾN SHEET NAME KHÔNG ĐƯỢC RỖNG";
			return KQ;
		}
		if (FILE_EXCEL_XLSX.Trim() == "")
		{
			KQ[0] = "ERROR";
			KQ[1] = "BIẾN FILE EXCEL KHÔNG ĐƯỢC RỖNG";
			return KQ;
		}

		// XUẤT DATATABLE SANG EXCEL .XLSX SỬ DỤNG EPPLUS

		try
		{
			System.IO.FileStream XFile = new System.IO.FileStream(FILE_EXCEL_XLSX.Trim(), System.IO.FileMode.Create, System.IO.FileAccess.Write);
			using (OfficeOpenXml.ExcelPackage ExPCK = new OfficeOpenXml.ExcelPackage(XFile))
			{
				OfficeOpenXml.ExcelWorksheet EWS = ExPCK.Workbook.Worksheets.Add(SHEET_NAME.Trim());
				EWS.Cells[Row_Begin, Column_Begin].LoadFromDataTable(DTABLE, EXPORT_HEADER);
				ExPCK.Save();
			}
			XFile.Close();
		}
		catch (Exception ex)
		{
			Console.WriteLine(ex.ToString());
			if (ex.Message.ToLower().IndexOf("the process cannot access the file") != -1 && ex.Message.ToLower().IndexOf("because it is being used by another process") != -1)
			{
				KQ[0] = "ERROR";
				KQ[1] = "KHÔNG THỂ GHI DỮ LIỆU. TẬP TIN BẠN CHỌN ĐANG ĐƯỢC SỬ DỤNG BỞI CHƯƠNG TRÌNH KHÁC";
			}
			else
			{
				KQ[0] = "ERROR";
				KQ[1] = ex.ToString();
			}
		}

		return KQ;
	}
}
