using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for SharedService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SharedService : System.Web.Services.WebService
{

    public SharedService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod(EnableSession = true)]
    public string GetSession()
    {
        Dictionary<string, object> dic = new Dictionary<string, object>();
        string userid = "";
        string username = ""; 
        string link = ""; 
        if (Session["UserID"] == null)
        {
            userid = "";
        }
        else
        {
            userid = Session["UserID"].ToString();
        }
        if (Session["UserName"] == null)
        {
            username = "";
        }
        else
        {
            username = Session["UserName"].ToString();
        }
        if (Session["Link"] == null)
        {
            link = "";
        }
        else
        {
            link = Session["Link"].ToString();
        }

        dic.Add("UserID", userid);
        dic.Add("UserName", username);
        dic.Add("Link", link);
        //dic.Add("UserName", Session["UserName"].ToString());
        //dic.Add("Link", Session["Link"].ToString());

        return JsonConvert.SerializeObject(dic);
    }

    [WebMethod(EnableSession = true)]
    public void ClearSession()
    {
        Session["UserID"] = null;
        Session["UserName"] = null;
        Session["Link"] = null;

        Session.Clear();
        Session.Abandon();
    }

    [WebMethod(EnableSession = true)]
    public void SetSession(string link, string userid, string username)
    {
        Session["Link"] = link;
        Session["UserID"] = userid;
        Session["UserName"] = username;
    }
}
