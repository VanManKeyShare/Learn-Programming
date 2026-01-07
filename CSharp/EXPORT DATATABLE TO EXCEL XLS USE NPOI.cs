
// CSharp - C# -> EXPORT DATATABLE TO EXCEL XLS USE NPOI

namespace EXPORT_DATATABLE_TO_EXCEL_XLS_USE_NPOI
{
	public string[] EXPORT_DATATABLE_TO_EXCEL_XLS_USE_NPOI(DataTable DTABLE, string SHEET_NAME, string FILE_EXCEL_XLS, bool EXPORT_HEADER = true, int Row_Begin = 1, int Column_Begin = 1)
	{
		/*  PLEASE NOTE FOR USE
			-------------------
			STEP 1 - DOWNLOAD NPOI FROM NPOI.CODEPLEX.COM/RELEASES
			STEP 2 - ADD REFERENCE NPOI.DLL TO VISUAL STUDIO
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
			string Excel_File = @"D:\DTable_Excel.xls";
			string[] STATUS = EXPORT_DATATABLE_TO_EXCEL_XLS_USE_NPOI(DTABLE, "SHEET 1", Excel_File, true, 2, 3);
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
		if (FILE_EXCEL_XLS.Trim() == "")
		{
			KQ[0] = "ERROR";
			KQ[1] = "BIẾN FILE EXCEL KHÔNG ĐƯỢC RỖNG";
			return KQ;
		}

		// XUẤT DATATABLE SANG EXCEL .XLS SỬ DỤNG NPOI

		try
		{
			NPOI.SS.UserModel.IWorkbook WorkBook;
			WorkBook = new NPOI.HSSF.UserModel.HSSFWorkbook();
			NPOI.SS.UserModel.ISheet SHEET = WorkBook.CreateSheet(SHEET_NAME.Trim());

			Row_Begin -= 1;
			Column_Begin -= 1;

			int Column_Begin_TEMP = Column_Begin;

			// TẠO TIÊU ĐỀ CỘT DỰA VÀO TIÊU ĐỀ CỘT CỦA DATATABLE

			if (EXPORT_HEADER == true)
			{
				Column_Begin_TEMP = Column_Begin;
				NPOI.SS.UserModel.IRow Row = SHEET.CreateRow(Row_Begin);
				for (int iCol = 0; iCol < DTABLE.Columns.Count; iCol++)
				{
					NPOI.SS.UserModel.ICell Cell = Row.CreateCell(Column_Begin_TEMP);
					string ColumnName = DTABLE.Columns[iCol].ToString();
					Cell.SetCellValue(ColumnName);
					Column_Begin_TEMP += 1;
				}
				Row_Begin += 1;
			}

			// TIẾN HÀNH XUẤT DỮ LIỆU CỦA DATATABLE

			for (int iRow = 0; iRow < DTABLE.Rows.Count; iRow++)
			{
				Column_Begin_TEMP = Column_Begin;
				NPOI.SS.UserModel.IRow Row = SHEET.CreateRow(Row_Begin);
				for (int iCol = 0; iCol < DTABLE.Columns.Count; iCol++)
				{
					NPOI.SS.UserModel.ICell Cell = Row.CreateCell(Column_Begin_TEMP);
					Cell.SetCellValue(DTABLE.Rows[iRow][iCol].ToString());
					Column_Begin_TEMP += 1;
				}
				Row_Begin += 1;
			}

			// TIẾN HÀNH LƯU FILE EXCEL

			System.IO.FileStream XFile = new System.IO.FileStream(FILE_EXCEL_XLS.Trim(), System.IO.FileMode.Create, System.IO.FileAccess.Write);
			WorkBook.Write(XFile);
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
