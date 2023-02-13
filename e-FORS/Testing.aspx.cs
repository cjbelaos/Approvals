using System;
using System.Data;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Testing : System.Web.UI.Page
{
    private static DataSet dsLOAReport;
    private static string UserName;
    private static string UserID;
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
    public static string GetLOAReport(ReportDetails rd)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetLOAReport(rd));
    }

    [WebMethod]
    public static string GetFarmOut(FarmOutDetails fo)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return JsonConvert.SerializeObject(form.GetFarmOut(fo));
    }
}