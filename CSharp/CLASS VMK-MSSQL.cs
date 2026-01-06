
// CSHARP - C# -> CLASS VMK MSSQL -> Version 2.4

#region --- EXAMPLE - SELECT ---
/*** EXAMPLE - SELECT

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = @"SELECT [ID], [NAME], [ADDRESS], [IMAGE] FROM [TEST] WHERE ([NAME] = @NAME)";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS;
    DT_PARAMETERS.Rows.Add("@NAME", "AAA", SqlDbType.NVarChar);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.SELECT();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    DataTable DT_RESULT = (DataTable)MSSQL_RESULT[2];

***/
#endregion

#region --- EXAMPLE - INSERT ---
/*** EXAMPLE - INSERT

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = "INSERT INTO [TEST] ([NAME], [ADDRESS]) VALUES (@NAME, @ADDRESS)";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS;
    DT_PARAMETERS.Rows.Add("@NAME", "AAA", SqlDbType.NVarChar);
    DT_PARAMETERS.Rows.Add("@ADDRESS", "111", SqlDbType.NVarChar);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.INSERT_DELETE_UPDATE();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    int MSSQL_STATUS = (int)MSSQL_RESULT[2];

    Response.Write("<!--" + MSSQL_STATUS.ToString() + "-->");

***/
#endregion

#region --- EXAMPLE - INSERT RETURN OUTPUT STRING ---
/*** EXAMPLE - INSERT RETURN OUTPUT STRING

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = "INSERT INTO [TEST] ([NAME], [ADDRESS]) OUTPUT INSERTED.[ID] VALUES (@NAME, @ADDRESS)";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS;
    DT_PARAMETERS.Rows.Add("@NAME", "BBB", SqlDbType.NVarChar);
    DT_PARAMETERS.Rows.Add("@ADDRESS", "333", SqlDbType.NVarChar);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.INSERT_RETURN_OUTPUT_STRING();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    string DATA_OUTPUT = MSSQL_RESULT[2].ToString();

    Response.Write("<!--" + DATA_OUTPUT + "-->");

***/
#endregion

#region --- EXAMPLE - DELETE ---
/*** EXAMPLE - DELETE

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = "DELETE FROM [TEST] WHERE [NAME] = @NAME";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS;
    DT_PARAMETERS.Rows.Add("@NAME", "AAA", SqlDbType.NVarChar);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.INSERT_DELETE_UPDATE();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    int MSSQL_STATUS = (int)MSSQL_RESULT[2];

    Response.Write("<!--" + MSSQL_STATUS.ToString() + "-->");

***/
#endregion

#region --- EXAMPLE - UPDATE ---
/*** EXAMPLE - UPDATE

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = "UPDATE [TEST] SET [ADDRESS] = @ADDRESS WHERE [NAME] = @NAME";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS;
    DT_PARAMETERS.Rows.Add("@NAME", "AAA", SqlDbType.NVarChar);
    DT_PARAMETERS.Rows.Add("@ADDRESS", "222", SqlDbType.NVarChar);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.INSERT_DELETE_UPDATE();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    int MSSQL_STATUS = (int)MSSQL_RESULT[2];

    Response.Write("<!--" + MSSQL_STATUS.ToString() + "-->");

***/
#endregion

#region --- EXAMPLE - INSERT / UPDATE - VarBinary ---
/*** EXAMPLE - INSERT / UPDATE - VarBinary

    string TEMP_FILE = Server.MapPath("~/ABC.JPG");

    // ĐỌC FILE LƯU VÀO BIẾN

    byte[] IMG_FILE;
    using (var Fs = new FileStream(TEMP_FILE, FileMode.Open, FileAccess.Read))
    {
        using (var BReader = new BinaryReader(Fs))
        {
            IMG_FILE = BReader.ReadBytes((int)Fs.Length);
        }
    }

    // LƯU DỮ LIỆU TỪ BIẾN VÀO CSDL

    VMK_MSSQL MSSQL = new VMK_MSSQL();
    MSSQL.MSSQL_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

    MSSQL.QUERY = "UPDATE [TEST] SET [IMAGE] = @IMAGE WHERE (NAME = @NAME)";

    DataTable DT_PARAMETERS = MSSQL.PARAMETERS_FOR_VARBINARY;
    DT_PARAMETERS.Rows.Add("@NAME", "AAA", SqlDbType.NVarChar, "AAA".Length);
    DT_PARAMETERS.Rows.Add("@IMAGE", IMG_FILE, SqlDbType.VarBinary, IMG_FILE.Length);
    MSSQL.PARAMETERS = DT_PARAMETERS;

    object[] MSSQL_RESULT = MSSQL.INSERT_UPDATE_FOR_VARBINARY();
    if ((int)MSSQL_RESULT[0] == 1)
    {
        Exception Exc = (Exception)MSSQL_RESULT[1];
        Response.Write("<!--" + Exc.ToString() + "-->");
        return;
    }
    int MSSQL_STATUS = (int)MSSQL_RESULT[2];

    Response.Write("<!--" + MSSQL_STATUS.ToString() + "-->");

***/
#endregion

using System;
using System.Data;
using System.Data.SqlClient;

namespace MMManager
{
    public class VMK_MSSQL
    {
        public readonly string Version = "2.4";

        public string QUERY;
        public DataTable PARAMETERS;
        public DataTable PARAMETERS_FOR_VARBINARY;
        public string MSSQL_CONNECTION_STRING;

        public DataTable CREATE_PARAMETERS()
        {
            DataTable DT = new DataTable();
            DT.Columns.Add("KEY", typeof(String));
            DT.Columns.Add("VALUE", typeof(String));
            DT.Columns.Add("DATA_TYPE", typeof(int));
            return DT;
        }

        public DataTable CREATE_PARAMETERS_FOR_VARBINARY()
        {
            DataTable DT = new DataTable();
            DT.Columns.Add("KEY", typeof(string));
            DT.Columns.Add("VALUE", typeof(object));
            DT.Columns.Add("DATA_TYPE", typeof(int));
            DT.Columns.Add("LENGTH", typeof(int));
            return DT;
        }

        public VMK_MSSQL()
        {
            PARAMETERS = CREATE_PARAMETERS();
            PARAMETERS_FOR_VARBINARY = CREATE_PARAMETERS_FOR_VARBINARY();
        }

        public object[] SELECT()
        {
            object[] VMK_RETURN = new object[3];

            int VMK_STATUS_ERROR = 0;
            Exception VMK_EXCEP = null;
            DataTable VMK_DATA_TABLE = null;

            // CÂU LỆNH KẾT NỐI CSDL

            string VMK_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

            try
            {
                SqlConnection VMK_DATABASE_CONN = new SqlConnection(VMK_CONNECTION_STRING);
                VMK_DATABASE_CONN.Open();

                // CÂU LỆNH TRUY VẤN CSDL

                SqlCommand VMK_SQL_COMMAND = new SqlCommand(QUERY, VMK_DATABASE_CONN);
                VMK_SQL_COMMAND.Parameters.Clear();

                for (int i = 0; i < PARAMETERS.Rows.Count; i++)
                {
                    VMK_SQL_COMMAND.Parameters.Add(new SqlParameter(PARAMETERS.Rows[i][0].ToString(), PARAMETERS.Rows[i][2]));
                    VMK_SQL_COMMAND.Parameters[PARAMETERS.Rows[i][0].ToString()].Value = PARAMETERS.Rows[i][1];
                }

                SqlDataReader VMK_SQL_DATA_READER = VMK_SQL_COMMAND.ExecuteReader();

                // LẤY DỮ LIỆU TRẢ VỀ TỪ CÂU LỆNH TRUY VẤN ĐƯA VÀO ĐỐI TƯỢNG DATA TABLE

                VMK_DATA_TABLE = new DataTable();
                VMK_DATA_TABLE.Load(VMK_SQL_DATA_READER);

                // ĐÓNG KẾT NỐI CSDL

                VMK_DATABASE_CONN.Close();
            }
            catch (Exception Exc)
            {
                if (Exc != null) { VMK_STATUS_ERROR = 1; VMK_EXCEP = Exc; }
            }

            VMK_RETURN[0] = VMK_STATUS_ERROR;
            VMK_RETURN[1] = VMK_EXCEP;
            VMK_RETURN[2] = VMK_DATA_TABLE;

            return VMK_RETURN;
        }

        public object[] INSERT_DELETE_UPDATE()
        {
            object[] VMK_RETURN = new object[3];

            int VMK_STATUS_ERROR = 0;
            Exception VMK_EXCEP = null;
            int VMK_SQL_COMMAND_STATUS = 0;

            // CÂU LỆNH KẾT NỐI CSDL

            string VMK_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

            try
            {
                SqlConnection VMK_DATABASE_CONN = new SqlConnection(VMK_CONNECTION_STRING);
                VMK_DATABASE_CONN.Open();

                // CÂU LỆNH TRUY VẤN CSDL

                SqlCommand VMK_SQL_COMMAND = new SqlCommand(QUERY, VMK_DATABASE_CONN);
                VMK_SQL_COMMAND.Parameters.Clear();

                for (int i = 0; i < PARAMETERS.Rows.Count; i++)
                {
                    VMK_SQL_COMMAND.Parameters.Add(new SqlParameter(PARAMETERS.Rows[i][0].ToString(), PARAMETERS.Rows[i][2]));
                    VMK_SQL_COMMAND.Parameters[PARAMETERS.Rows[i][0].ToString()].Value = PARAMETERS.Rows[i][1];
                }

                VMK_SQL_COMMAND_STATUS = VMK_SQL_COMMAND.ExecuteNonQuery();

                // ĐÓNG KẾT NỐI CSDL

                VMK_DATABASE_CONN.Close();
            }
            catch (Exception Ex)
            {
                if (Ex != null) { VMK_STATUS_ERROR = 1; VMK_EXCEP = Ex; }
            }

            VMK_RETURN[0] = VMK_STATUS_ERROR;
            VMK_RETURN[1] = VMK_EXCEP;
            VMK_RETURN[2] = VMK_SQL_COMMAND_STATUS;

            return VMK_RETURN;
        }

        public object[] INSERT_RETURN_OUTPUT_STRING()
        {
            object[] VMK_RETURN = new object[3];

            int VMK_STATUS_ERROR = 0;
            Exception VMK_EXCEP = null;
            string VMK_SQL_COMMAND_OUTPUT = "";

            // CÂU LỆNH KẾT NỐI CSDL

            string VMK_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

            try
            {
                SqlConnection VMK_DATABASE_CONN = new SqlConnection(VMK_CONNECTION_STRING);
                VMK_DATABASE_CONN.Open();

                // CÂU LỆNH TRUY VẤN CSDL

                SqlCommand VMK_SQL_COMMAND = new SqlCommand(QUERY, VMK_DATABASE_CONN);
                VMK_SQL_COMMAND.Parameters.Clear();

                for (int i = 0; i < PARAMETERS.Rows.Count; i++)
                {
                    VMK_SQL_COMMAND.Parameters.Add(new SqlParameter(PARAMETERS.Rows[i][0].ToString(), PARAMETERS.Rows[i][2]));
                    VMK_SQL_COMMAND.Parameters[PARAMETERS.Rows[i][0].ToString()].Value = PARAMETERS.Rows[i][1];
                }

                VMK_SQL_COMMAND_OUTPUT = Convert.ToString(VMK_SQL_COMMAND.ExecuteScalar());

                // ĐÓNG KẾT NỐI CSDL

                VMK_DATABASE_CONN.Close();
            }
            catch (Exception Exc)
            {
                if (Exc != null) { VMK_STATUS_ERROR = 1; VMK_EXCEP = Exc; }
            }

            VMK_RETURN[0] = VMK_STATUS_ERROR;
            VMK_RETURN[1] = VMK_EXCEP;
            VMK_RETURN[2] = VMK_SQL_COMMAND_OUTPUT;

            return VMK_RETURN;
        }

        public object[] INSERT_UPDATE_FOR_VARBINARY()
        {
            object[] VMK_RETURN = new object[3];

            int VMK_STATUS_ERROR = 0;
            Exception VMK_EXCEP = null;
            int VMK_SQL_COMMAND_STATUS = 0;

            // CÂU LỆNH KẾT NỐI CSDL

            string VMK_CONNECTION_STRING = this.MSSQL_CONNECTION_STRING;

            try
            {
                SqlConnection VMK_DATABASE_CONN = new SqlConnection(VMK_CONNECTION_STRING);
                VMK_DATABASE_CONN.Open();

                // CÂU LỆNH TRUY VẤN CSDL

                SqlCommand VMK_SQL_COMMAND = new SqlCommand(QUERY, VMK_DATABASE_CONN);
                VMK_SQL_COMMAND.Parameters.Clear();

                for (int i = 0; i < PARAMETERS.Rows.Count; i++)
                {
                    VMK_SQL_COMMAND.Parameters.Add(
                        new SqlParameter(
                            PARAMETERS.Rows[i][0].ToString(),
                            (SqlDbType)PARAMETERS.Rows[i][2],
                            (int)PARAMETERS.Rows[i][3]
                        )
                    ).Value = PARAMETERS.Rows[i][1];
                }

                VMK_SQL_COMMAND_STATUS = VMK_SQL_COMMAND.ExecuteNonQuery();

                // ĐÓNG KẾT NỐI CSDL

                VMK_DATABASE_CONN.Close();
            }
            catch (Exception Ex)
            {
                if (Ex != null) { VMK_STATUS_ERROR = 1; VMK_EXCEP = Ex; }
            }

            VMK_RETURN[0] = VMK_STATUS_ERROR;
            VMK_RETURN[1] = VMK_EXCEP;
            VMK_RETURN[2] = VMK_SQL_COMMAND_STATUS;

            return VMK_RETURN;
        }
    }
}
