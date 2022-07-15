using System;
using System.Data;
using System.Web.UI;


public partial class _Default : System.Web.UI.Page
{
    Maintenance maint = new Maintenance();
    public static string strUsername;
    public static string Link;

    protected void Page_Load(object sender, EventArgs e)
    {
        tbUsername.Focus();

        if (!this.Page.IsPostBack)
        {
            Session["UserID"] = "";
            Session["UserName"] = "";

            //Session["UserID"] = "B012128";
            //Session["UserName"] = "CHRIS JOHN BELAOS";

            //Session["UserID"] = "D016023";
            //Session["UserName"] = "ROMMEL MAGCAWAS";

            //Session["UserID"] = "D009488";
            //Session["UserName"] = "GERYL MENDOZA";

            //Session["UserID"] = "D011094";
            //Session["UserName"] = "MARICAR MENDOZA";

            //Session["UserID"] = "D018275";
            //Session["UserName"] = "DAYANARA PALOMAR";
        }
    }
    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        //Response.Redirect("Home.aspx");

        if (tbUsername.Text != "" && tbPassword.Text != "")
        {
            Boolean isLogin = false;

            try
            {
                string strSystemName = System.Configuration.ConfigurationManager.AppSettings["SystemName"].ToString();

                Maintenance maint = new Maintenance();
                UserInfo ui = new UserInfo();

                DataView dvUser = new DataView();
                DataView dv = new DataView();

                ServiceLocator.GetLdapService().IsAuthenticated(tbUsername.Text, tbPassword.Text);

                bool isAuthenticated = ServiceLocator.GetLdapService().IsAuthenticated(tbUsername.Text, tbPassword.Text);
                if (isAuthenticated)
                {
                    Session["Role"] = null;
                    dvUser = maint.GetUser(strSystemName, tbUsername.Text);
                    if (dvUser.Count > 0)
                    {
                        Session["UserName"] = Convert.ToString(dvUser[0]["user_name"]).ToUpper();
                        Session["Role"] = Convert.ToString(dvUser[0]["rolename"]);
                        Session["UserID"] = Convert.ToString(dvUser[0]["user_id"]).ToUpper();
                        Session["Subsystem"] = dvUser;

                        isLogin = true;
                    }
                    else
                    {
                        return;
                    }
                }
                else
                {
                    dvUser = maint.GetUser(System.Configuration.ConfigurationManager.AppSettings["SystemName"], tbUsername.Text, tbPassword.Text);
                    if (dvUser.Count > 0)
                    {
                        Session["UserName"] = Convert.ToString(dvUser[0]["user_name"]).ToUpper();
                        Session["Role"] = Convert.ToString(dvUser[0]["rolename"]);
                        Session["UserID"] = Convert.ToString(dvUser[0]["user_id"]).ToUpper();
                        Session["Subsystem"] = dvUser;

                        isLogin = true;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "LoginFailed();", true);
                        return;
                    }
                }

            }
            catch (Exception ex)
            {
                string s = ex.Message;
                isLogin = false;
                return;

            }
            finally
            {
                if (isLogin == true)
                {
                    if (Session["Link"] == null)
                    {
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        Response.Redirect(Session["Link"].ToString());
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "LoginFailed();", true);
                }
            }
        }
        else if (tbUsername.Text == "" && tbPassword.Text != "")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "InputUsername();", true);
        }
        else if (tbUsername.Text != "" && tbPassword.Text == "")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "InputPassword();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "UserAndPassIsEmpty();", true);
        }
    }
}
