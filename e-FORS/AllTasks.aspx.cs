using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AllTasks : System.Web.UI.Page
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

                GetAllTasks();
            }
        }
        
        //Required for jQuery DataTables to work.
        gvAllTasks.UseAccessibleHeader = true;
        gvAllTasks.HeaderRow.TableSection = TableRowSection.TableHeader;
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