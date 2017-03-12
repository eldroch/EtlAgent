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
    public partial class FieldConsole : Form
    {
        public FieldConsole(DataTable dt, string TableName, string TableSchema, string EnvironmentName, string ControlDbName)
        {
            InitializeComponent();
            txt_Environment.Text = EnvironmentName;
            txt_TableName.Text = TableName;
            txt_TableSchema.Text = TableSchema;
            txt_ControlDbName.Text = ControlDbName;

            foreach (DataColumn col in dt.Columns)
                col.ReadOnly = false;
            dataGridView1.DataSource = dt;
            dataGridView1.AutoSizeRowsMode =
                DataGridViewAutoSizeRowsMode.DisplayedCellsExceptHeaders;
            
            dataGridView1.BorderStyle = BorderStyle.Fixed3D;
            
            dataGridView1.EditMode = DataGridViewEditMode.EditOnEnter;
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

        private void btn_Done_Click(object sender, EventArgs e)
        {

            DataTable dt = (DataTable)(dataGridView1.DataSource);
            using (var cn = new SqlConnection("Server=ETL2014;Database=" + txt_ControlDbName.Text + ";User Id=etl_sa;Password=etl!;"))
            {
                cn.Open();
                try
                {
                    var cmd = new SqlCommand("ctrl.LoadColumnData") { CommandType = CommandType.StoredProcedure };
                    cmd.Connection = cn;
                    cmd.Parameters.Add(new SqlParameter("@colData", dt));
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException sql_e)
                {
                    MessageBox.Show(e.ToString());
                    MessageBox.Show(sql_e.ToString());
                }
            }
        }

        private void btn_Cancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
