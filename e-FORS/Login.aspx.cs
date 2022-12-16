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
    }
    protected void BtnLogin_Click(object sender, EventArgs e)
    {
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
