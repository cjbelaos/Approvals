using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FarmOutDocuments : System.Web.UI.Page
{
    private static readonly FarmOutRequestFormMaintenance frfm = new FarmOutRequestFormMaintenance();
    private static readonly FarmOutDocumentsMaintenance fodm = new FarmOutDocumentsMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    private static readonly FarmOutDocumentDetails fdd = new FarmOutDocumentDetails();
    private static readonly Printed8112 p8112 = new Printed8112();
    public static string UserID;
    public static string UserName;
    public static string ControlNo;
    public bool isSaved;

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

                //GetDocumentFormattobeUsed();
                //GetEPPIAuthorizedSignatory();
                //GetPEZASignatory();
                //GetPreparedby();
                
                //ddlPreparedby.SelectedValue = UserID;

                if (Request.QueryString["controlno"] != null)
                {
                    GetDocumentFormattobeUsed();
                    GetEPPIAuthorizedSignatory();
                    GetPEZASignatory();
                    GetPreparedby();

                    BtnSave.Enabled = true;
                    tbFarmOutControlNo.Text = Request.QueryString["controlno"].ToString();

                    bool isCancelled = maint.CheckIfCancelled(tbFarmOutControlNo.Text);
                    if (isCancelled == true)
                    {
                        BtnCancel.Visible = false;
                        BtnPrintRF.Visible = false;

                    }
                    else
                    {
                        BtnCancel.Visible = true;
                    }

                    isSaved = fodm.FarmOutDocumentsControlNoChecking(tbFarmOutControlNo.Text);
                    if (isSaved == true)
                    {
                        GetFarmOutDocument();
                        bool isFinish = maint.FinishTaskChecking(tbFarmOutControlNo.Text);
                        if (isFinish == true)
                        {
                            BtnPrintRF.Visible = true;
                            string ControlNo = tbFarmOutControlNo.Text;
                            DataTable dt = frfm.GetFiles(ControlNo);
                            if (dt.Rows.Count > 0)
                            {
                                gvFiles.DataSource = dt;
                                gvFiles.DataBind();
                                divFiles.Visible = true;
                            }
                        }
                        else
                        {
                            BtnPrintRF.Visible = false;
                        }
                    }
                    else
                    {
                        ddlPreparedby.SelectedValue = UserID;
                    }
                }
                else
                {
                    GetDocumentFormattobeUsed();
                    GetEPPIAuthorizedSignatory();
                    GetPEZASignatory();
                    GetPreparedby();

                    ddlPreparedby.SelectedValue = UserID;
                    BtnConfirm1.Enabled = false;
                    LnkBtnView.Visible = false;
                }

                LoginDetails login = new LoginDetails();
                login.username = Session["UserID"].ToString();
                bool bypass = maint.CheckIfBypassAccount(login);
                if (bypass == true)
                {
                    EnableControl();
                }
            }
        }
        (this.Master as MasterPage2).GetMyTasks();
    }

    protected void ddlDocumentFormattobeUsed_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8106" || ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8112")
        {
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

            GetCtrlNoPrinted8112();

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "GetControlNoPrinted8112();", true);
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
                fodm.SaveFarmOutDocumentsApproval(ControlNo, Preparedby, Approvedby, UserID);
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
        BtnReassignTask.Visible = false;
        FarmOutDocumentDetails fod = new FarmOutDocumentDetails();
        fod.CONTROLNO = tbFarmOutControlNo.Text;
        DataTable dt = maint.GetAssignedForRequestChange(fod);
        tbAssigned.Text = dt.Rows[0]["APOACCOUNT"].ToString();
        tbAssignedto.Text = dt.Rows[0]["NAME"].ToString();
        tbWorkFlowID.Text = "2";
        tbApproverID.Text = "1";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnConfirm2_OnClick(object sender, EventArgs e)
    {
        tbWorkFlowID.Text = "2";
        tbApproverID.Text = "2";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnApprove_OnClick(object sender, EventArgs e)
    {
        isSaved = fodm.FarmOutDocumentsControlNoChecking(tbFarmOutControlNo.Text);
        if (isSaved == true)
        {
            LCApproval la = new LCApproval();
            la.ControlNo = tbFarmOutControlNo.Text;
            la.WorkFlowID = tbWorkFlowID.Text;
            la.ApproverID = tbApproverID.Text;
            la.Comment = tbComment.Text;

            if (tbApproverID.Text == "1")
            {
                la.UserID = ddlPreparedby.SelectedValue;
            }
            else
            {
                la.UserID = ddlApprovedby.SelectedValue;
            }
            fodm.Approval(la);

            if (tbApproverID.Text == "1")
            {
                EmailDetails ed = new EmailDetails();
                ed.CONTROLNO = tbFarmOutControlNo.Text;
                ed.FROM_EMAIL = ddlPreparedby.SelectedValue;
                ed.TO_EMAIL = ddlApprovedby.SelectedValue;
                ed.EMAILTYPE = "Approval";
                ed.COMMENT = tbComment.Text;
                maint.SendEmail(ed);
            }
            else
            {
                EmailDetails ed = new EmailDetails();
                ed.CONTROLNO = tbFarmOutControlNo.Text;
                ed.FROM_EMAIL = ddlApprovedby.SelectedValue;
                ed.TO_EMAIL = maint.GetRequestCreator(tbFarmOutControlNo.Text);
                maint.SendEmailRequestApproved(ed);
            }
            
            GetFarmOutDocument();
            DisableForm();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ApprovedAlert();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ConfirmFailedAlert();", true);
        }
    }

    protected void BtnRequestChange_OnClick(object sender, EventArgs e) 
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalRequestChange').modal('show');", true);
    }

    protected void BtnSaveRequestChange_OnClick(object sender, EventArgs e)
    {
        LCApproval la = new LCApproval();
        la.ControlNo = tbFarmOutControlNo.Text;
        la.WorkFlowID = tbWorkFlowID.Text;
        la.ApproverID = tbApproverID.Text;
        la.Comment = tbRequestChangeComment.Text;

        if (tbApproverID.Text == "1")
        {
            la.UserID = ddlPreparedby.SelectedValue;
        }
        else
        {
            la.UserID = ddlApprovedby.SelectedValue;
        }
        fodm.RequestChange(la);

        EmailDetails ed = new EmailDetails();
        ed.CONTROLNO = tbFarmOutControlNo.Text;

        if (tbApproverID.Text == "1")
        {
            ed.FROM_EMAIL = ddlPreparedby.SelectedValue;
            ed.TO_EMAIL = maint.GetRequestCreator(tbFarmOutControlNo.Text);
        }
        else
        {
            ed.FROM_EMAIL = ddlApprovedby.SelectedValue;
            ed.TO_EMAIL = ddlPreparedby.SelectedValue;
        }

        ed.EMAILTYPE = "Request Change";
        ed.COMMENT = tbRequestChangeComment.Text;
        maint.SendEmail(ed);

        GetFarmOutDocument();
        DisableForm();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
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
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SelectReassignToAlert();", true);
        }
        else
        {
            LCApproval la = new LCApproval();
            la.ControlNo = tbFarmOutControlNo.Text;
            la.WorkFlowID = tbWorkFlowID.Text;
            la.ApproverID = tbApproverID.Text;
            la.Comment = tbReassigntoComment.Text;
            la.UserID = ddlApprovedby.SelectedValue;
            string Reassignto = ddlReassignto.SelectedValue;
            fodm.ReassignTask(la, Reassignto);

            EmailDetails ed = new EmailDetails();
            ed.CONTROLNO = tbFarmOutControlNo.Text;
            ed.FROM_EMAIL = ddlApprovedby.SelectedValue;
            ed.TO_EMAIL = ddlReassignto.SelectedValue;
            ed.EMAILTYPE = "Re-assign";
            ed.COMMENT = tbReassigntoComment.Text;
            maint.SendEmail(ed);

            GetFarmOutDocument();
            DisableForm();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
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
            ddlDocumentFormattobeUsed.SelectedValue = ds.Tables[1].DefaultView[0]["DOCUMENTFORMAT"].ToString();
            {
                if (ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8106" || ddlDocumentFormattobeUsed.SelectedValue == "PEZA FORM 8112")
                {
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

    private void EnableControl()
    {
        tbLOANo.Visible = true;
        tbSBNo.Visible = true;
        tbExpiryDate1.Visible = true;
        tbExpiryDate2.Visible = true;

        tbFarmOutControlNo.Enabled = true;
        ddlDocumentFormattobeUsed.Enabled = true;
        tbPEZADocumentNo.Enabled = true;
        tbGatepassNo.Enabled = true;
        tbLOANo.Enabled = true;
        tbSBNo.Enabled = true;
        tbExpiryDate1.Enabled = true;
        tbExpiryDate2.Enabled = true;
        tbContainerNo.Enabled = true;
        tbPEZASeal.Enabled = true;
        tbPlateNo.Enabled = true;
        tb8105ControlNo.Enabled = true;
        ddlEPPIAuthorizedSignatory.Enabled = true;
        tbPEZAExaminerSignatory.Enabled = true;
        tbPEZAOICSignatory.Enabled = true;
        ddlPreparedby.Enabled = true;
        ddlApprovedby.Enabled = true;
        BtnConfirm1.Enabled = true;
        BtnConfirm2.Enabled = true;
        BtnSave.Enabled = true;
    }

    protected void GrvPrint_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button button = (Button)e.Row.FindControl("BtnPrint");
            if (maint.CheckAuthorization(Session["UserID"].ToString()) == true && maint.CheckIfCancelled(tbFarmOutControlNo.Text) == false)
            {
                button.Enabled = true;
            }
            else
            {
                button.Enabled = false;
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

            string FullName = ddlPreparedby.SelectedItem.ToString();
            string[] Names = FullName.Split(' ');
            for (int i = 0; i < Names.Length - 1; i++)
            {
                Names[i] = Names[i].Substring(0, 1);
            }
            int p = Names.Length - 1 ;
            Names[p] = " " + Names[p];
            FullName = string.Join(".", Names);

            string FullName2 = ddlApprovedby.SelectedItem.ToString();
            string[] Names2 = FullName2.Split(' ');
            for (int i = 0; i < Names2.Length - 1; i++)
            {
                Names2[i] = Names2[i].Substring(0, 1);
            }
            int a = Names2.Length - 1;
            Names2[a] = " " + Names2[a];
            FullName2 = string.Join(".", Names2);

            Session["PreparedBy"] = FullName;
            Session["ApprovedBy"] = FullName2;

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
            if (dt3.Rows.Count > 0)
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

            fdd.CONTROLNO = tbFarmOutControlNo.Text; 
            DataTable dt4 = maint.GetMultipleUOM(fdd);
            if (dt4.Rows.Count > 0)
            {
                if (dt4.Rows[0]["UnitOfMeasurement"].ToString().Length == 0)
                {
                    Session["UOM"] = "";
                }
                else
                {
                    Session["UOM"] = dt4.Rows[0]["UnitOfMeasurement"].ToString();
                }
            }
            else
            {
                Session["UOM"] = "";
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

            fdd.CONTROLNO = tbFarmOutControlNo.Text;
            DataTable dt2 = maint.GetMultipleUOM(fdd);
            if (dt2.Rows.Count > 0)
            {
                if (dt2.Rows[0]["UnitOfMeasurement"].ToString().Length == 0)
                {
                    Session["UOM"] = "";
                }
                else
                {
                    Session["UOM"] = dt2.Rows[0]["UnitOfMeasurement"].ToString();
                }
            }
            else
            {
                Session["UOM"] = "";
            }

            string Date = txtDate.Text;
            var parsedDate = DateTime.Parse(Date);
            Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();

            Response.Redirect("PEZA8110Print.aspx" + "?controlno=" + ControlNo);
        }

        else if (lblPrintTitle.Text == "Print PEZA Form 8112")
        {
            Session["ControlNo"] = tbFarmOutControlNo.Text;
            Session["ControlNo"] = tbFarmOutControlNo.Text;

            string ControlNos;

            if (string.IsNullOrEmpty(hfControlNo.Value))
            {
                ControlNos = tbFarmOutControlNo.Text;
            }
            else
            {
                ControlNos = tbFarmOutControlNo.Text + "," + hfControlNo.Value;
                ControlNos = ControlNos.Replace("','", ",");
            }

            Printed8112 p8112 = new Printed8112();
            p8112.CONTROLNO = tbFarmOutControlNo.Text;
            p8112.SUBCONTROLNO = ControlNos;
            p8112.USERID = UserID;
            maint.AddPrinted8112(p8112);


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

            Response.Redirect("PEZA8112Print.aspx" + "?controlno=" + ControlNos);
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

    private void GetCtrlNoPrinted8112()
    {
        p8112.CONTROLNO = tbFarmOutControlNo.Text;
        DataTable dt = maint.GetCtrlNoPrinted8112(p8112);
        if (dt.Rows.Count > 0)
        {
            if (tbFarmOutControlNo.Text == dt.Rows[0]["PRINTEDCONTROLNO"].ToString())
            {
                hfControlNo.Value = "";
            }
            else
            {
                hfControlNo.Value = dt.Rows[0]["PRINTEDCONTROLNO"].ToString();
            }
        }
        
    }

    private void CheckIfWithLOA()
    {
        fdd.CONTROLNO = tbFarmOutControlNo.Text;
        bool x = maint.CheckPurposeOfItemIfWithLOA(fdd);
        if (x == true)
        {
            NOLOANOSB();
        }
        else
        {
            GetLOA();
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

    protected void BtnPrintRF_Click(object sender, EventArgs e)
    {
        Response.Redirect("RequestFormPrint.aspx" + "?controlno=" + Request.QueryString["controlno"]);
    }

    protected void lblFileName_Click(object sender, EventArgs g)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;
        string FilePath = Server.MapPath("~/RelatedDocu/" + tbFarmOutControlNo.Text + "/" + lnk.Text);
        string filePath = "~/RelatedDocu/" + tbFarmOutControlNo.Text + "/" + lnk.Text;

        if (File.Exists(FilePath))
        {
            Response.Redirect(filePath);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "FileNotExistAlert();", true);
        }
    }

    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalCancel').modal('show');", true);
    }

    protected void BtnCancelRequest_Click(object sender, EventArgs e)
    {
        if (txtReason.Text != "")
        {
            Approval a = new Approval();
            a.ControlNo = tbFarmOutControlNo.Text;
            a.Comment = txtReason.Text;
            a.UserID = UserID;
            maint.CancelRequest(a);

            Response.Redirect("FarmOutRequestForm.aspx");
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalCancel", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "NoCommentAlert();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalCancel').modal('show');", true);
        }
    }
}