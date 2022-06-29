using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FinishedTasks : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();

            if (!Page.IsPostBack)
            {
                GetFinishedTasks();
            }
        }

        //Required for jQuery DataTables to work.
        gvFinishedTasks.UseAccessibleHeader = true;
        gvFinishedTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void GetFinishedTasks()
    {
        DataTable dt = maint.GetFinishedTasks();
        gvFinishedTasks.DataSource = dt;
        gvFinishedTasks.DataBind();

        //Required for jQuery DataTables to work.
        gvFinishedTasks.UseAccessibleHeader = true;
        gvFinishedTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void lblControlNo_Click(object sender, EventArgs e)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;
        Label lbl = (Label)row.FindControl("lblPageID");

        Response.Redirect(lbl.Text + "?controlno=" + lnk.Text);
    }
}