using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;

public partial class EPPIAuthorizedSignatory : System.Web.UI.Page
{
    private static readonly EPPIAuthorizedSignatoryMaintenance easm = new EPPIAuthorizedSignatoryMaintenance();
    private static readonly Maintenance maint = new Maintenance();
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
            Response.Redirect("Login.aspx");
        }
        else
        {
            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();
        }
    }

    //private void AddUserInfo()
    //{
    //    DataSet ds = new DataSet();
    //    ds = maint.GetUserInformation(UserID);
    //    if (ds.Tables[0].DefaultView.Count > 0)
    //    {
    //        lblUserName.Text = ToTitleCase(ds.Tables[0].DefaultView[0]["FullName"].ToString());
    //    }
    //}

    [WebMethod]
    public static string GetEmployeeName(string APO)
    {
        return easm.GetEmployeeName(APO);
    }

    [WebMethod]
    public static string GetEPPIAuthorizedSignatory()
    {
        return easm.GetEPPIAuthorizedSignatory();
    }

    [WebMethod]
    public static void SaveEPPIAuthorizedSignatory(string APO, string Name, string UserName)
    {
        easm.SaveEPPIAuthorizedSignatory(APO, Name, UserName);
    }

    [WebMethod]
    public static void DeleteEPPIAuthorizedSignatory(string APO)
    {
        easm.DeleteEPPIAuthorizedSignatory(APO);
    }
}