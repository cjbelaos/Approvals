﻿using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.Services;

public partial class CancelledTasks : System.Web.UI.Page
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
        }
    }

    [WebMethod]
    public static string GetCancelledTasks()
    {
        return JsonConvert.SerializeObject(maint.GetCancelledTasks());
    }
}