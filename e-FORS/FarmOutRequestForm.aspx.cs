using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Globalization;
using System.Web;
using System.IO;
using System.Web.Services;

public partial class Default : System.Web.UI.Page
{
    private static readonly FarmOutRequestFormMaintenance frfm = new FarmOutRequestFormMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    private static readonly Items items = new Items();
    private static readonly FarmOutDetails fod = new FarmOutDetails();
    public static string UserID;
    public static string UserName;

    public static string Message;

    public static string ItemNoHelpBlock;
    public static string ItemDescriptionHelpBlock;
    public static string QuantityHelpBlock;
    public static string UnitofMeasurementHelpBlock;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            UserID = Session["UserID"].ToString();
            UserName = Session["UserName"].ToString();

            if (!Page.IsPostBack)
            {
                GetUserInfo();
                AddDivision();
                AddNatureofItem();
                AddTransferto();
                AddTypeofItem();
                AddClassificationofItem();
                AddPurposeofItem();
                AddPackagingUsed();
                AddSupplierName();
                AddModeofTransfer();
                AddTypeofTransfer();
                GetRequesteddby();
                GetCheckedby();
                GetApprovedby();
                GetItems();

                if (Request.QueryString["CONTROLNO"] != null)
                {
                    tbControlNo.Text = Request.QueryString["CONTROLNO"];
                    GetFarmOut();
                    if (frfm.FarmOutRequestFormApprovalChecking(tbControlNo.Text) == false)
                    {
                        LnkBtnBack.Visible = false;
                    }
                    else
                    {
                        LnkBtnBack.Visible = true;
                    }
                    if (tbControlNo.Text != "[AUTOMATIC]")
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "HideControlNoHelpBlock()", true);
                    }
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveTableBorder()", true);
                }
                else
                {
                    LnkBtnBack.Visible = false;
                    tbControlNo.Text = "[AUTOMATIC]";
                    GetUserInfo();
                    AddDivision();
                    AddNatureofItem();
                    AddTransferto();
                    AddTypeofItem();
                    AddClassificationofItem();
                    AddPurposeofItem();
                    AddPackagingUsed();
                    AddSupplierName();
                    AddModeofTransfer();
                    AddTypeofTransfer();
                    GetRequesteddby();
                    GetCheckedby();
                    GetApprovedby();
                    GetItems();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveTableBorder()", true);
                }
            }
        }
    }

    private void GetItems()
    {
        string ControlNo = tbControlNo.Text;
        DataTable dt = maint.GetAllItems(ControlNo);
        gvItems.DataSource = dt;
        gvItems.DataBind();
    }

    protected void BtnAdd_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
    }

    protected void BtnUpload_Click(object sender, EventArgs e)
    {
        if (tbControlNo.Text == "[AUTOMATIC]")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "InvalidCOntrolNo();", true);
        }
        else
        {
            FileDetails fd = new FileDetails();
            fd.UserID = UserID;
            fd.ControlNo = tbControlNo.Text;
            if (fuChooseFile.HasFile)
            {
                foreach (HttpPostedFile postedFile in fuChooseFile.PostedFiles)
                {
                    fd.FileName = Path.GetFileName(postedFile.FileName);
                    fd.FileType = Path.GetExtension(postedFile.FileName).ToLower();
                    fd.FilePath = Server.MapPath(Path.Combine("~/RelatedDocu/", fd.ControlNo));

                    Directory.CreateDirectory(fd.FilePath);

                    if (!Directory.Exists(fd.FilePath))
                    {
                        Directory.CreateDirectory(fd.FilePath);
                    }

                    postedFile.SaveAs(fd.FilePath + "/" + fd.FileName);

                    frfm.SaveFiles(fd);
                    GetFiles();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "UploadFailedAlert();", true);
            }
        }

    }

    private void GetFiles()
    {
        string ControlNo = tbControlNo.Text;
        DataTable dt = frfm.GetFiles(ControlNo);
        if (dt.Rows.Count > 0)
        {
            gvFiles.Visible = true;
            gvFiles.DataSource = dt;
            gvFiles.DataBind();
        }
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "RemoveTableBorder()", true);
    }

    protected string CreateFileName(FileUpload fu)
    {
        string FileName = fu.FileName.ToString();
        int Position = FileName.LastIndexOf(".");
        FileName = FileName.Remove(Position, FileName.Length - Position);
        FileName = FileName + "_" + DateTime.Now.ToString("yyMMddHHmmssfff") + Path.GetExtension(fu.FileName);
        return FileName;
    }

    protected void BtnConfirm1_OnClick(object sender, EventArgs e)
    {
        if (tbControlNo.Text == "[AUTOMATIC]")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "FailedAlert();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "AutoGeneratedControlNo()", true);
        }

        else
        {
            tbWorkFlowID.Text = "1";
            tbApproverID.Text = "1";
            BtnRequestChange.Visible = false;
            BtnReassignTask.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
        }
    }

    protected void BtnConfirm2_OnClick(object sender, EventArgs e)
    {
        tbWorkFlowID.Text = "1";
        tbApproverID.Text = "2";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnConfirm3_OnClick(object sender, EventArgs e)
    {
        tbWorkFlowID.Text = "1";
        tbApproverID.Text = "3";
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnApprove_OnClick(object sender, EventArgs e)
    {
        Approval a = new Approval();
        a.WorkFlowID = tbWorkFlowID.Text;
        a.ApproverID = tbApproverID.Text;
        a.ControlNo = tbControlNo.Text;
        a.UserID = UserID;
        a.Comment = tbComment.Text;
        maint.Approval(a);
        GetFarmOut();

        DisableControl();

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ApprovedFarmOutSuccessAlert();", true);
    }

    protected void BtnRequestChange_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalRequestChange').modal('show');", true);
    }

    protected void BtnSaveRequestChange_OnClick(object sender, EventArgs e)
    {
        Approval a = new Approval();
        a.WorkFlowID = tbWorkFlowID.Text;
        a.ApproverID = tbApproverID.Text;
        a.ControlNo = tbControlNo.Text;
        a.UserID = UserID;
        a.Comment = tbRequestChangeComment.Text;
        maint.RequestChange(a);
        DisableControl();
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "RequestChangeFarmOutSuccessAlert();", true);
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
            Approval a = new Approval();
            a.WorkFlowID = tbWorkFlowID.Text;
            a.ApproverID = tbApproverID.Text;
            a.ControlNo = tbControlNo.Text;
            a.UserID = UserID;
            a.Comment = tbRequestChangeComment.Text;
            string strReassignto = ddlReassignto.SelectedValue;
            maint.ReassignTask(a, strReassignto);
            DisableControl();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ReassignFarmOutSuccessAlert();", true);
        }
        
    }
    protected void BtnCancelReassignTask_OnClick(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modalConfirm').modal('show');", true);
    }

    protected void BtnSubmit_OnClick(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(tbID.Text))
        {
            if (tbItemNo.Text == "" && tbItemDescription.Text == "" && tbQuantity.Text == "" && tbUnitofMeasurement.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "AddItemsFailedAlert();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('.modal-backdrop').remove(); $('body').removeClass( 'modal - open' );", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
            }
            else
            {
                items.ControlNo = tbControlNo.Text;
                items.ItemCode = tbItemNo.Text;
                items.ItemDescription = tbItemDescription.Text;
                items.Quantity = tbQuantity.Text;
                items.UnitOfMeasurement = tbUnitofMeasurement.Text;
                items.Amount = tbAmount.Text;
                items.AssetNo = tbAssetNo.Text;
                items.ODNo = tbOD.Text;
                items.ContainerNo = tbContainer.Text;
                items.PEZASeal = tbPEZASeal.Text;
                items.DSRDRNo = tbDSRDRNo.Text;
                Message = maint.SaveItem(items, UserID);
                GetItems();
                ClearItemDetails();

                if (Message == "")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "AddItemsSuccessAlert();", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "AddItemsFailedAlert();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('.modal-backdrop').remove(); $('body').removeClass( 'modal - open' );", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
                }
            }
        }

        else
        {
            try
            {
                items.ID = tbID.Text;
                items.ControlNo = tbControlNo.Text;
                items.ItemCode = tbItemNo.Text;
                items.ItemDescription = tbItemDescription.Text;
                items.Quantity = tbQuantity.Text;
                items.UnitOfMeasurement = tbUnitofMeasurement.Text;
                items.Amount = tbAmount.Text;
                items.AssetNo = tbAssetNo.Text;
                items.ODNo = tbOD.Text;
                items.ContainerNo = tbContainer.Text;
                items.PEZASeal = tbPEZASeal.Text;
                items.DSRDRNo = tbDSRDRNo.Text;
                maint.UpdateItem(items, UserName);
                GetItems();
                ClearItemDetails();

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "UpdateItemsSuccessAlert();", true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
            }
        }
    }

    protected void BtnSave_OnClick(object sender, EventArgs e)
    {
        if (ddlCheckedby.SelectedValue == "" && ddlApprovedby.SelectedValue == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowApprovalHelpBlock()", true);
        }

        if (ddlCheckedby.SelectedValue == "" && ddlApprovedby.SelectedValue != "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowCheckedbyHelpBlock()", true);
        }

        if (ddlCheckedby.SelectedValue != "" && ddlApprovedby.SelectedValue == "")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowApprovedbyHelpBlock()", true);
        }

        if (ddlCheckedby.SelectedValue != "" && ddlApprovedby.SelectedValue != "")
        {
            Maintenance maint = new Maintenance();
            DataSet ds = new DataSet();
            FarmOutDetails fo = new FarmOutDetails();


            fo.ControlNo = tbControlNo.Text;
            fo.Division = ddlDivision.SelectedValue;
            fo.NatureOfItem = ddlNatureofItem.SelectedValue;
            fo.TransferTo = ddlTransferto.SelectedValue;
            fo.TypeOfItem = ddlTypeofItem.SelectedValue;
            fo.ClassificationOfItem = ddlClassificationofItem.SelectedValue;
            if (ddlPurposeofItem.SelectedValue == "Others")
            {
                fo.PurposeOfItem = tbOthers.Text;
            }
            else
            {
                fo.PurposeOfItem = ddlPurposeofItem.SelectedValue;
            }
            fo.BearerEmployeeNo = tbBearerEmployeeNo.Text;
            fo.BearerEmployeeName = tbBearerEmployeeName.Text;
            fo.RequestorEmployeeNo = tbEmployeeNo.Text;
            fo.RequestorEmployeeName = tbEmployeeName.Text;
            fo.Section = tbSection.Text;
            fo.LocalNo = tbLocalNo.Text;
            fo.DateRequested = tbDateRequested.Text;
            fo.ActualDateOfTransfer = tbActualDateofTransfer.Text;
            fo.TargetDateOfReturn = tbTargetDateofReturn.Text;
            fo.PackagingUsed = ddlPackagingUsed.SelectedValue;
            fo.SupplierName = ddlSupplierName.SelectedValue;
            fo.DestinationAddress = ddlDestinationAddress.Text;
            fo.OriginOfItem = tbOriginofItem.Text;
            fo.DeliveryReceiptNo = tbDeliveryReceiptNo.Text;
            fo.InvoiceNo = tbInvoiceNo.Text;
            fo.ContactPerson = tbContactPerson.Text;
            fo.ContactNo = tbContactNo.Text;
            fo.TelephoneNo = tbTelephoneNo.Text;
            fo.FaxNo = tbFaxNo.Text;
            fo.ModeOfTransfer = ddlModeofTransfer.SelectedValue;
            fo.TypeOfTransfer = ddlTypeofTransfer.SelectedValue;
            ds = maint.SaveFarmOutRequestForm(fo, UserID);
            tbControlNo.Text = ds.Tables[0].DefaultView[0]["CONTROLNO"].ToString();

            Approval a = new Approval();
            a.ControlNo = tbControlNo.Text;
            a.Requestedby = ddlRequestedby.SelectedValue;
            a.Checkedby = ddlCheckedby.SelectedValue;
            a.Approvedby = ddlApprovedby.SelectedValue;
            maint.SaveApproval(a);
            maint.SaveMirrorApproval(a);

            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "SaveFarmOutSuccessAlert();", true);

            BtnAdd.Enabled = true;
            BtnConfirm1.Enabled = true;

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "SaveFarmOutFailedAlert();", true);
        }
    }

    protected void GrvItems_RowCommand(object sender, GridViewCommandEventArgs g)
    {
        if (g.CommandName.Equals("EditItem"))
        {
            GridViewRow row = (GridViewRow)(((Button)g.CommandSource).NamingContainer);
            string index = g.CommandArgument.ToString();

            Label lblItemCode = (Label)row.FindControl("lblItemCode");
            Label lblItemDescription = (Label)row.FindControl("lblItemDescription");
            Label lblQuantity = (Label)row.FindControl("lblQuantity");
            Label lblUnitOfMeasurement = (Label)row.FindControl("lblUnitOfMeasurement");
            Label lblAmount = (Label)row.FindControl("lblAmount");
            Label lblAssetNo = (Label)row.FindControl("lblAssetNo");
            Label lblODNo = (Label)row.FindControl("lblODNo");
            Label lblContainerNo = (Label)row.FindControl("lblContainerNo");
            Label lblPEZASeal = (Label)row.FindControl("lblPEZASeal");
            Label lblDSRDRNo = (Label)row.FindControl("lblDSRDRNo");

            tbID.Text = index;
            tbItemNo.Text = lblItemCode.Text;
            tbItemDescription.Text = lblItemDescription.Text;
            tbQuantity.Text = lblQuantity.Text;
            tbUnitofMeasurement.Text = lblUnitOfMeasurement.Text;
            tbAmount.Text = lblAmount.Text;
            tbAssetNo.Text = lblAssetNo.Text;
            tbOD.Text = lblODNo.Text;
            tbContainer.Text = lblContainerNo.Text;
            tbPEZASeal.Text = lblPEZASeal.Text;
            tbDSRDRNo.Text = lblDSRDRNo.Text;

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
        }

        if (g.CommandName.Equals("DeleteItem"))
        {
            GridViewRow row = (GridViewRow)(((Button)g.CommandSource).NamingContainer);
            items.ID = g.CommandArgument.ToString();
            maint.DeleteItem(items);
            GetItems();
        }
    }

    private void GetUserInfo()
    {
        DataSet ds = new DataSet();
        ds = maint.GetUserInformation(UserID);
        if (ds.Tables[0].DefaultView.Count > 0)
        {
            tbEmployeeName.Text = ds.Tables[0].DefaultView[0]["FullName"].ToString();
            tbEmployeeNo.Text = ds.Tables[0].DefaultView[0]["EmployeeNo"].ToString();
            tbSection.Text = ds.Tables[0].DefaultView[0]["SectionName"].ToString();

            if (ddlRequestedby.Items.FindByValue(ds.Tables[0].DefaultView[0]["APOAccount"].ToString()) == null)
            {
                ddlRequestedby.Items.Add(new ListItem(ds.Tables[0].DefaultView[0]["FullName"].ToString(), ds.Tables[0].DefaultView[0]["APOAccount"].ToString().ToUpper()));
            }

            ddlRequestedby.SelectedValue = ds.Tables[0].DefaultView[0]["APOAccount"].ToString().ToUpper();
        }
    }

    private void AddDivision()
    {
        DataTable dt = maint.GetDivision();
        ddlDivision.DataSource = dt;
        ddlDivision.DataTextField = "Description";
        ddlDivision.DataValueField = "Description";
        ddlDivision.DataBind();
        ddlDivision.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddNatureofItem()
    {
        DataTable dt = maint.GetNatureOfItem();
        ddlNatureofItem.DataSource = dt;
        ddlNatureofItem.DataTextField = "Description";
        ddlNatureofItem.DataValueField = "Description";
        ddlNatureofItem.DataBind();
        ddlNatureofItem.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddTransferto()
    {
        DataTable dt = maint.GetTransferTo();
        ddlTransferto.DataSource = dt;
        ddlTransferto.DataTextField = "Description";
        ddlTransferto.DataValueField = "Description";
        ddlTransferto.DataBind();
        ddlTransferto.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddTypeofItem()
    {
        DataTable dt = maint.GetTypeOfItem();
        ddlTypeofItem.DataSource = dt;
        ddlTypeofItem.DataTextField = "Description";
        ddlTypeofItem.DataValueField = "Description";
        ddlTypeofItem.DataBind();
        ddlTypeofItem.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddClassificationofItem()
    {
        DataTable dt = maint.GetClassificationOfItem();
        ddlClassificationofItem.DataSource = dt;
        ddlClassificationofItem.DataTextField = "Description";
        ddlClassificationofItem.DataValueField = "Description";
        ddlClassificationofItem.DataBind();
        ddlClassificationofItem.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddPurposeofItem()
    {
        DataTable dt = maint.GetPurposeOfItem();
        ddlPurposeofItem.DataSource = dt;
        ddlPurposeofItem.DataTextField = "Description";
        ddlPurposeofItem.DataValueField = "Description";
        ddlPurposeofItem.DataBind();
        ddlPurposeofItem.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddPackagingUsed()
    {
        DataTable dt = maint.GetPackagingUsed();
        ddlPackagingUsed.DataSource = dt;
        ddlPackagingUsed.DataTextField = "Description";
        ddlPackagingUsed.DataValueField = "Description";
        ddlPackagingUsed.DataBind();
        ddlPackagingUsed.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddSupplierName()
    {
        DataTable dt = maint.GetSupplier();
        ddlSupplierName.DataSource = dt;
        ddlSupplierName.DataTextField = "SupplierName";
        ddlSupplierName.DataValueField = "SupplierName";
        ddlSupplierName.DataBind();
        ddlSupplierName.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddModeofTransfer()
    {
        DataTable dt = maint.GetModeOfTransfer();
        ddlModeofTransfer.DataSource = dt;
        ddlModeofTransfer.DataTextField = "Description";
        ddlModeofTransfer.DataValueField = "Description";
        ddlModeofTransfer.DataBind();
        ddlModeofTransfer.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void AddTypeofTransfer()
    {
        DataTable dt = maint.GetTypeOfTransfer();
        ddlTypeofTransfer.DataSource = dt;
        ddlTypeofTransfer.DataTextField = "Description";
        ddlTypeofTransfer.DataValueField = "Description";
        ddlTypeofTransfer.DataBind();
        ddlTypeofTransfer.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetRequesteddby()
    {
        UserInfo ui = new UserInfo();
        ui.Section = tbSection.Text;
        DataTable dt = maint.GetRequestedby(ui);
        ddlRequestedby.DataSource = dt;
        ddlRequestedby.DataTextField = "FullName";
        ddlRequestedby.DataValueField = "APOAccount";
        ddlRequestedby.DataBind();
        ddlRequestedby.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetCheckedby()
    {
        UserInfo ui = new UserInfo();
        ui.Section = tbSection.Text;
        DataTable dt = maint.GetCheckedby(ui);
        ddlCheckedby.DataSource = dt;
        ddlCheckedby.DataTextField = "FullName";
        ddlCheckedby.DataValueField = "APOAccount";
        ddlCheckedby.DataBind();
        ddlCheckedby.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetApprovedby()
    {
        UserInfo ui = new UserInfo();
        ui.Section = tbSection.Text;
        DataTable dt = maint.GetApprovedby(ui);
        ddlApprovedby.DataSource = dt;
        ddlApprovedby.DataTextField = "FullName";
        ddlApprovedby.DataValueField = "APOAccount";
        ddlApprovedby.DataBind();
        ddlApprovedby.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetReassignto()
    {
        UserInfo ui = new UserInfo();
        ui.Section = tbSection.Text;
        Approval a = new Approval();
        a.Approvedby = ddlApprovedby.SelectedValue;
        a.ApproverID = tbApproverID.Text;
        DataTable dt = maint.GetReassignto(ui, a);
        ddlReassignto.DataSource = dt;
        ddlReassignto.DataTextField = "FullName";
        ddlReassignto.DataValueField = "APOAccount";
        ddlReassignto.DataBind();
        ddlReassignto.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void ClearItemDetails()
    {
        tbID.Text = "";
        tbItemNo.Text = "";
        tbItemDescription.Text = "";
        tbQuantity.Text = "";
        tbUnitofMeasurement.Text = "";
        tbAmount.Text = "";
        tbAssetNo.Text = "";
        tbOD.Text = "";
        tbContainer.Text = "";
        tbPEZASeal.Text = "";
        tbDSRDRNo.Text = "";
    }

    private void GetFarmOut()
    {
        DataSet ds = new DataSet();
        FarmOutDetails fo = new FarmOutDetails();
        FarmOutRequestFormMaintenance fom = new FarmOutRequestFormMaintenance();
        fo.ControlNo = tbControlNo.Text;
        ds = fom.GetFarmOut(fo);

        if (ds.Tables[0].DefaultView.Count > 0)
        {
            GetItems();
            GetFiles();
            ddlDivision.SelectedValue = ds.Tables[0].DefaultView[0]["Division"].ToString();
            ddlNatureofItem.SelectedValue = ds.Tables[0].DefaultView[0]["NatureOfItem"].ToString();
            ddlTransferto.SelectedValue = ds.Tables[0].DefaultView[0]["TransferTo"].ToString();
            ddlTypeofItem.SelectedValue = ds.Tables[0].DefaultView[0]["TypeOfItem"].ToString();
            ddlClassificationofItem.SelectedValue = ds.Tables[0].DefaultView[0]["ClassificationOfItem"].ToString();
            if (ddlPurposeofItem.Items.FindByValue(ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString()) == null)
            {
                ddlPurposeofItem.SelectedValue = "Return (Others)";
                tbOthers.Text = ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowOthers()", true);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "PageScript();", true);
            }
            else
            {
                ddlPurposeofItem.SelectedValue = ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "PageScript();", true);
            }
            tbBearerEmployeeNo.Text = ds.Tables[0].DefaultView[0]["BearerEmployeeNo"].ToString();
            tbBearerEmployeeName.Text = ds.Tables[0].DefaultView[0]["BearerEmployeeName"].ToString();
            tbEmployeeNo.Text = ds.Tables[0].DefaultView[0]["RequestorEmployeeNo"].ToString();
            tbEmployeeName.Text = ds.Tables[0].DefaultView[0]["RequestorEmployeeName"].ToString();
            tbSection.Text = ds.Tables[0].DefaultView[0]["Section"].ToString();
            GetRequesteddby();
            GetCheckedby();
            GetApprovedby();
            tbLocalNo.Text = ds.Tables[0].DefaultView[0]["LocalNo"].ToString();
            tbDateRequested.Text = ds.Tables[0].DefaultView[0]["DateRequested"].ToString();
            tbActualDateofTransfer.Text = ds.Tables[0].DefaultView[0]["ActualDateOfTransfer"].ToString();
            tbTargetDateofReturn.Text = ds.Tables[0].DefaultView[0]["TargetDateOfReturn"].ToString();
            ddlPackagingUsed.SelectedValue = ds.Tables[0].DefaultView[0]["PackagingUsed"].ToString();
            ddlSupplierName.SelectedValue = ds.Tables[0].DefaultView[0]["SupplierName"].ToString();
            ddlDestinationAddress.Items.Add(ds.Tables[0].DefaultView[0]["DestinationAddress"].ToString());
            tbOriginofItem.Text = ds.Tables[0].DefaultView[0]["OriginOfItem"].ToString();
            tbDeliveryReceiptNo.Text = ds.Tables[0].DefaultView[0]["DeliveryReceiptNo"].ToString();
            tbInvoiceNo.Text = ds.Tables[0].DefaultView[0]["InvoiceNo"].ToString();
            tbContactPerson.Text = ds.Tables[0].DefaultView[0]["ContactPerson"].ToString();
            tbContactNo.Text = ds.Tables[0].DefaultView[0]["ContactNo"].ToString();
            tbTelephoneNo.Text = ds.Tables[0].DefaultView[0]["TelephoneNo"].ToString();
            tbFaxNo.Text = ds.Tables[0].DefaultView[0]["FaxNo"].ToString();
            ddlModeofTransfer.SelectedValue = ds.Tables[0].DefaultView[0]["ModeOfTransfer"].ToString();
            ddlTypeofTransfer.SelectedValue = ds.Tables[0].DefaultView[0]["TypeOfTransfer"].ToString();
            ddlRequestedby.SelectedValue = ds.Tables[0].DefaultView[0]["ASSIGNEDUSERID"].ToString();
            ddlCheckedby.SelectedValue = ds.Tables[0].DefaultView[1]["ASSIGNEDUSERID"].ToString();
            ddlApprovedby.SelectedValue = ds.Tables[0].DefaultView[2]["ASSIGNEDUSERID"].ToString();
            lblStatus1.Text = ds.Tables[0].DefaultView[0]["CURRENTSTATUS"].ToString();
            lblComment1.Text = ds.Tables[0].DefaultView[0]["COMMENT"].ToString();
            lblDate1.Text = ds.Tables[0].DefaultView[0]["ACTIONDATE"].ToString();
            lblStatus2.Text = ds.Tables[0].DefaultView[1]["CURRENTSTATUS"].ToString();
            lblComment2.Text = ds.Tables[0].DefaultView[1]["COMMENT"].ToString();
            lblDate2.Text = ds.Tables[0].DefaultView[1]["ACTIONDATE"].ToString();
            lblStatus3.Text = ds.Tables[0].DefaultView[2]["CURRENTSTATUS"].ToString();
            lblComment3.Text = ds.Tables[0].DefaultView[2]["COMMENT"].ToString();
            lblDate3.Text = ds.Tables[0].DefaultView[2]["ACTIONDATE"].ToString();
            tbAssignedto.Text = ds.Tables[0].DefaultView[0]["RequestorEmployeeName"].ToString();

            if (ddlRequestedby.SelectedValue != UserID || UserID != ds.Tables[0].DefaultView[0]["ASSIGNEDUSERID_CURRENT"].ToString().ToUpper())
            {
                DisableControl();
            }
            else
            {
                BtnAdd.Enabled = true;
                BtnConfirm1.Enabled = true;
            }

            if (ddlCheckedby.SelectedValue == UserID && ddlCheckedby.SelectedValue == ds.Tables[0].DefaultView[0]["ASSIGNEDUSERID_CURRENT"].ToString().ToUpper())
            {
                DisableControl();
                BtnConfirm2.Enabled = true;
            }

            if (ddlApprovedby.SelectedValue == UserID && ddlApprovedby.SelectedValue == ds.Tables[0].DefaultView[0]["ASSIGNEDUSERID_CURRENT"].ToString().ToUpper())
            {
                DisableControl();
                BtnConfirm3.Enabled = true;
            }
        }
    }

    private void DisableControl()
    {
        ddlDivision.Enabled = false;
        ddlNatureofItem.Enabled = false;
        ddlTransferto.Enabled = false;
        ddlTypeofItem.Enabled = false;
        ddlClassificationofItem.Enabled = false;
        ddlPurposeofItem.Enabled = false;
        tbBearerEmployeeNo.Enabled = false;
        tbBearerEmployeeName.Enabled = false;
        tbLocalNo.Enabled = false;
        tbDateRequested.Enabled = false;
        tbActualDateofTransfer.Enabled = false;
        tbTargetDateofReturn.Enabled = false;
        ddlPackagingUsed.Enabled = false;
        fuChooseFile.Enabled = false;
        BtnUpload.Enabled = false;
        ddlSupplierName.Enabled = false;
        tbOriginofItem.Enabled = false;
        ddlDestinationAddress.Enabled = false;
        tbInvoiceNo.Enabled = false;
        tbDeliveryReceiptNo.Enabled = false;
        tbContactPerson.Enabled = false;
        tbContactNo.Enabled = false;
        tbTelephoneNo.Enabled = false;
        tbFaxNo.Enabled = false;
        ddlModeofTransfer.Enabled = false;
        ddlTypeofTransfer.Enabled = false;
        ddlCheckedby.Enabled = false;
        ddlApprovedby.Enabled = false;
        BtnAdd.Enabled = false;
        BtnSave.Enabled = false;
        BtnConfirm1.Enabled = false;
        BtnConfirm2.Enabled = false;
        BtnConfirm3.Enabled = false;
        gvItems.Enabled = false;
        gvFiles.Enabled = false;
    }

    protected void ddlSupplierName_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = frfm.GetSupplierAddress(ddlSupplierName.Text);
        if (dt.Rows.Count > 1)
        {
            ddlDestinationAddress.DataSource = dt;
            ddlDestinationAddress.DataTextField = "SupplierAddress";
            ddlDestinationAddress.DataValueField = "SupplierAddress";
            ddlDestinationAddress.DataBind();
            ddlDestinationAddress.Items.Insert(0, new ListItem("Choose...", ""));
            ddlDestinationAddress.Enabled = true;
        }
        else
        {
            ddlDestinationAddress.DataSource = dt;
            ddlDestinationAddress.DataTextField = "SupplierAddress";
            ddlDestinationAddress.DataValueField = "SupplierAddress";
            ddlDestinationAddress.DataBind();
            ddlDestinationAddress.Enabled = false;
        }
    }

    protected void ddlPurposeofItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPurposeofItem.SelectedValue == "Others")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowOthers()", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "PageScript();", true);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "PageScript();", true);
        }
    }

    protected void tbBearerEmployeeNo_TextChanged(object sender, EventArgs e)
    {
        if (tbBearerEmployeeNo.Text != null)
        {
            DataTable dt = frfm.GetBearerEmployeeName(tbBearerEmployeeNo.Text);
            if (dt.Rows.Count > 0)
            {
                tbBearerEmployeeName.Text = dt.Rows[0]["FullName"].ToString();
            }
        }
    }

    protected void LnkBtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("FarmOutDocuments.aspx" + "?controlno=" + tbControlNo.Text);
    }

    [WebMethod]
    public static void GetSelectedTypeOfItems()
    {

    }
}
