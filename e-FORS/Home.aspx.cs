using System;
using System.Data;
using System.Globalization;
using System.Web;
using System.Web.Services;

public partial class Home : System.Web.UI.Page
{
    private static Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    public static string ToTitleCase(string title)
    {
        
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }
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
            }
        }
    }
}