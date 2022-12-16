using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.Services;
using System.Web.UI;

public partial class FarmOut : System.Web.UI.Page
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
            }
        }
    }

    [WebMethod]
    public static string GetFarmOut(ReportDetails rd)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetFarmOut(rd));
    }
}