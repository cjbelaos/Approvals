using System;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Testing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string GetLOA()
    {
        LOAMaintenance loa = new LOAMaintenance();
        return JsonConvert.SerializeObject(loa.GetLOA());
    }
}