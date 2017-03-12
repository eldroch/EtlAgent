using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Data.Odbc;


namespace EtlAgent
{
    public partial class frm_CreateETL : Form
    {
        public frm_CreateETL()
        {
            InitializeComponent();
        }        

        private void frm_CreateETL_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'eTL_EnvironmentDataSet.ETL_Environments_Dim' table. You can move, or remove it, as needed.
            this.eTL_Environments_DimTableAdapter.Fill(this.eTL_EnvironmentDataSet.ETL_Environments_Dim);

        }

        public DataTable GetSqlResults(string sql, string conn)
        {
            DataTable dt = new DataTable();
            
            using (var cn = new SqlConnection(conn))
            {
                cn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand(sql, cn);
                    dt.Load(cmd.ExecuteReader());
                }
                catch (SqlException e)
                {
                    MessageBox.Show(e.ToString());
                }
            }
            return dt;
        }

        public DataTable GetOdbcResults(string sql, string conn)
        {
            DataTable dt = new DataTable();

            using (var cn = new OdbcConnection(conn))
            {
                cn.Open();
                try
                {
                    OdbcCommand cmd = new OdbcCommand(sql, cn);
                    dt.Load(cmd.ExecuteReader());
                }
                catch (SqlException e)
                {
                    MessageBox.Show(e.ToString());
                }
            }
            return dt;
        }

        private void cmb_DataSource_DropDown(object sender, EventArgs e)
        {
            DataTable dt_DataSources = GetSqlResults("SELECT DataSourceSK, DataSourceName FROM ctrl.ETL_DataSources_Dim", "Server=CRASH;Database=" + cmb_Environment.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!;");
            cmb_DataSource.DataSource = dt_DataSources;
            cmb_DataSource.ValueMember = "DataSourceSK";
            cmb_DataSource.DisplayMember = "DataSourceName";
        }

        private void cmb_Tables_DropDown(object sender, EventArgs e)
        {
            DataTable dt_DataSourceInfo = GetSqlResults("SELECT DriverString, HostString, DbString, LoginString, PasswordString, DataSourceTypeName FROM ctrl.ETL_DataSources_Dim ds INNER JOIN ctrl.ETL_DataSourceTypes_Dim dst ON ds.DataSourceTypeSK = dst.DataSourceTypeSK WHERE DataSourceSK = " + cmb_DataSource.SelectedValue.ToString(), "Server=CRASH;Database=" + cmb_Environment.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!; ");
            
            string driverString = "";
            string hostString = "";
            string dbString = "";
            string loginString = "";
            string passString = "";
            string dsTypeName = "";

            foreach (DataRow dr in dt_DataSourceInfo.Rows)
            {
                driverString = dr["DriverString"].ToString();
                hostString = dr["HostString"].ToString();
                dbString = dr["DbString"].ToString();
                loginString = dr["LoginString"].ToString();
                passString = dr["PasswordString"].ToString();
                dsTypeName = dr["DataSourceTypeName"].ToString();
            }

            

            if (dsTypeName == "MySQL")
            {
                DataTable dt_Tables = GetOdbcResults("SELECT CONCAT(TABLE_SCHEMA,'.', TABLE_NAME) TableName FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_SCHEMA, TABLE_NAME",
                                                "Driver=" + driverString
                                              + ";Server=" + hostString
                                              + ";Database=" + dbString
                                              + ";Uid=" + loginString
                                              + ";Pwd=" + passString + ";");
                cmb_Tables.DataSource = dt_Tables;
                cmb_Tables.ValueMember = "TableName";
                cmb_Tables.DisplayMember = "TableName";
            }
            else if (dsTypeName == "Postgres")
            {
                DataTable dt_Tables = GetOdbcResults("SELECT TABLE_SCHEMA || '.' || TABLE_NAME TableName FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_SCHEMA, TABLE_NAME",
                                                "Driver=" + driverString
                                              + ";Server=" + hostString
                                              + ";Database=" + dbString
                                              + ";Uid=" + loginString
                                              + ";Pwd=" + passString + ";");
                cmb_Tables.DataSource = dt_Tables;
                cmb_Tables.ValueMember = "TableName";
                cmb_Tables.DisplayMember = "TableName";
            }
            else
            {
                DataTable dt_Tables = GetOdbcResults("SELECT TABLE_SCHEMA + '.' + TABLE_NAME TableName FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_SCHEMA, TABLE_NAME",
                                                "Driver=" + driverString
                                              + ";Server=" + hostString
                                              + ";Database=" + dbString
                                              + ";Uid=" + loginString
                                              + ";Pwd=" + passString + ";");
                cmb_Tables.DataSource = dt_Tables;
                cmb_Tables.ValueMember = "TableName";
                cmb_Tables.DisplayMember = "TableName";
            }

                        
            
        }

        private void cmb_Tables_SelectionChangeCommitted(object sender, EventArgs e)
        {
            
           
        }

        private void chk_DeleteTracking_CheckedChanged(object sender, EventArgs e)
        {
            if (chk_DeleteTracking.Checked == true)
            {
                cmb_DeleteHandling.Enabled = true;
                cmb_DeleteHandling.Text = "Flag";
            }
            else
            {
                cmb_DeleteHandling.Enabled = false;
                cmb_DeleteHandling.Text = "";
            }
        }

        private void btn_Next_Click(object sender, EventArgs e)
        {
            SqlConnection cn = new SqlConnection("Server=ETL2014;Database=" + cmb_Environment.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!;");
            string TableName = txt_TableName.Text;
            string TableSchema = txt_SchemaName.Text;
            string SrcObjectName = cmb_Tables.Text.Substring(cmb_Tables.Text.IndexOf(".") + 1);
            string SrcSchemaName = cmb_Tables.Text.Substring(0, cmb_Tables.Text.IndexOf("."));
            string DataSourceSK = cmb_DataSource.SelectedValue.ToString();
            string LoadFrequency = cmb_LoadFrequency.Text;
            string TableType = "Src";
            string LoadType = cmb_LoadType.Text;
            string ExtractType = cmb_ExtractType.Text;
            string CustomReplicationFlag = (chk_CustomReplication.Checked ? "Y" : "N");
            string DeleteTrackingFlag = (chk_DeleteTracking.Checked ? "Y" : "N");
            string DeleteHandling = (cmb_DeleteHandling.Text == null ? "" : cmb_DeleteHandling.Text);
            string IDTrackingFlag = (chk_IdTracking.Checked ? "Y" : "N");

            string sql_AddTableEntry = "INSERT INTO ctrl.ETL_Tables_Dim "
                                     + "( "
                                     + "[TableName] "
                                     + ",[TableSchema] "
                                     + ",[SrcObjectName] "
                                     + ",[SrcSchemaName] "
                                     + ",[DataSourceSK] "
                                     + ",[LoadFrequency] "
                                     + ",[TableType] "
                                     + ",[LoadType] "
                                     + ",[ExtractType] "
                                     + ",[CustomReplicationFlag] "
                                     + ",[DeleteTrackingFlag] "
                                     + ",[DeleteHandling] "
                                     + ",[IDTrackingFlag] "
                                     + ") "
                                     + "VALUES "
                                     + "( "
                                     + "  '" + TableName + "' "
                                     + ", '" + TableSchema + "' "
                                     + ", '" + SrcObjectName + "' "
                                     + ", '" + SrcSchemaName + "' "
                                     + ", '" + DataSourceSK + "' "
                                     + ", '" + LoadFrequency + "' "
                                     + ", '" + TableType + "' "
                                     + ", '" + LoadType + "' "
                                     + ", '" + ExtractType + "' "
                                     + ", '" + CustomReplicationFlag + "' "
                                     + ", '" + DeleteTrackingFlag + "' "
                                     + ", NULLIF('" + DeleteHandling + "', '') "
                                     + ", '" + IDTrackingFlag + "' "
                                     + ")";
            SqlCommand cmd = new SqlCommand(sql_AddTableEntry, cn);
            string TableSk = "";
            string sql_getTableSk = "SELECT TableSK FROM ctrl.ETL_Tables_Dim WHERE TableName = '" + TableName + "' AND TableSchema = '" + TableSchema + "'";
            SqlCommand cmd_getTableSk = new SqlCommand(sql_getTableSk, cn);

            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException sql_e)
            {
                MessageBox.Show(e.ToString());
                MessageBox.Show(sql_e.ToString());
            }

            try
            {
                cn.Open();
                TableSk = cmd_getTableSk.ExecuteScalar().ToString();
                cn.Close();
            }
            catch (SqlException sql_e)
            {
                MessageBox.Show(e.ToString());
                MessageBox.Show(sql_e.ToString());
            }

            DataTable dt_DataSourceInfo = GetSqlResults("SELECT DriverString, HostString, DbString, LoginString, PasswordString, DataSourceTypeName FROM ctrl.ETL_DataSources_Dim ds INNER JOIN ctrl.ETL_DataSourceTypes_Dim dst ON ds.DataSourceTypeSK = dst.DataSourceTypeSK WHERE DataSourceSK = " + cmb_DataSource.SelectedValue.ToString(), "Server=CRASH;Database=" + cmb_Environment.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!; ");

            string driverString = "";
            string hostString = "";
            string dbString = "";
            string loginString = "";
            string passString = "";
            string dsTypeName = "";
            string sql = "";
            foreach (DataRow dr in dt_DataSourceInfo.Rows)
            {
                driverString = dr["DriverString"].ToString();
                hostString = dr["HostString"].ToString();
                dbString = dr["DbString"].ToString();
                loginString = dr["LoginString"].ToString();
                passString = dr["PasswordString"].ToString();
                dsTypeName = dr["DataSourceTypeName"].ToString();
            }

            if (dsTypeName == "MySQL")
            {
                sql = "SELECT '" + TableSk + "' TableSK"
                       + ", col.COLUMN_NAME ColumnName "
                       + ", NULL SourceCodeSetName "
                       + ", col.DATA_TYPE DataType "
                       + ", CASE WHEN COLUMN_KEY = 'PRI' THEN 'Y' ELSE 'N' END PKFlag "
                       + ", COALESCE(CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION) ColumnMaxLength "
                       + ", NUMERIC_SCALE ColumnScale "
                       + ", ORDINAL_POSITION SequenceNumber "
                       + ", CASE WHEN IS_NULLABLE = 'NO' THEN 'N' ELSE 'Y' END ContainsNullsFlag "
                       + ", 'N' ContainsNonprintablesFlag "
                       + ", 'Y' CDCEnabledFlag "
                       + "FROM INFORMATION_SCHEMA.COLUMNS col "
                       + "WHERE TABLE_NAME = '" + SrcObjectName + "' "
                       + "AND TABLE_SCHEMA = '" + SrcSchemaName + "'";
            }
            else if (dsTypeName == "Postgres")
            {
                sql = "SELECT '" + TableSk + "' TableSK"
                           + ", col.COLUMN_NAME ColumnName "
                           + ", NULL SourceCodeSetName "
                           + ", col.DATA_TYPE DataType "
                           + ", CASE WHEN pks.COLUMN_NAME IS NOT NULL THEN 'Y' ELSE 'N' END PKFlag "
                           + ", COALESCE(CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION) ColumnMaxLength "
                           + ", NUMERIC_SCALE ColumnScale "
                           + ", ORDINAL_POSITION SequenceNumber "
                           + ", CASE WHEN IS_NULLABLE = 'NO' THEN 'N' ELSE 'Y' END ContainsNullsFlag "
                           + ", 'N' ContainsNonprintablesFlag "
                           + ", 'Y' CDCEnabledFlag "
                           + "FROM INFORMATION_SCHEMA.COLUMNS col "
                           + "LEFT JOIN "
                           + "( "
                           + "SELECT COLUMN_NAME "
                           + "FROM information_schema.table_constraints tc "
                           + "JOIN information_schema.constraint_column_usage AS ccu USING (constraint_schema, constraint_name) "
                           + "JOIN information_schema.columns AS c ON c.table_schema = tc.constraint_schema AND tc.table_name = c.table_name AND ccu.column_name = c.column_name " 
                           + "where constraint_type = 'PRIMARY KEY' and c.table_name = '" + SrcObjectName + "' AND c.table_schema = '" + SrcSchemaName + "' "
                           + ") pks ON col.COLUMN_NAME = pks.COLUMN_NAME "
                           + "WHERE TABLE_NAME = '" + SrcObjectName + "' "
                           + "AND TABLE_SCHEMA = '" + SrcSchemaName + "'";
            }
            else
            {
                sql = "SELECT '" + TableSk + "' TableSK"
                           + ", col.COLUMN_NAME ColumnName "
                           + ", NULL SourceCodeSetName "
                           + ", col.DATA_TYPE DataType "
                           + ", CASE WHEN pks.COLUMN_NAME IS NOT NULL THEN 'Y' ELSE 'N' END PKFlag "
                           + ", COALESCE(CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION) ColumnMaxLength "
                           + ", NUMERIC_SCALE ColumnScale "
                           + ", ORDINAL_POSITION SequenceNumber "
                           + ", CASE WHEN IS_NULLABLE = 'NO' THEN 'N' ELSE 'Y' END ContainsNullsFlag "
                           + ", 'N' ContainsNonprintablesFlag "
                           + ", 'Y' CDCEnabledFlag "
                           + "FROM INFORMATION_SCHEMA.COLUMNS col "
                           + "LEFT JOIN "
                           + "( "
                           + "SELECT COLUMN_NAME "
                           + "FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE "
                           + "WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME), 'IsPrimaryKey') = 1 "
                           + "AND TABLE_NAME = '" + SrcObjectName + "' AND TABLE_SCHEMA = '" + SrcSchemaName + "' "
                           + ") pks ON col.COLUMN_NAME = pks.COLUMN_NAME "
                           + "WHERE TABLE_NAME = '" + SrcObjectName + "' "
                           + "AND TABLE_SCHEMA = '" + SrcSchemaName + "'";
            }

            DataTable dt_Columns = GetOdbcResults(sql,
                                            "Driver=" + driverString
                                          + ";Server=" + hostString
                                          + ";Database=" + dbString
                                          + ";Uid=" + loginString
                                          + ";Pwd=" + passString + ";");
            FieldConsole m = new FieldConsole(dt_Columns, TableName, TableSchema, cmb_Environment.Text, cmb_Environment.SelectedValue.ToString());
            m.Show();
            

            
        }

        private void btn_Cancel_Click(object sender, EventArgs e)
        {
           Close();
        }

        private void cmb_Tables_SelectedValueChanged(object sender, EventArgs e)
        {
            DataTable dt_DataSourceInfo = GetSqlResults("SELECT AccessMethod, DefaultSchema FROM ctrl.ETL_DataSources_Dim WHERE DataSourceSK = " + cmb_DataSource.SelectedValue.ToString(), "Server=CRASH;Database=" + cmb_Environment.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!; ");
            string TableString = cmb_Tables.Text;

            foreach (DataRow dr in dt_DataSourceInfo.Rows)
            {
                cmb_ExtractType.Text = dr["AccessMethod"].ToString();
                if (dr["DefaultSchema"].ToString() == "")
                    txt_SchemaName.Text = TableString.Substring(0, TableString.IndexOf("."));
                else
                    txt_SchemaName.Text = dr["DefaultSchema"].ToString();
            }

            txt_TableName.Text = TableString.Substring(TableString.IndexOf(".") + 1);
            cmb_LoadFrequency.Text = "Daily";
            cmb_LoadType.Text = "Full";
            chk_CustomReplication.Checked = false;
            chk_IdTracking.Checked = false;
            chk_DeleteTracking.Checked = false;
        }
    }
}
