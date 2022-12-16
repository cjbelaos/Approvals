<%@ WebHandler Language="C#" Class="Login" %>

using System;
using System.Web;

public class Login : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string controlno = System.Convert.ToString(context.Request.QueryString["username"]);
        string userid = System.Convert.ToString(context.Request.QueryString["password"]);
        context.Response.ContentType = "text/plain";
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}