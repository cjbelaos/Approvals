using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Supplier : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    private static readonly FarmOutDocumentsMaintenance fodm = new FarmOutDocumentsMaintenance();
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
    public static string GetSuppliers()
    {
        return JsonConvert.SerializeObject(maint.GetSuppliers());
    }

    [WebMethod]
    public static void AddSupplier(SupplierDetails sd)
    {
        maint.AddSupplier(sd, UserID);
    }

    [WebMethod]
    public static void UpdateSupplier(SupplierDetails sd)
    {
        maint.UpdateSupplier(sd, UserID);
    }

    [WebMethod]
    public static void DeleteSupplier(SupplierDetails sd)
    {
        maint.DeleteSupplier(sd, UserID);
    }

    [WebMethod]
    public static string GetLOAList()
    {
        return JsonConvert.SerializeObject(maint.GetLOAList());
    }
}