using System;
using System.Data;
using System.Globalization;
using System.Web;
using System.Web.Services;
using System.Web.UI;

public partial class MasterPage2 : System.Web.UI.MasterPage
{
    // private static readonly Maintenance maint = new Maintenance(); // PYON UNCOMMENT

    public static string UserID;
    public static string Link;

    public string serviceName;

    public string HideFarmOutDocuments;
    public string HideAllTasks;
    //public string HideFinishedTasks;
    public string HideReports;
    public string HideMaintenance;
    public string HideFinished8112Tasks;

    public string HideCountMyTasks;

    public string CountMyTasks = "0";
    public string TaskorTasks;
    public string TaskList;

    public string FormsMenuOpen = "";
    public string Forms = "";
    public string FarmOutRequestForm = "";
    public string FarmOutDocuments = "";

    public string TasksMenuOpen = "";
    public string Tasks = "";
    public string MyTasks = "";
    public string AllTasks = "";
    public string PendingTasks = "";
    public string FinishedTasks = "";
    public string Finished8112Tasks = "";
    public string CancelledTasks = "";
    
    public string ReportsMenuOpen = "";
    public string Reports = "";
    public string Gatepass = "";
    public string FarmOut = "";
    public string LOA = "";
    public string LiquidationLedger = "";

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
        if (Session["UserID"] == null || Session["UserID"].ToString() == "")
        {
            //not logged in
            //Redirect to Login
            Response.Redirect("Login.aspx?expired=1");
        }
        else
        {
            if (!this.Page.IsPostBack)
            {
                Session["Link"] = HttpContext.Current.Request.Url.AbsoluteUri;
                lblUserName.Text = ToTitleCase(Session["UserName"].ToString());
                lblUserID.Text = Session["UserID"].ToString();
                UserID = Session["UserID"].ToString();
            }
            GetMyTasksCount();
            GetMyTasks();
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
            else if (serviceName == "PendingTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                PendingTasks = "active";
            }
            else if (serviceName == "FinishedTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                FinishedTasks = "active";
            }
            else if (serviceName == "Finished8112Tasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                Finished8112Tasks = "active";
            }
            else if (serviceName == "CancelledTasks.aspx")
            {
                TasksMenuOpen = "menu-open";
                Tasks = "active";
                CancelledTasks = "active";
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
            else if (serviceName == "LiquidationLedger.aspx")
            {
                ReportsMenuOpen = "menu-open";
                Reports = "active";
                LiquidationLedger = "active";
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

            Maintenance maint = new Maintenance(); // PYON REMOVE
            bool isAuthorized = maint.CheckAuthorization(lblUserID.Text);
            if (isAuthorized == false)
            {
                HideFarmOutDocuments = "hidden";
                HideAllTasks = "hidden";
                HideFinished8112Tasks = "hidden";
                //HideFinishedTasks = "hidden";
                HideMaintenance = "hidden";
                HideReports = "hidden";
            }
        }
    }

    public void GetMyTasksCount()
    {
        Maintenance maint = new Maintenance(); // PYON REMOVE

        DataTable dt = maint.GetMyTasksCount(lblUserID.Text);
        if (dt.DefaultView[0]["MyTasksCount"].ToString() == "0")
        {
            HideCountMyTasks = "hidden";
        }
        else
        {
            CountMyTasks = dt.DefaultView[0]["MyTasksCount"].ToString();
            if (Convert.ToInt32(CountMyTasks) > 1)
            {
                TaskorTasks = " Tasks";
            }
            else
            {
                TaskorTasks = " Task";
            }
        }
    }

    public void GetMyTasks()
    {
        Maintenance maint = new Maintenance(); // PYON REMOVE
        DataTable dt = maint.GetMyTasks(lblUserID.Text);

        foreach (DataRow row in dt.Rows)
        {
            String ControlNo = (string)row[0];
            DateTime Created = (DateTime)row[11];
            String PageName = (string)row[12];
            Int32 interval = (int)Math.Round((DateTime.Now - Created).TotalSeconds);

            string TimeLapse;
            if (interval >= 60)
            {
                interval = (int)Math.Round((DateTime.Now - Created).TotalMinutes);
                if (interval >= 60)
                {
                    interval = (int)Math.Round((DateTime.Now - Created).TotalHours);
                    if (interval >= 24)
                    {
                        interval = (int)Math.Round((DateTime.Now - Created).TotalDays);
                        if (interval > 1)
                        {
                            TimeLapse = interval.ToString() + " days";
                        }
                        else
                        {
                            TimeLapse = interval.ToString() + " day";
                        }
                    }
                    else
                    {
                        if (interval > 1)
                        {
                            TimeLapse = interval.ToString() + " hours";
                        }
                        else
                        {
                            TimeLapse = interval.ToString() + " hour";
                        }
                    }
                }
                else
                {
                    if (interval > 1)
                    {
                        TimeLapse = interval.ToString() + " minutes";
                    }
                    else
                    {
                        TimeLapse = interval.ToString() + " minute";
                    }
                }
            }
            else
            {
                if (interval > 1)
                {
                    TimeLapse = interval.ToString() + " seconds";
                }
                else
                {
                    TimeLapse = interval.ToString() + " second";
                }
            }

            TaskList += "<a href = \""+PageName+"?controlno="+ControlNo+ "\" class=\"dropdown-item\" style=\"color: #007bff\"><i class=\"fas fa-thumbtack\"></i> &nbsp;" + ControlNo + "<span class=\"float-right text-muted text-sm\">"+TimeLapse+"</span></a>";
        }
    }

    //protected void BtnLogOut_Click(object sender, EventArgs e)
    //{
    //    Session.Clear();
    //    Session.Abandon();
    //    Response.Redirect("Login.aspx");
    //}
}
