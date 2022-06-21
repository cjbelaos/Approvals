using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;

public partial class FarmOutDocuments : System.Web.UI.Page
{
    private static readonly FarmOutDocumentsMaintenance fodm = new FarmOutDocumentsMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    public static string ToTitleCase(string title)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(title.ToLower());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                UserID = Session["UserID"].ToString();
                UserName = Session["UserName"].ToString();

                //AddUserInfo();
                GetDocumentFormattobeUsed();
                GetLOAType();
                GetEPPIAuthorizedSignatory();
                GetPreparedby();


                tbPEZAExaminerSignatory.Text = "MS. TERESA ELAINE LAYLO / MS. PAMELA ROSE DEL RIO";
                tbPEZAOICSignatory.Text = "MR. JOSE MA. GEREMI T. MANAS";

                if (Request.QueryString["controlno"] != null)
                {
                    BtnSave.Enabled = true;
                    tbFarmOutControlNo.Text = Request.QueryString["controlno"].ToString();

                    if (fodm.FarmOutDocumentsControlNoChecking(tbFarmOutControlNo.Text) == true)
                    {
                        GetFarmOutDocument();
                    }
                    ddlPreparedby.SelectedValue = UserID;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveAttr()", true);
                }
                else
                {
                    ddlPreparedby.SelectedValue = UserID;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveAttr()", true);
                }
            }
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveAttr()", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "AddDesign();", true);
        }
    }

    //private void AddUserInfo()
    //{
    //    DataSet ds = new DataSet();
    //    ds = maint.GetUserInformation(UserID);
    //    if (ds.Tables[0].DefaultView.Count > 0)
    //    {
    //        lblUserName.Text = ToTitleCase(ds.Tables[0].DefaultView[0]["FullName"].ToString());
    //    }
    //}

    protected void ddlDocumentFormattobeUsed_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDocumentFormattobeUsed.SelectedValue == "1" || ddlDocumentFormattobeUsed.SelectedValue == "2")
        {
            ddlLOAType.Enabled = true;
            ddlLOANo.Enabled = true;
        }
        else
        {
            ddlLOAType.Enabled = false;
            ddlLOANo.Enabled = false;
        }

        DataTable dt = new DataTable();

        dt.Columns.Add("Task", typeof(string));
        dt.Rows.Add(ddlDocumentFormattobeUsed.SelectedItem.Text);
        if (ddlDocumentFormattobeUsed.SelectedValue.ToString() != "4" && ddlDocumentFormattobeUsed.SelectedValue.ToString() != "0")
        {
            dt.Rows.Add("GATEPASS");
            GrvPrint.Visible = true;
        }
        else if (ddlDocumentFormattobeUsed.SelectedValue.ToString().Trim().ToUpper() == "4")
        {
            dt.Rows.Clear();
            dt.Rows.Add("GATEPASS");
            GrvPrint.Visible = true;
        }
        else
        {
            dt.Rows.Clear();
            GrvPrint.Visible = false;
        }
        GrvPrint.DataSource = dt;
        GrvPrint.DataBind();
    }

    protected void GrvPrint_RowCommand(object sender, GridViewCommandEventArgs g)
    {
        if (g.CommandName.Equals("Print") && g.CommandArgument.Equals("GATEPASS"))
        {
            DataSet dsGatepass = fodm.GetGatepassForPrint(tbFarmOutControlNo.Text);
            Session["dsGatepass"] = dsGatepass;
            Session["ControlNo"] = tbFarmOutControlNo.Text;
            Response.Redirect("GatepassPrint.aspx");
        }

        if (g.CommandName.Equals("Print") && g.CommandArgument.Equals("PEZA FORM 8106"))
        {
            DataSet dsPEZA8106 = fodm.GetLOA8106ForPrint(tbFarmOutControlNo.Text);
            DataTable dt = fodm.GetAuthorizedOfficial(UserID);
            Session["dsPEZA8106"] = dsPEZA8106;
            Session["dtAuthorizedOfficial"] = dt;
            Response.Redirect("PEZA8106Print.aspx");
        }
    }

    private void GetDocumentFormattobeUsed()
    {
        DataSet ds = new DataSet();
        ds = fodm.GetDocumentFormattobeUsed();
        ddlDocumentFormattobeUsed.DataSource = ds.Tables[0];
        ddlDocumentFormattobeUsed.DataTextField = "Task";
        ddlDocumentFormattobeUsed.DataValueField = "ID";
        ddlDocumentFormattobeUsed.DataBind();
        ddlDocumentFormattobeUsed.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetEPPIAuthorizedSignatory()
    {
        DataTable dt = new DataTable();
        dt = fodm.GetEPPIAuthorizedSignatory();

        ddlEPPIAuthorizedSignatory.DataSource = dt;
        ddlEPPIAuthorizedSignatory.DataTextField = "EMPLOYEENAME";
        ddlEPPIAuthorizedSignatory.DataValueField = "APOACCOUNT";
        ddlEPPIAuthorizedSignatory.DataBind();
        ddlEPPIAuthorizedSignatory.Items.Insert(0, new ListItem("Choose...", ""));

        ddlApprovedby.DataSource = dt;
        ddlApprovedby.DataTextField = "EMPLOYEENAME";
        ddlApprovedby.DataValueField = "APOACCOUNT";
        ddlApprovedby.DataBind();
        ddlApprovedby.Items.Insert(0, new ListItem("Choose...", ""));

        ddlReassignto.DataSource = dt;
        ddlApprovedby.DataTextField = "EMPLOYEENAME";
        ddlApprovedby.DataValueField = "APOACCOUNT";
        ddlApprovedby.DataBind();
        ddlApprovedby.Items.Insert(0, new ListItem("Choose...", ""));

    }

    private void GetPreparedby()
    {
        DataSet ds = new DataSet();
        ds = fodm.GetPreparedby();
        ddlPreparedby.DataSource = ds.Tables[0];
        ddlPreparedby.DataTextField = "FullName";
        ddlPreparedby.DataValueField = "APOAccount";
        ddlPreparedby.DataBind();
        ddlPreparedby.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetLOAType()
    {
        DataTable dt = new DataTable();
        dt = fodm.GetLOAType();
        ddlLOAType.DataSource = dt;
        ddlLOAType.DataTextField = "LOAType";
        ddlLOAType.DataValueField = "ID";
        ddlLOAType.DataBind();
        ddlLOAType.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetReassignto()
    {
        DataTable dt = new DataTable();
        dt = fodm.GetEPPIAuthorizedSignatory();

        ddlReassignto.DataSource = dt;
        ddlReassignto.DataTextField = "EMPLOYEENAME";
        ddlReassignto.DataValueField = "APOACCOUNT";
        ddlReassignto.DataBind();
        ddlReassignto.Items.Insert(0, new ListItem("Choose...", ""));
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
        ddlLOANo.DataValueField = "ID";
        ddlLOANo.DataBind();
        ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));

        //if (ddlDocumentFormattobeUsed.SelectedValue == "1" || ddlDocumentFormattobeUsed.SelectedValue == "2")
        //{
        //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ShowLOA();", true);
        //    if (tbFarmOutControlNo.Text == null || (tbFarmOutControlNo.Text != null && fodm.FinishTaskChecking(tbFarmOutControlNo.Text) == false))
        //    {
        //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "DisableBtnPrint();", true);
        //    }

        //}
    }

    protected void ddlLOANo_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSuretyBondNo.Items.Clear();
        string LOANo = ddlLOANo.SelectedItem.Text;
        DataTable dt = new DataTable();
        dt = fodm.GetSuretyBondNo(LOANo);
        tbExpiryDate1.Text = dt.Rows[0]["ExpirationDate"].ToString();
        ddlSuretyBondNo.Items.Insert(0, new ListItem(dt.Rows[0]["SBNo"].ToString(), "0"));
        tbExpiryDate2.Text = dt.Rows[0]["ExpirationDate1"].ToString();
    }

    protected void BtnSave_OnClick(object sender, EventArgs e)
    {
        if (ddlApprovedby.SelectedValue == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ShowApprovedbyHelpBlock();", true);
        }
        
        if (ddlApprovedby.SelectedValue != "")
        {
                string ControlNo = tbFarmOutControlNo.Text;
                string DocumentFormat = ddlDocumentFormattobeUsed.SelectedItem.Text;
                string PEZADocumentNo = tbPEZADocumentNo.Text;
                string GatepassNo = tbGatepassNo.Text;
                string LOAType = ddlLOAType.SelectedItem.Text;
                string LOANo = ddlLOANo.SelectedItem.Text;
                string LOAExpiryDate = tbExpiryDate1.Text;
                string SuretyBondNo = ddlSuretyBondNo.SelectedItem.Text;
                string SuretyExpiryDate = tbExpiryDate2.Text;
                string ContainerNo = tbContainerNo.Text;
                string PEZASeal = tbPEZASeal.Text;
                string PlateNo = tbPlateNo.Text;
                string ControlNo8105 = tb8105ControlNo.Text;
                string EPPIAuthorizedSignatory = ddlEPPIAuthorizedSignatory.Text;
                string PEZAExaminerSignatory = tbPEZAExaminerSignatory.Text;
                string PEZAOICSignatory = tbPEZAOICSignatory.Text;
                fodm.SaveFarmOutDocuments(
                    ControlNo,
                    DocumentFormat,
                    PEZADocumentNo,
                    GatepassNo,
                    LOAType,
                    LOANo,
                    LOAExpiryDate,
                    SuretyBondNo,
                    SuretyExpiryDate,
                    ContainerNo,
                    PEZASeal,
                    PlateNo,
                    ControlNo8105,
                    EPPIAuthorizedSignatory,
                    PEZAExaminerSignatory,
                    PEZAOICSignatory,
                    UserID);

                string Preparedby = ddlPreparedby.SelectedValue;
                string Approvedby = ddlApprovedby.SelectedValue;
                fodm.SaveFarmOutDocumentsApproval(ControlNo, Preparedby, Approvedby);
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "SaveSuccessAlert();", true);
                BtnConfirm1.Enabled = true;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "SaveFailedAlert();", true);
        }
    }

    protected void BtnConfirm1_OnClick(object sender, EventArgs e)
    {
        if (fodm.FarmOutDocumentsControlNoChecking(tbFarmOutControlNo.Text) == true)
        {
            tbWorkFlowID.Text = "2";
            tbApproverID.Text = "1";
            BtnRequestChange.Visible = false;
            BtnReassignTask.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ConfirmFailedAlert();", true);
        }
    }

    protected void BtnConfirm2_OnClick(object sender, EventArgs e)
    {
        tbWorkFlowID.Text = "2";
        tbApproverID.Text = "2";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnApprove_OnClick(object sender, EventArgs e)
    {
        string ControlNo = tbFarmOutControlNo.Text;
        string WorkFlowID = tbWorkFlowID.Text;
        string ApproverID = tbApproverID.Text;
        string ApprovalComments = tbComment.Text;
        fodm.Approval(ControlNo, WorkFlowID, ApproverID, ApprovalComments, UserID);
        GetFarmOutDocument();

        DisableForm();

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "DisableForm();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ApprovedAlert();", true);


    }

    protected void BtnRequestChange_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalRequestChange').modal('show');", true);
    }

    protected void BtnSaveRequestChange_OnClick(object sender, EventArgs e)
    {
        string ControlNo = tbFarmOutControlNo.Text;
        string WorkFlowID = tbWorkFlowID.Text;
        string ApproverID = tbApproverID.Text;
        string ApprovalComments = tbComment.Text;
        fodm.RequestChange(ControlNo, WorkFlowID, ApproverID, ApprovalComments, UserID);
        DisableForm();

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "DisableForm()", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "RequestChangeAlert();", true);
    }
    protected void BtnCancelRequestChange_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnReassignTask_OnClick(object sender, EventArgs e)
    {
        GetReassignto();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalReassignTask').modal('show');", true);
    }

    protected void BtnSaveReassignTask_OnClick(object sender, EventArgs e)
    {
        
        if (ddlReassignto.SelectedValue == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalReassignTask').modal('show');", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ShowReassigntoHelpBlock();", true);
        }
        else
        {
            string ControlNo = tbFarmOutControlNo.Text;
            string WorkFlowID = tbWorkFlowID.Text;
            string ApproverID = tbApproverID.Text;
            string ApprovalComments = tbComment.Text;
            string Reassignto = ddlReassignto.SelectedValue;
            fodm.ReassignTask(ControlNo, WorkFlowID, ApproverID, ApprovalComments, Reassignto, UserID);

            DisableForm();

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "DisableForm()", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ReassignAlert();", true);
        }

    }

    protected void BtnCancelReassignTask_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    private void GetFarmOutDocument()
    {
        string ControlNo = tbFarmOutControlNo.Text;
        DataSet ds = new DataSet();
        ds = fodm.GetFarmOutDocument(ControlNo);

        if (ds.Tables[1].DefaultView.Count > 0)
        {
            ddlDocumentFormattobeUsed.ClearSelection();
            ddlDocumentFormattobeUsed.Items.FindByText(ds.Tables[1].DefaultView[0]["DOCUMENTFORMAT"].ToString()).Selected = true;
            {
                if (ddlDocumentFormattobeUsed.SelectedValue == "1" || ddlDocumentFormattobeUsed.SelectedValue == "2")
                {
                    ddlLOAType.Enabled = true;
                    ddlLOANo.Enabled = true;
                }

                DataTable dt = new DataTable();

                dt.Columns.Add("Task", typeof(string));
                dt.Rows.Add(ddlDocumentFormattobeUsed.SelectedItem.Text);
                if (ddlDocumentFormattobeUsed.SelectedValue.ToString() != "4" && ddlDocumentFormattobeUsed.SelectedValue.ToString() != "0")
                {
                    dt.Rows.Add("GATEPASS");
                    GrvPrint.Visible = true;
                }
                else if (ddlDocumentFormattobeUsed.SelectedValue.ToString().Trim().ToUpper() == "4")
                {
                    dt.Rows.Clear();
                    dt.Rows.Add("GATEPASS");
                    GrvPrint.Visible = true;
                }
                else
                {
                    dt.Rows.Clear();
                    GrvPrint.Visible = false;
                }
                GrvPrint.DataSource = dt;
                GrvPrint.DataBind();
            }
            tbPEZADocumentNo.Text = ds.Tables[1].DefaultView[0]["PEZADOCUMENTNO"].ToString();
            tbGatepassNo.Text = ds.Tables[1].DefaultView[0]["GATEPASSNO"].ToString();
            ddlLOAType.ClearSelection();
            ddlLOAType.Items.FindByText(ds.Tables[1].DefaultView[0]["LOATYPE"].ToString()).Selected = true;
            {
                ddlLOANo.Items.Clear();
                ddlSuretyBondNo.Items.Clear();
                string LOAType = ddlLOAType.SelectedItem.Text;
                DataTable dt = new DataTable();
                dt = fodm.GetLOANo(LOAType);
                ddlLOANo.DataSource = dt;
                ddlLOANo.DataTextField = "LOANo";
                ddlLOANo.DataValueField = "ID";
                ddlLOANo.DataBind();
                ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));
            }
            ddlLOANo.Items.FindByText(ds.Tables[1].DefaultView[0]["LOANO"].ToString()).Selected = true;
            {
                ddlSuretyBondNo.Items.Clear();
                string LOANo = ddlLOANo.SelectedItem.Text;
                DataTable dt = new DataTable();
                dt = fodm.GetSuretyBondNo(LOANo);
                tbExpiryDate1.Text = dt.Rows[0]["ExpirationDate"].ToString();
                ddlSuretyBondNo.Items.Insert(0, new ListItem(dt.Rows[0]["SBNo"].ToString(), "0"));
                tbExpiryDate2.Text = dt.Rows[0]["ExpirationDate1"].ToString();
            }
            tbContainerNo.Text = ds.Tables[1].DefaultView[0]["CONTAINERNO"].ToString();
            tbPEZASeal.Text = ds.Tables[1].DefaultView[0]["PEZASEAL"].ToString();
            tbPlateNo.Text = ds.Tables[1].DefaultView[0]["PLATENO"].ToString();
            tb8105ControlNo.Text = ds.Tables[1].DefaultView[0]["CONTROLNO8105"].ToString();
            ddlEPPIAuthorizedSignatory.Text = ds.Tables[1].DefaultView[0]["EPPIAUTHORIZEDSIGNATORY"].ToString();
            ddlPreparedby.SelectedValue = ds.Tables[1].DefaultView[0]["ASSIGNEDUSERID"].ToString();
            ddlApprovedby.SelectedValue = ds.Tables[1].DefaultView[1]["ASSIGNEDUSERID"].ToString();
            tbAssignedto.Text = ds.Tables[1].DefaultView[1]["CREATEDBYNAME"].ToString();
            lblStatus1.Text = ds.Tables[1].DefaultView[0]["CURRENTSTATUS"].ToString();
            lblComment1.Text = ds.Tables[1].DefaultView[0]["COMMENT"].ToString();
            lblDate1.Text = ds.Tables[1].DefaultView[0]["ACTIONDATE"].ToString();
            lblStatus2.Text = ds.Tables[1].DefaultView[1]["CURRENTSTATUS"].ToString();
            lblComment2.Text = ds.Tables[1].DefaultView[1]["COMMENT"].ToString();
            lblDate2.Text = ds.Tables[1].DefaultView[1]["ACTIONDATE"].ToString();



            if (ddlPreparedby.SelectedValue != UserID || UserID != ds.Tables[1].DefaultView[0]["ASSIGNEDUSERID_CURRENT"].ToString().ToUpper())
            {
                DisableForm();
            }
            else
            {
                BtnConfirm1.Enabled = true;
            }

            if (ddlApprovedby.SelectedValue == UserID && ddlApprovedby.SelectedValue == ds.Tables[1].DefaultView[0]["ASSIGNEDUSERID_CURRENT"].ToString().ToUpper())
            {
                DisableForm();
                BtnConfirm2.Enabled = true;
            }
        }
    }

    private void DisableForm()
    {
        ddlDocumentFormattobeUsed.Enabled = false;
        tbPEZADocumentNo.Enabled = false;
        tbGatepassNo.Enabled = false;
        ddlLOAType.Enabled = false;
        ddlLOANo.Enabled = false;
        tbContainerNo.Enabled = false;
        tbPEZASeal.Enabled = false;
        tbPlateNo.Enabled = false;
        tb8105ControlNo.Enabled = false;
        ddlEPPIAuthorizedSignatory.Enabled = false;
        ddlApprovedby.Enabled = false;
        BtnConfirm1.Enabled = false;
        BtnConfirm2.Enabled = false;
        BtnSave.Enabled = false;
    }

    protected void GrvPrint_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    e.Row.Cells[0].Visible = false;
        //    for (int colIndex = 1; colIndex < e.Row.Cells.Count; colIndex++)
        //    {
        //        string cellText = HttpUtility.HtmlDecode(e.Row.Cells[colIndex].Text).Trim();
        //        if (string.IsNullOrEmpty(cellText))
        //        {
        //            e.Row.Visible = false;
        //        }
        //    }
        //}
    }
}