using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage2 : System.Web.UI.MasterPage
{
    private static readonly Maintenance maint = new Maintenance();

    public static string UserID;

    public string serviceName;

    public string HideAllTasks;
    public string HideFinishedTasks;

    public string HideCountMyTasks;

    public string CountMyTasks = "0";

    public string FormsMenuOpen = "";
    public string Forms = "";
    public string FarmOutRequestForm = "";
    public string FarmOutDocuments = "";

    public string TasksMenuOpen = "";
    public string Tasks = "";
    public string MyTasks = "";
    public string AllTasks = "";
    public string FinishedTasks = "";
    
    public string ReportsMenuOpen = "";
    public string Reports = "";
    public string Gatepass = "";
    public string FarmOut = "";
    public string LOA = "";

    public string MaintenanceMenuOpen = "";
    public string Maintenance = "";
    public string Supplier = "";
    public string EPPIAuthorizedSignatory = "";
    public string LOAs = "";

    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            //not logged in
            //Redirect to Login
            Response.Redirect("Login.aspx?expired=1");
        }
        else
        {
            if (!this.Page.IsPostBack)
            {
                lblUserName.Text = ToTitleCase(Session["UserName"].ToString());
                lblUserID.Text = Session["UserID"].ToString();
                UserID = Session["UserID"].ToString();   
            }

            GetMyTasksCount();

            serviceName = System.Web.VirtualPathUtility.GetFileName(System.Web.HttpContext.Current.Request.Url.AbsolutePath);

            if (serviceName == "FarmOutRequestForm.aspx")
            {
                FormsMenuOpen = "menu-open";
                Forms = "active";
                FarmOutRequestForm = "active";
                
            }
            else if (serviceName == "FarmOutDocuments.aspx")
            {
                FormsMenuOpen = "menu-open";
                Forms = "active";
                FarmOutDocuments = "active";
            }
            else if (serviceName == "MyTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                MyTasks = "active";
                
            }
            else if (serviceName == "AllTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                AllTasks = "active";
            }
            else if (serviceName == "FinishedTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                FinishedTasks = "active";
            }
            else if (serviceName == "Gatepass.aspx")
            {
                ReportsMenuOpen = "menu-open";
                Reports = "active";
                Gatepass = "active";
            }
            else if (serviceName == "FarmOut.aspx")
            {
                ReportsMenuOpen = "menu-open";
                Reports = "active";
                FarmOut = "active";
            }
            else if (serviceName == "LOA.aspx")
            {
                ReportsMenuOpen = "menu-open";
                Reports = "active";
                LOA = "active";
            }
            else if (serviceName == "Supplier.aspx")
            {
                MaintenanceMenuOpen = "menu-open";
                Maintenance = "active";
                Supplier = "active";
            }
            else if (serviceName == "EPPIAuthorizedSignatory.aspx")
            {
                MaintenanceMenuOpen = "menu-open";
                Maintenance = "active";
                EPPIAuthorizedSignatory = "active";
            }
            else if (serviceName == "LOAs.aspx")
            {
                MaintenanceMenuOpen = "menu-open";
                Maintenance = "active";
                LOAs = "active";
            }

            bool x = maint.CheckAuthorization(UserID);
            if (x == false)
            {
                HideAllTasks = "hidden";
                HideFinishedTasks = "hidden";
            }
        }
    }

    public void GetMyTasksCount()
    {
        DataTable dt = maint.GetMyTasksCount(UserID);
        if (dt.DefaultView[0]["MyTasksCount"].ToString() == "0")
        {
            HideCountMyTasks = "hidden";
        }
        else
        {
            CountMyTasks = dt.DefaultView[0]["MyTasksCount"].ToString();
        }
    }
}
