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

namespace EtlAgent
{
    public partial class DsConsole : Form
    {
        public DsConsole()
        {
            InitializeComponent();
        }

        private void DsConsole_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'dataset_Environments.ETL_Environments_Dim' table. You can move, or remove it, as needed.
            this.eTL_Environments_DimTableAdapter.Fill(this.dataset_Environments.ETL_Environments_Dim);
            // TODO: This line of code loads data into the 'dataset_Drivers.ETL_Drivers_Dim' table. You can move, or remove it, as needed.
            this.eTL_Drivers_DimTableAdapter.Fill(this.dataset_Drivers.ETL_Drivers_Dim);
            // TODO: This line of code loads data into the 'dataset_DsTypes.ETL_DataSourceTypes_Dim' table. You can move, or remove it, as needed.
            this.eTL_DataSourceTypes_DimTableAdapter.Fill(this.dataset_DsTypes.ETL_DataSourceTypes_Dim);
            cmb_DsType.Text = "";
            cmb_Driver.Text = "";
            cmb_Driver.Enabled = false;
        }

        private void cmb_DsType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmb_Environments.SelectedValue != null)
            {
                cmb_Driver.Enabled = true;
                SqlConnection cn = new SqlConnection("Server=ETL2014;Database=" + cmb_Environments.SelectedValue.ToString() + ";User Id=etl_sa;Password=etl!;");
                string QueryCompany =
                    string.Format(
                        "select DriverSK, DriverString, DataSourceTypeSK from ctrl.ETL_Drivers_Dim");
                SqlDataAdapter DA1 = new SqlDataAdapter(QueryCompany, cn);
                cn.Open();
                DataTable DT1 = new DataTable();
                DA1.Fill(DT1);
                cn.Close();
                DataView dv1 = new DataView(DT1);
                dv1.RowFilter = "DataSourceTypeSK = " + cmb_DsType.SelectedValue;
                cmb_Driver.DisplayMember = "DriverString";
                cmb_Driver.ValueMember = "DriverSK";
                cmb_Driver.DataSource = dv1;
            }
        }
    }
}
