using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LOAs : System.Web.UI.Page
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
        }
    }

    [WebMethod]
    public static string GetLOA()
    {
        return JsonConvert.SerializeObject(maint.GetLOA());
    }

    [WebMethod]
    public static void AddLOA(LOADetails ld)
    {
        maint.AddLOA(ld, UserID);
    }

    [WebMethod]
    public static void UpdateLOA(LOADetails ld)
    {
        maint.UpdateLOA(ld, UserID);
    }

    [WebMethod]
    public static void DeleteLOA(LOADetails ld)
    {
        maint.DeleteLOA(ld, UserID);
    }
}