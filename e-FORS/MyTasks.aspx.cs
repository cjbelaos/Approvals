using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyTasks : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }

    //public static string UserID = "D018277";
    //public static string UserName = "Dayanara Palomar";
    //public static string UserID = "D018275";
    //public static string UserName = "Geryl Mendoza";
    //public static string UserID = "D009488";
    //public static string UserName = "Rommel Magcawas";
    //public static string UserID = "D016023";
    //public static string UserName = "CJ Belaos";
    //public static string UserID = "B012128";
    //public static string UserName = "Maricar Mendoza";
    //public static string UserID = "D011094";
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["UserID"] == null && Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        UserID = Session["UserID"].ToString();
        UserName = Session["UserName"].ToString();

        if (!Page.IsPostBack)
        {
            //AddUserInfo();
            GetMyTasks();
        }

        //Required for jQuery DataTables to work.
        gvMyTasks.UseAccessibleHeader = true;
        gvMyTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void GetMyTasks()
    {
        DataTable dt = maint.GetMyTasks(UserID);
        gvMyTasks.DataSource = dt;
        gvMyTasks.DataBind();

        //Required for jQuery DataTables to work.
        gvMyTasks.UseAccessibleHeader = true;
        gvMyTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        this.gvMyTasks.Columns[5].Visible = false;
    }

    protected void lbControlNo_OnClick(object sender, EventArgs e)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;
        Label lbl = (Label)row.FindControl("lblPageID");

        Response.Redirect(lbl.Text + "?controlno=" + lnk.Text);
    }

    //private void AddUserInfo()
    //{
    //    DataSet ds = new DataSet();
    //    ds = maint.GetUserInformation(UserID);
    //    if (ds.Tables[0].DefaultView.Count > 0)
    //    {
    //        lblUserName.Text = ToTitleCase(ds.Tables[0].DefaultView[0]["FullName"].ToString());
    //    }
    //}
}