using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.Services;

public partial class Testing : System.Web.UI.Page
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
        }
    }

    [WebMethod]
    public static string GetFinished8112Tasks(string DIVISION, string LOANO, string SUPPLIER, string PURPOSE)
    {
        return JsonConvert.SerializeObject(maint.GetFinished8112Tasks(DIVISION, LOANO, SUPPLIER, PURPOSE));
    }

    [WebMethod]
    public static string GetFinished8112LOANOs()
    {
        return JsonConvert.SerializeObject(maint.GetFinished8112LOANOs());
    }

    [WebMethod]
    public static string GetFinished8112Purpose()
    {
        return JsonConvert.SerializeObject(maint.GetFinished8112Purpose());
    }

    [WebMethod]
    public static string GetFinished8112Suppliers()
    {
        return JsonConvert.SerializeObject(maint.GetFinished8112Suppliers());
    }

    [WebMethod]
    public static void MarkAsPrinted(string ControlNo, string UserId)
    {
        maint.MarkAsPrinted(ControlNo, UserId);
    }

    [WebMethod]
    public static void RemoveMarkAsPrinted(string ControlNo, string UserId)
    {
        maint.RemoveMarkAsPrinted(ControlNo, UserId);
    }

}