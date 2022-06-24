using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LOA : System.Web.UI.Page
{
    private static readonly LOAMaintenance loamaint = new LOAMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    public static string UserName;
    public static string UserID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null && Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                UserID = Session["UserID"].ToString();
                UserName = Session["UserName"].ToString();

                AddSupplierName();
                GetLOA();
            }
        }

        gvLOA.UseAccessibleHeader = true;
        gvLOA.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    
    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        GetLOA();
    }

    protected void BtnClear_OnClick(object sender, EventArgs e)
    {
        tbSection.Text = "";
        ddlSupplier.SelectedIndex = 0;
        tbDateFrom.Text = "";
        tbDateTo.Text = "";
    }

    private void AddSupplierName()
    {
        DataTable dt = maint.GetSupplier();
        ddlSupplier.DataSource = dt;
        ddlSupplier.DataTextField = "SupplierName";
        ddlSupplier.DataValueField = "SupplierName";
        ddlSupplier.DataBind();
        ddlSupplier.Items.Insert(0, new ListItem("Choose...", ""));
    }
    private void GetLOA()
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        DataTable dt = loamaint.GetLOA(rd);

        gvLOA.DataSource = dt;
        gvLOA.DataBind();

        gvLOA.UseAccessibleHeader = true;
        gvLOA.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
}