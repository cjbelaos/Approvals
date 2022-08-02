using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FODocuments : System.Web.UI.Page
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
    public static string GetFarmOutDocument(FarmOutDetails fd)
    {
        return JsonConvert.SerializeObject(maint.GetFarmOutDocument(fd));
    }

    [WebMethod]
    public static string GetDocumentFormat()
    {
        return JsonConvert.SerializeObject(maint.GetDocumentFormat());
    }

    [WebMethod]
    public static string GetEPPIAuthorizedSignatory()
    {
        return JsonConvert.SerializeObject(maint.GetEPPIAuthorizedSignatory());
    }

    [WebMethod]
    public static string GetPreparedby()
    {
        return JsonConvert.SerializeObject(maint.GetPreparedby());
    }

    [WebMethod]
    public static void SaveFarmOutDocuments(FarmOutDocumentDetails fdd)
    {
        maint.SaveFarmOutDocuments(fdd);
    }

    [WebMethod]
    public static void SaveFarmOutDocumentsApproval(FarmOutDocumentDetails fdd)
    {
        maint.SaveFarmOutDocumentsApproval(fdd);
    }

    [WebMethod]
    public static void Approve(Approval a)
    {
        maint.Approval(a);
    }

    [WebMethod]
    public static string FarmOutDocumentsControlNoChecking(FarmOutDocumentDetails fdd)
    {
        return JsonConvert.SerializeObject(maint.FarmOutDocumentsControlNoChecking(fdd));
    }

    [WebMethod]
    public static string GetPEZASignatory()
    {
        return JsonConvert.SerializeObject(maint.GetPEZASignatory());
    }
}