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

                GetMyTasks();
            }
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
}