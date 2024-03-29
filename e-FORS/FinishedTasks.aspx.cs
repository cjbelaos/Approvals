﻿using Newtonsoft.Json;
using System;
using System.Web;
using System.Web.Services;

public partial class FinishedTasks : System.Web.UI.Page
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
    public static string GetFinishedTasks()
    {
        return JsonConvert.SerializeObject(maint.GetFinishedTasks());
    }

    [WebMethod]
    public static string GetFinishedTasksPerSection(string UserID)
    {
        return JsonConvert.SerializeObject(maint.GetFinishedTasksPerSection(UserID));
    }

    [WebMethod]
    public static string CheckAuthorization(string UserID)
    {
        return JsonConvert.SerializeObject(maint.CheckAuthorization(UserID));
    }
}