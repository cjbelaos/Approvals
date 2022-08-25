using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.Services;

public partial class TasksJS : System.Web.UI.Page
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
            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();
            Session["Link"] = "";
        }
    }

    [WebMethod]
    public static string GetMyTasks(string user)
    {
        return JsonConvert.SerializeObject(maint.GetMyTasks(user));
    }
}