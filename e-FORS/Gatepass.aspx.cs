using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Gatepass : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session["Link"] = HttpContext.Current.Request.Url.AbsoluteUri;
            //not logged in
            //Redirect to Login

            Response.Redirect("Login.aspx?expired=1");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                UserID = Session["UserID"].ToString();
                UserName = Session["UserName"].ToString();

                AddSupplierName();
                GetGatepass();
            }
        }

        gvGatepass.UseAccessibleHeader = true;
        gvGatepass.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        GetGatepass();
    }

    protected void lbControlNo_OnClick(object sender, EventArgs e)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;

        Response.Redirect("FarmOutDocuments.aspx" + "?CONTROLNO=" + lnk.Text);
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
        DataTable dt = maint.GetSuppliers();
        ddlSupplier.DataSource = dt;
        ddlSupplier.DataTextField = "SupplierName";
        ddlSupplier.DataValueField = "SupplierCode";
        ddlSupplier.DataBind();
        ddlSupplier.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetGatepass()
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        DataTable dt = maint.GetGatepass(rd);

        gvGatepass.DataSource = dt;
        gvGatepass.DataBind();

        gvGatepass.UseAccessibleHeader = true;
        gvGatepass.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
}