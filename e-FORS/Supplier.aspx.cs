using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Supplier : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    private static readonly FarmOutDocumentsMaintenance fodm = new FarmOutDocumentsMaintenance();
    public static string UserID;
    public static string UserName;

    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null && Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!Page.IsPostBack)
        {
            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();

            GetSupplier();
            GetLOAType();
            AddUserInfo();
        }

        gvSupplier.UseAccessibleHeader = true;
        gvSupplier.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void AddUserInfo()
    {
        DataSet ds = new DataSet();
        ds = maint.GetUserInformation(UserID);
        if (ds.Tables[0].DefaultView.Count > 0)
        {
            lblUserName.Text = ToTitleCase(ds.Tables[0].DefaultView[0]["FullName"].ToString());
        }
    }

    protected void BtnSave_OnClick(object sender, EventArgs e)
    {
        string UserName = Session["UserName"].ToString();
        string Supplier = ddlSupplier.SelectedItem.Text;
        string LOAType = ddlLOAType.SelectedItem.Text;
        string LOANo = ddlLOANo.SelectedItem.Text;
        string ExpirationDate1 = tbExpirationDate1.Text;
        string LOAAmountLimit = tbLOAAmountLimit.Text;
        string LOAQuantityLimit = tbLOAQuantityLimit.Text;
        string SuretyBondNo = ddlSuretyBondNo.Text;
        string ExpirationDate2 = tbExpirationDate2.Text;

        try
        {
            maint.SaveSupplier(UserName, Supplier, LOAType, LOANo, ExpirationDate1, LOAAmountLimit, LOAQuantityLimit, SuretyBondNo, ExpirationDate2);
            GetSupplier();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SaveSuccessAlert();", true);
        }
        catch
        {
            GetSupplier();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SaveFailedAlert();", true);
        }

        Clear();
    }

    private void GetSupplier()
    {
        DataTable dt = maint.GetSupplier();
        gvSupplier.DataSource = dt;
        gvSupplier.DataBind();

        ddlSupplier.DataSource = dt;
        ddlSupplier.DataTextField = "SupplierName";
        ddlSupplier.DataValueField = "SupplierName";
        ddlSupplier.DataBind();
        ddlSupplier.Items.Insert(0, new ListItem("Choose...", "0"));

        //Required for jQuery DataTables to work.
        gvSupplier.UseAccessibleHeader = true;
        gvSupplier.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void ddlLOAType_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlLOANo.Items.Clear();
        ddlSuretyBondNo.Items.Clear();
        string LOAType = ddlLOAType.SelectedItem.Text;
        DataTable dt = new DataTable();
        dt = fodm.GetLOANo(LOAType);
        ddlLOANo.DataSource = dt;
        ddlLOANo.DataTextField = "LOANo";
        ddlLOANo.DataValueField = "LOANo";
        ddlLOANo.DataBind();
        ddlLOANo.Items.Insert(0, new ListItem("Choose...", "0"));
    }

    protected void ddlLOANo_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSuretyBondNo.Items.Clear();
        string LOANo = ddlLOANo.SelectedItem.Text;
        DataTable dt = new DataTable();
        dt = fodm.GetSuretyBondNo(LOANo);
        tbExpirationDate1.Text = dt.Rows[0]["ExpirationDate"].ToString();
        ddlSuretyBondNo.Items.Insert(0, new ListItem(dt.Rows[0]["SBNo"].ToString(), dt.Rows[0]["SBNo"].ToString()));
        tbExpirationDate2.Text = dt.Rows[0]["ExpirationDate1"].ToString();
    }

    private void GetLOAType()
    {
        DataTable dt = new DataTable();
        dt = fodm.GetLOAType();
        ddlLOAType.DataSource = dt;
        ddlLOAType.DataTextField = "LOAType";
        ddlLOAType.DataValueField = "LOAType";
        ddlLOAType.DataBind();
        ddlLOAType.Items.Insert(0, new ListItem("Choose...", "0"));
    }

    protected void gvSupplier_RowCommand(object sender, GridViewCommandEventArgs g)
    {
        if (g.CommandName.Equals("EditItem"))
        {
            GridViewRow row = (GridViewRow)(((LinkButton)g.CommandSource).NamingContainer);
            string index = g.CommandArgument.ToString();

            //Label lblSupplierName = (Label)row.FindControl("lblSupplierName");
            Label lblLOAType = (Label)row.FindControl("lblLOAType");
            Label lblLOANo = (Label)row.FindControl("lblLOANo");
            Label lblLOAExpirationDate = (Label)row.FindControl("lblLOAExpirationDate");
            Label lblAmountLimit = (Label)row.FindControl("lblAmountLimit");
            Label lblQTYLimit = (Label)row.FindControl("lblQTYLimit");
            //Label lblSuretyBondNo = (Label)row.FindControl("lblSuretyBondNo");
            Label lblSuretyBondExpiration = (Label)row.FindControl("lblSuretyBondExpiration");

            ddlSupplier.SelectedValue = index;
            ddlLOAType.SelectedValue = lblLOAType.Text;
            {
                ddlLOANo.Items.Clear();
                ddlSuretyBondNo.Items.Clear();
                DataTable dt = new DataTable();
                dt = fodm.GetLOANo(ddlLOAType.SelectedValue);
                ddlLOANo.DataSource = dt;
                ddlLOANo.DataTextField = "LOANo";
                ddlLOANo.DataValueField = "LOANo";
                ddlLOANo.DataBind();
                ddlLOANo.Items.Insert(0, new ListItem("Choose...", "0"));
            }
            ddlLOANo.SelectedValue = lblLOANo.Text;
            {
                ddlSuretyBondNo.Items.Clear();
                DataTable dt = new DataTable();
                dt = fodm.GetSuretyBondNo(ddlLOANo.SelectedValue);
                //tbExpirationDate1.Text = dt.Rows[0]["ExpirationDate"].ToString();
                ddlSuretyBondNo.Items.Insert(0, new ListItem(dt.Rows[0]["SBNo"].ToString(), dt.Rows[0]["SBNo"].ToString()));
                //tbExpirationDate2.Text = dt.Rows[0]["ExpirationDate1"].ToString();
            }
            tbExpirationDate1.Text = lblLOAExpirationDate.Text;
            tbLOAAmountLimit.Text = lblAmountLimit.Text;
            tbLOAQuantityLimit.Text = lblQTYLimit.Text;
            //ddlSuretyBondNo.SelectedValue = lblSuretyBondNo.Text;
            tbExpirationDate2.Text = lblSuretyBondExpiration.Text;

            //tbItemNo.Text = lblItemCode.Text;
            //tbItemDescription.Text = lblItemDescription.Text;
            //tbQuantity.Text = lblQuantity.Text;
            //tbUnitofMeasurement.Text = lblUnitOfMeasurement.Text;
            //tbAmount.Text = lblAmount.Text;
            //tbAssetNo.Text = lblAssetNo.Text;
            //tbOD.Text = lblODNo.Text;
            //tbContainer.Text = lblContainerNo.Text;
            //tbPEZASeal.Text = lblPEZASeal.Text;
            //tbDSRDRNo.Text = lblDSRDRNo.Text;

        }

        //if (g.CommandName.Equals("DeleteItem"))
        //{
        //    GridViewRow row = (GridViewRow)(((Button)g.CommandSource).NamingContainer);
        //    items.ID = g.CommandArgument.ToString();
        //    maint.DeleteItem(items);
        //    GetItems();
        //}
    }

    private void Clear()
    {
        ddlSupplier.SelectedValue = "0";
        ddlLOAType.SelectedValue = "0";
        ddlLOANo.Items.Clear();
        tbExpirationDate1.Text = "";
        tbLOAAmountLimit.Text = "";
        tbLOAQuantityLimit.Text = "";
        ddlSuretyBondNo.Items.Clear();
        tbExpirationDate2.Text = "";
    }
}