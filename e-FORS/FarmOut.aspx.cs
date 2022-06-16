using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FarmOut : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;
    //public static string UserName = "Dayanara Palomar";
    //public static string UserID = "D018275";
    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["UserID"] == null && Session["UserName"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();

            AddSupplierName();
            GetFarmOut();
            AddUserInfo();
        }

        gvFarmout.UseAccessibleHeader = true;
        gvFarmout.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void AddUserInfo()
    {
        DataSet ds = new DataSet();
        ds = maint.GetUserInformation(UserID);
        if (ds.Tables[0].DefaultView.Count > 0)
        {
            lblUserName.Text = ToTitleCase(ds.Tables[0].DefaultView[0]["FullName"].ToString());
        }
    }

    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        GetFarmOut();
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
        GetFarmOut();
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
    private void GetFarmOut()
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        DataTable dt = maint.GetFarmOut(rd);

        gvFarmout.DataSource = dt;
        gvFarmout.DataBind();

        gvFarmout.UseAccessibleHeader = true;
        gvFarmout.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
}