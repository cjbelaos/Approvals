using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for PopupChecker
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class PopupChecker : System.Web.Services.WebService
{

    public PopupChecker()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public string GetSessionPopupChecker()
    {
        if (Session["PopupChecker"] == null)
        {
            Session["PopupChecker"] = "0";
        }
        else if (Session["PopupChecker"].ToString() == "1")
        {
            Session["PopupChecker"] = "1";
        }
        else
        {
            Session["PopupChecker"] = "0";
        }
        Dictionary<string, object> dic = new Dictionary<string, object>();
        dic.Add("PopupChecker", Session["PopupChecker"].ToString());

        return JsonConvert.SerializeObject(dic);
    }

    [WebMethod(EnableSession = true)]
    public void SetSessionPopupChecker()
    {
        Session["PopupChecker"] = "1";
    }

}
