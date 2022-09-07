<%@ WebService Language="C#" Class="_8112" %>

using Newtonsoft.Json;
using System.Collections.Generic;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class _8112 : System.Web.Services.WebService
{

    [WebMethod(EnableSession = true)]
    public string GetUrl()
    {
        if (Session["url"] == null)
        {
            Session["url"] = "";
        }
        //Session["ControlNoS"] = ControlNos;
        //Session["Dates"] = maint.Get8112Dates(ControlNos);
        //Session["AuthorizedOffical"] = dt1.Rows[0]["AuthorizedOfficial"].ToString();
        Dictionary<string, object> dic = new Dictionary<string, object>();
        dic.Add("url", Session["url"].ToString());

        return JsonConvert.SerializeObject(dic);
    }
}