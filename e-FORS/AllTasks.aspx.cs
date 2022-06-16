using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AllTasks : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    //public static string UserName = "Geryl Mendoza";
    //public static string UserID = "D009488"; // Geryl Mendoza

    //public static string UserName = "Dayanara Palomar";
    //public static string UserID = "D018275";

    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        UserID = Session["UserID"].ToString();
        UserName = Session["UserName"].ToString();

        if (!Page.IsPostBack)
        {
            AddUserInfo();
            GetAllTasks();
        }

        //Required for jQuery DataTables to work.
        gvAllTasks.UseAccessibleHeader = true;
        gvAllTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
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

    private void GetAllTasks()
    {
        DataView dv = maint.GetAllTasks();
        gvAllTasks.DataSource = dv;
        gvAllTasks.DataBind();

        //Required for jQuery DataTables to work.
        gvAllTasks.UseAccessibleHeader = true;
        gvAllTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        this.gvAllTasks.Columns[5].Visible = false;
    }

    protected void lbControlNo_OnClick(object sender, EventArgs e)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;
        Label lbl = (Label)row.FindControl("lblPageID");

        Response.Redirect(lbl.Text + "?controlno=" + lnk.Text);
    }
}