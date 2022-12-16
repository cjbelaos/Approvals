using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LoginTest : System.Web.UI.Page
{
    public readonly static Maintenance maint = new Maintenance();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetSystemName()
    {
        return JsonConvert.SerializeObject(System.Configuration.ConfigurationManager.AppSettings["SystemName"].ToString());
    }

    [WebMethod]
    public static string GetUser(LoginDetails ld)
    {
        return JsonConvert.SerializeObject(maint.GetUser(ld));
    }

    [WebMethod]
    public static string CheckIfAuthenticated(string Username, string Password)
    {
        return JsonConvert.SerializeObject(ServiceLocator.GetLdapService().IsAuthenticated(Username, Password));
    }
}