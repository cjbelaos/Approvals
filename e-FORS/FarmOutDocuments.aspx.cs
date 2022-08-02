using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FarmOutDocuments : System.Web.UI.Page
{
    private static readonly FarmOutDocumentsMaintenance fodm = new FarmOutDocumentsMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    private static readonly FarmOutDocumentDetails fdd = new FarmOutDocumentDetails();
    public static string UserID;
    public static string UserName;
    public static string ControlNo;

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

                GetDocumentFormattobeUsed();
                GetEPPIAuthorizedSignatory();
                GetPEZASignatory();
                GetPreparedby();

                if (Request.QueryString["controlno"] != null)
                {
                    BtnSave.Enabled = true;
                    tbFarmOutControlNo.Text = Request.QueryString["controlno"].ToString();
                    CheckIfWithLOA();
                    if (fodm.FarmOutDocumentsControlNoChecking(tbFarmOutControlNo.Text) == true)
                    {
                        GetFarmOutDocument();
                    }
                    ddlPreparedby.SelectedValue = UserID;
                }
                else
                {
                    LnkBtnView.Visible = false;
                }
            }
        }
    }

    protected void ddlDocumentFormattobeUsed_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8106" || ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8112")
        {
            GetLOA();
            CheckIfWithLOA();
        }
        else
        {
            NOLOANOSB();
        }

        DataTable dt = new DataTable();

        dt.Columns.Add("Task", typeof(string));
        dt.Rows.Add(ddlDocumentFormattobeUsed.SelectedValue);
        if (ddlDocumentFormattobeUsed.SelectedValue != "GATEPASS" && ddlDocumentFormattobeUsed.SelectedValue != "")
        {
            dt.Rows.Add("GATEPASS");
            GrvPrint.Visible = true;
        }
        else if (ddlDocumentFormattobeUsed.SelectedValue == "GATEPASS")
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
            lblPrintTitle.Text = "Print Gatepass";
            divControlNo.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalPrint').modal('show');", true);
            
        }

        else if (g.CommandName.Equals("Print") && g.CommandArgument.Equals("PEZA FORM 8106"))
        {
            lblPrintTitle.Text = "Print PEZA Form 8106";
            divControlNo.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalPrint').modal('show');", true);
        }

        else if (g.CommandName.Equals("Print") && g.CommandArgument.Equals("PEZA FORM 8110"))
        {
            lblPrintTitle.Text = "Print PEZA Form 8110";
            divControlNo.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalPrint').modal('show');", true);
        }

        else if (g.CommandName.Equals("Print") && g.CommandArgument.Equals("PEZA FORM 8112"))
        {
            lblPrintTitle.Text = "Print PEZA Form 8112";
            divControlNo.Visible = true;

            DataTable dt = maint.GetControlNoOf8112WithSameLOA(tbLOANo.Text, tbFarmOutControlNo.Text);
            ddlControlNo.DataSource = dt;
            ddlControlNo.DataTextField = "CONTROLNO";
            ddlControlNo.DataValueField = "CONTROLNO";
            ddlControlNo.DataBind();
            ddlControlNo.Items.Insert(0, new ListItem("Choose...", ""));

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalPrint').modal('show');", true);
        }
    }

    private void GetPEZASignatory()
    {
        DataSet ds = new DataSet();
        ds = fodm.GetPEZASignatory();
        tbPEZAExaminerSignatory.Text = ds.Tables[0].DefaultView[0]["NAME"].ToString();
        tbPEZAOICSignatory.Text = ds.Tables[1].DefaultView[0]["NAME"].ToString();
    }
   
    private void GetDocumentFormattobeUsed()
    {
        DataTable dt = new DataTable();
        dt = fodm.GetDocumentFormattobeUsed();
        ddlDocumentFormattobeUsed.DataSource = dt;
        ddlDocumentFormattobeUsed.DataTextField = "Task";
        ddlDocumentFormattobeUsed.DataValueField = "Task";
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
        ddlReassignto.DataTextField = "EMPLOYEENAME";
        ddlReassignto.DataValueField = "APOACCOUNT";
        ddlReassignto.DataBind();
        ddlReassignto.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetPreparedby()
    {
        DataSet ds = new DataSet();
        ds = fodm.GetPreparedby();
        ddlPreparedby.DataSource = ds.Tables[0];
        ddlPreparedby.DataTextField = "Name";
        ddlPreparedby.DataValueField = "APOAccount";
        ddlPreparedby.DataBind();
        ddlPreparedby.Items.Insert(0, new ListItem("Choose...", ""));
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

    protected void BtnSave_OnClick(object sender, EventArgs e)
    {
        if (ddlDocumentFormattobeUsed.SelectedValue != "" && ddlEPPIAuthorizedSignatory.SelectedValue != "" && ddlPreparedby.SelectedValue != "" && ddlApprovedby.SelectedValue != "" )
        {
            string ControlNo = tbFarmOutControlNo.Text;
            string DocumentFormat = ddlDocumentFormattobeUsed.SelectedValue;
            string PEZADocumentNo = tbPEZADocumentNo.Text.ToUpper();
            string GatepassNo = tbGatepassNo.Text.ToUpper();
            string LOANo = tbLOANo.Text;
            string LOAExpiryDate;
            if (tbExpiryDate1.Text == "")
            {
                LOAExpiryDate = "";
            }
            else
            {
                LOAExpiryDate = tbExpiryDate1.Text;
            }
            string SuretyBondNo = tbSBNo.Text;
            string SuretyExpiryDate;
            if (tbExpiryDate2.Text == "")
            {
                SuretyExpiryDate = "";
            }
            else
            {
                SuretyExpiryDate = tbExpiryDate2.Text;
            }
            string ContainerNo = tbContainerNo.Text.ToUpper();
            string PEZASeal = tbPEZASeal.Text.ToUpper();
            string PlateNo = tbPlateNo.Text.ToUpper();
            string ControlNo8105 = tb8105ControlNo.Text.ToUpper();
            string EPPIAuthorizedSignatory = ddlEPPIAuthorizedSignatory.Text;
            string PEZAExaminerSignatory = tbPEZAExaminerSignatory.Text;
            string PEZAOICSignatory = tbPEZAOICSignatory.Text;
            fodm.SaveFarmOutDocuments(
                    ControlNo,
                    DocumentFormat,
                    PEZADocumentNo,
                    GatepassNo,
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
        //Page.Response.Redirect(Page.Request.Url.ToString(), true);
        GetFarmOutDocument();
        DisableForm();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
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
        Page.Response.Redirect(Page.Request.Url.ToString(), true);
        //DisableForm();
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "RequestChangeAlert();", true);
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
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SelectReassignToAlert();", true);
        }
        else
        {
            string ControlNo = tbFarmOutControlNo.Text;
            string WorkFlowID = tbWorkFlowID.Text;
            string ApproverID = tbApproverID.Text;
            string ApprovalComments = tbComment.Text;
            string Reassignto = ddlReassignto.SelectedValue;
            fodm.ReassignTask(ControlNo, WorkFlowID, ApproverID, ApprovalComments, Reassignto, UserID);
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
            //DisableForm();
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ReassignAlert();", true);
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
            ddlDocumentFormattobeUsed.SelectedValue = ds.Tables[1].DefaultView[0]["DOCUMENTFORMAT"].ToString();
            {
                if (ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8106" || ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8112")
                {
                    GetLOA();
                    CheckIfWithLOA();
                }
                else
                {
                    NOLOANOSB();
                }

                DataTable dt = new DataTable();

                dt.Columns.Add("Task", typeof(string));
                dt.Rows.Add(ddlDocumentFormattobeUsed.SelectedValue);
                if (ddlDocumentFormattobeUsed.SelectedValue != "GATEPASS" && ddlDocumentFormattobeUsed.SelectedValue != "")
                {
                    dt.Rows.Add("GATEPASS");
                    GrvPrint.Visible = true;
                }
                else if (ddlDocumentFormattobeUsed.SelectedValue == "GATEPASS")
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
            tbLOANo.Text = ds.Tables[1].DefaultView[0]["LOANO"].ToString();
            tbExpiryDate1.Text = ds.Tables[1].DefaultView[0]["LOAEXPIRYDATE"].ToString();
            tbSBNo.Text = ds.Tables[1].DefaultView[0]["SURETYBONDNO"].ToString();
            tbExpiryDate2.Text = ds.Tables[1].DefaultView[0]["SURETYEXPIRYDATE"].ToString();
            tbContainerNo.Text = ds.Tables[1].DefaultView[0]["CONTAINERNO"].ToString();
            tbPEZASeal.Text = ds.Tables[1].DefaultView[0]["PEZASEAL"].ToString();
            tbPlateNo.Text = ds.Tables[1].DefaultView[0]["PLATENO"].ToString();
            tb8105ControlNo.Text = ds.Tables[1].DefaultView[0]["CONTROLNO8105"].ToString();
            ddlEPPIAuthorizedSignatory.Text = ds.Tables[1].DefaultView[0]["EPPIAUTHORIZEDSIGNATORY"].ToString();
            ddlPreparedby.SelectedValue = ds.Tables[1].DefaultView[0]["ASSIGNEDUSERID"].ToString();
            ddlApprovedby.SelectedValue = ds.Tables[1].DefaultView[1]["ASSIGNEDUSERID"].ToString();
            tbAssignedto.Text = ds.Tables[1].DefaultView[1]["CREATEDNAME"].ToString();
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
        tbLOAType.Enabled = false;
        tbLOANo.Enabled = false;
        tbSBNo.Enabled = false;        
        tbContainerNo.Enabled = false;
        tbPEZASeal.Enabled = false;
        tbPlateNo.Enabled = false;
        tb8105ControlNo.Enabled = false;
        ddlEPPIAuthorizedSignatory.Enabled = false;
        ddlPreparedby.Enabled = false;
        ddlApprovedby.Enabled = false;
        BtnConfirm1.Enabled = false;
        BtnConfirm2.Enabled = false;
        BtnSave.Enabled = false;
    }

    protected void GrvPrint_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button button = (Button)e.Row.FindControl("BtnPrint");
            if (maint.CheckAuthorization(Session["UserID"].ToString()) == false)
            {
                button.Enabled = false;
            }
            else
            {
                button.Enabled = true;
            }
        }
    }

    protected void LnkBtnView_Click(object sender, EventArgs e)
    {
        SessionForm();
        Response.Redirect("FarmOutRequestForm.aspx" + "?controlno=" + tbFarmOutControlNo.Text);
    }

    protected void BtnDone_Click(object sender, EventArgs e)
    {
        if (lblPrintTitle.Text == "Print Gatepass")
        {
            ControlNo = tbFarmOutControlNo.Text;
            Session["ControlNo"] = ControlNo;

            string Date = txtDate.Text;
            var parsedDate = DateTime.Parse(Date);
            Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();

            FarmOutDetails fo = new FarmOutDetails();
            fo.ControlNo = ControlNo;

            DataTable dt = maint.GetFarmOutDetailsCreatorandApprover(fo);
            if (dt.Rows.Count > 0)
            {
                Session["PreparedBy"] = dt.Rows[0]["CREATEDBY"].ToString();
                Session["ApprovedBy"] = dt.Rows[0]["EPPIAUTHORIZEDSIGNATORY"].ToString();
            }
            else
            {
                Session["PreparedBy"] = "";
                Session["ApprovedBy"] = "";
            }

            DataTable dt1 = maint.GetTotalQuantityWithUnitOfMeasurement(fo);
            if (dt1.Rows.Count > 0)
            {
                Session["TotalQuantity"] = dt1.Rows[0]["TotalQuantity"].ToString();
            }
            else
            {
                Session["TotalQuantity"] = "";
            }
            
            DataTable dt2 = fodm.GetItemContainers(ControlNo);
            if (dt2.Rows.Count > 0)
            {
                Session["ContainerNo"] = dt2.Rows[0]["ContainerNo"].ToString();
            }
            else
            {
                Session["ContainerNo"] = "";
            }
            

            DataTable dt3 = fodm.GetItemSealNo(ControlNo);
            if (dt.Rows.Count > 0)
            {
                if (dt3.Rows[0]["SealNo"].ToString().Length == 0)
                {
                    Session["SealNo"] = "";
                }
                else
                {
                    Session["SealNo"] = dt3.Rows[0]["SealNo"].ToString();
                }
            }
            else
            {
                Session["SealNo"] = "";
            }
            
            bool WithItemContainer = fodm.CheckIfWithItemContainer(ControlNo);
            Session["WithItemContainer"] = WithItemContainer.ToString();

            Response.Redirect("GatepassPrint.aspx" + "?controlno=" + ControlNo);
        }
        else if (lblPrintTitle.Text == "Print PEZA Form 8106")
        {
            ControlNo = tbFarmOutControlNo.Text;
            Session["ControlNo"] = ControlNo;

            DataTable dt1 = fodm.GetAuthorizedOfficial(ddlEPPIAuthorizedSignatory.SelectedValue);
            if (dt1.Rows.Count > 0)
            {
                Session["AuthorizedOffical"] = dt1.Rows[0]["AuthorizedOfficial"].ToString();
            }
            else
            {
                Session["AuthorizedOffical"] = "";
            }

            DataTable dt2 = fodm.GetItemContainers(ControlNo);
            if (dt1.Rows.Count > 0)
            {
                Session["ContainerNo"] = "CONTAINER# " + dt2.Rows[0]["ContainerNo"].ToString();
            }
            else
            {
                Session["ContainerNo"] = "";
            }
            
            DataTable dt3 = fodm.GetItemSealNo(ControlNo);
            if (dt1.Rows.Count > 0)
            {
                if (dt3.Rows[0]["SealNo"].ToString().Length == 0)
                {
                    Session["SealNo"] = "";
                }
                else
                {
                    Session["SealNo"] = "SEAL# " + dt3.Rows[0]["SealNo"].ToString();
                }
            }
            else
            {
                Session["SealNo"] = "";
            }
            
            string Date = txtDate.Text;
            var parsedDate = DateTime.Parse(Date);
            Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();

            bool WithContainer = fodm.CheckIfWithContainer(ControlNo);
            Session["WithContainer"] = WithContainer.ToString();

            bool WithLOA = fodm.CheckIfWithLOA(ControlNo);
            Session["WithLOA"] = WithLOA.ToString();

            bool WithItemContainer = fodm.CheckIfWithItemContainer(ControlNo);
            Session["WithItemContainer"] = WithItemContainer.ToString();

            Response.Redirect("PEZA8106Print.aspx" + "?controlno=" + ControlNo);
        }

        else if (lblPrintTitle.Text == "Print PEZA Form 8110")
        {
            ControlNo = tbFarmOutControlNo.Text;
            Session["ControlNo"] = ControlNo;

            DataTable dt = fodm.GetAuthorizedOfficial(ddlEPPIAuthorizedSignatory.SelectedValue);
            if (dt.Rows.Count > 0)
            {
                Session["AuthorizedOffical"] = dt.Rows[0]["AuthorizedOfficial"].ToString();
            }
            else
            {
                Session["AuthorizedOffical"] = "";
            }

            FarmOutDetails fo = new FarmOutDetails();
            fo.ControlNo = ControlNo;

            DataTable dt1 = maint.GetTotalQuantityWithUnitOfMeasurement(fo);
            if (dt1.Rows.Count > 0)
            {
                Session["TotalQuantity"] = dt1.Rows[0]["TotalQuantity"].ToString();
            }
            else
            {
                Session["TotalQuantity"] = "";
            }
            
            string Date = txtDate.Text;
            var parsedDate = DateTime.Parse(Date);
            Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();

            Response.Redirect("PEZA8110Print.aspx" + "?controlno=" + ControlNo);
        }

        else if (lblPrintTitle.Text == "Print PEZA Form 8112")
        {
            Session["ControlNo"] = tbFarmOutControlNo.Text;

            string ControlNos;

            if (string.IsNullOrEmpty(hfControlNo.Value))
            {
                ControlNos = tbFarmOutControlNo.Text;
            }
            else
            {
                ControlNos = hfControlNo.Value;
                ControlNos = ControlNos.Replace("','", ",");
            }

            Session["ControlNoS"] = ControlNos;

            Session["Dates"] = maint.Get8112Dates(ControlNos);

            DataTable dt1 = fodm.GetAuthorizedOfficial(ddlEPPIAuthorizedSignatory.SelectedValue);
            if (dt1.Rows.Count > 0)
            {
                Session["AuthorizedOffical"] = dt1.Rows[0]["AuthorizedOfficial"].ToString();
            }
            else
            {
                Session["AuthorizedOffical"] = "";
            }
            
            FarmOutDetails fo = new FarmOutDetails();
            fo.ControlNo = ControlNo;

            string Date = txtDate.Text;
            var parsedDate = DateTime.Parse(Date);
            Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();

            Response.Redirect("PEZA8112Print.aspx" + "?controlno=" + ControlNo);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalPrint", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        }
    }

    private void GetLOA()
    {
        divLOA.Visible = true;
        divLOAExp.Visible = true;
        divSB.Visible = true;
        divSBExp.Visible = true;

        FarmOutDetails fo = new FarmOutDetails();
        fo.ControlNo = tbFarmOutControlNo.Text;

        DataTable dt = maint.GetLOAofSupplierInControlNo(fo);
        if (dt.Rows.Count > 0)
        {
            tbLOANo.Text = dt.Rows[0]["LOANO"].ToString();
            tbExpiryDate1.Text = dt.Rows[0]["LOAEXP"].ToString();
            tbSBNo.Text = dt.Rows[0]["SBNO"].ToString();
            tbExpiryDate2.Text = dt.Rows[0]["SBEXP"].ToString();
        }
        else
        {
            tbLOANo.Text = "";
            tbExpiryDate1.Text = "";
            tbSBNo.Text = "";
            tbExpiryDate2.Text = "";
        }
    }

    private void NOLOANOSB()
    {
        tbLOANo.Text = "";
        tbExpiryDate1.Text = "";
        tbSBNo.Text = "";
        tbExpiryDate2.Text = "";

        divLOA.Visible = false;
        divSB.Visible = false;
        divLOAExp.Visible = false;
        divSBExp.Visible = false;
    }

    private void CheckIfWithLOA()
    {
        fdd.CONTROLNO = tbFarmOutControlNo.Text;
        bool x = maint.CheckPurposeOfItemIfWithLOA(fdd);
        if (x == true)
        {
            NOLOANOSB();
        }
    }

    public void SessionForm()
    {
        Session["ControlNo"] = tbFarmOutControlNo.Text;
        Session["DocFormat"] = ddlDocumentFormattobeUsed.SelectedValue;
        Session["PEZADocNo"] = tbPEZADocumentNo.Text;
        Session["GP"] = tbGatepassNo.Text;
        Session["LOA"] = tbLOANo.Text;
        Session["LOAExp"] = tbExpiryDate1.Text;
        Session["SB"] = tbSBNo.Text;
        Session["SBExp"] = tbExpiryDate2.Text;
        Session["CONT"] = tbContainerNo.Text;
        Session["PEZASeal"] = tbPEZASeal.Text;
        Session["PlateNo"] = tbPlateNo.Text;
        Session["8105"] = tb8105ControlNo.Text;
        Session["Authorize"] = ddlEPPIAuthorizedSignatory.SelectedValue;
        Session["Examiner"] = tbPEZAExaminerSignatory.Text;
        Session["OIC"] = tbPEZAOICSignatory.Text;
        Session["Prepared"] = ddlPreparedby.SelectedValue;
        Session["Approved"] = ddlApprovedby.SelectedValue;
    }

    public void GetSessionForm()
    {
        if (Session["ControlNo"] != null)
        {
            tbFarmOutControlNo.Text = Session["ControlNo"].ToString();
        }
        if (Session["DocFormat"] != null)
        {
            ddlDocumentFormattobeUsed.SelectedValue = Session["DocFormat"].ToString();
        }
        if (Session["PEZADocNo"] != null)
        {
            tbPEZADocumentNo.Text = Session["PEZADocNo"].ToString();
        }
        if (Session["GP"] != null)
        {
            tbGatepassNo.Text = Session["GP"].ToString();
        }
        if (Session["LOA"] != null)
        {
            tbLOANo.Text = Session["LOA"].ToString();
        }
        if (Session["LOAExp"] != null)
        {
            tbExpiryDate1.Text = Session["LOAExp"].ToString();
        }
        if (Session["SB"] != null)
        {
            tbSBNo.Text = Session["SB"].ToString();
        }
        if (Session["SBExp"] != null)
        {
            tbExpiryDate2.Text = Session["SBExp"].ToString();
        }
        if (Session["CONT"] != null)
        {
            tbContainerNo.Text = Session["CONT"].ToString();
        }
        if (Session["PEZASeal"] != null)
        {
            tbPEZASeal.Text = Session["PEZASeal"].ToString();
        }
        if (Session["PlateNo"] != null)
        {
            tbPlateNo.Text = Session["PlateNo"].ToString();
        }
        if (Session["8105"] != null)
        {
            tb8105ControlNo.Text = Session["8105"].ToString();
        }
        if (Session["Authorize"] != null)
        {
            ddlEPPIAuthorizedSignatory.SelectedValue = Session["Authorize"].ToString();
        }
        if (Session["Examiner"] != null)
        {
            tbPEZAExaminerSignatory.Text = Session["Examiner"].ToString();
        }
        if (Session["OIC"] != null)
        {
            tbPEZAOICSignatory.Text = Session["OIC"].ToString();
        }
        if (Session["Prepared"] != null)
        {
            ddlPreparedby.Text = Session["Prepared"].ToString();
        }
        if (Session["Approved"] != null)
        {
            ddlApprovedby.Text = Session["Approved"].ToString();
        }

    }
}