using Newtonsoft.Json;
using OfficeOpenXml;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TasksJS : System.Web.UI.Page
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
            if (!Page.IsPostBack)
            {
                UserID = Session["UserID"].ToString();
                UserName = Session["UserName"].ToString();
                Session["Link"] = "";
            }
        }
    }

    [WebMethod]
    public static string GetCtrlNos()
    {
        DataTable dt = new DataTable();
        string eFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        SqlConnection conn = new SqlConnection(eFORS);
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetCtrlNos", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return JsonConvert.SerializeObject(dt);
    }
}