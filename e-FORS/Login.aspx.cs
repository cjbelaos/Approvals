using System;
using System.Data;
using System.Threading;
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
            //Session["UserID"] = "";
            //Session["UserName"] = "";
            Session["PopupChecker"] = "";

            //Session["UserID"] = "B012128";
            //Session["UserName"] = "CHRIS JOHN BELAOS";

            //Session["UserID"] = "D016023";
            //Session["UserName"] = "ROMMEL MAGCAWAS";

            //Session["UserID"] = "D016621";
            //Session["UserName"] = "KRISTINE JOY JAVIER";

            //Session["UserID"] = "D009488";
            //Session["UserName"] = "GERYL MENDOZA";

            //Session["UserID"] = "D011094";
            //Session["UserName"] = "MARICAR MENDOZA";

            //Session["UserID"] = "D014556";
            //Session["UserName"] = "MARIO AUSTRIA";

            //Session["UserID"] = "E017217";
            //Session["UserName"] = "HEZELYN ZANTUA";

            //Session["UserID"] = "B012059";
            //Session["UserName"] = "EMMANUEL JOSEPH ABU";

            //Session["UserID"] = "E016276";
            //Session["UserName"] = "CHRISTIAN AMAQUIN";

            //Session["UserID"] = "D016028";
            //Session["UserName"] = "LUZVIMINDA LUNA";

            //Session["UserID"] = "D018275";
            //Session["UserName"] = "DAYANARA PALOMAR";

            //Session["UserID"] = "D009524";
            //Session["UserName"] = "JOEY GUTIERREZ";
        }
    }
    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        //Thread.Sleep(3000);
        //if (Session["Link"] == null)
        //{
        //    Response.Redirect("Home.aspx");
        //}
        //else
        //{
        //    Response.Redirect(Session["Link"].ToString());
        //}

        if (tbUsername.Text == "" && tbPassword.Text == "")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "UserAndPassIsEmpty();", true);
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
            LoginDetails ld = new LoginDetails();
            ld.system = System.Configuration.ConfigurationManager.AppSettings["SystemName"].ToString();
            ld.username = tbUsername.Text;
            ld.password = tbPassword.Text;
            ld.ldap = false;
            DataTable dt = maint.GetUser(ld);

            if (dt.Rows.Count > 0)
            {
                Session["UserName"] = Convert.ToString(dt.Rows[0]["user_name"]).ToUpper();
                Session["UserID"] = Convert.ToString(dt.Rows[0]["user_id"]).ToUpper();

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
                bool isAuthenticated = ServiceLocator.GetLdapService().IsAuthenticated(tbUsername.Text, tbPassword.Text);
                if (isAuthenticated == true)
                {

                    ld.system = System.Configuration.ConfigurationManager.AppSettings["SystemName"].ToString();
                    ld.username = tbUsername.Text;
                    ld.password = tbPassword.Text;
                    ld.ldap = true;
                    DataTable dt2 = maint.GetUser(ld);
                    if (dt2.Rows.Count > 0)
                    {
                        Session["UserName"] = Convert.ToString(dt2.Rows[0]["user_name"]).ToUpper();
                        Session["UserID"] = Convert.ToString(dt2.Rows[0]["user_id"]).ToUpper();

                        if (Session["Link"] == null)
                        {
                            Response.Redirect("Home.aspx");
                        }
                        else
                        {
                            Response.Redirect(Session["Link"].ToString());
                        }
                    }

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
    }
}
