using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;
using System.IO;
using System.Linq;

public partial class Default : System.Web.UI.Page
{
    private static readonly FarmOutRequestFormMaintenance frfm = new FarmOutRequestFormMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    private static readonly Items items = new Items();
    private static readonly FarmOutDetails fod = new FarmOutDetails();
    private static readonly SupplierDetails sd = new SupplierDetails();
    private static readonly LOADetails ld = new LOADetails();
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
                GetUserInfo();
                AddDivision();
                AddNatureofItem();
                AddTransferto();
                AddTypeofItem();
                AddClassificationofItem();
                AddPurposeofItem();
                AddPackagingUsed();
                AddSuppliers();
                AddModeofTransfer();
                AddTypeofTransfer();
                GetRequesteddby();
                GetCheckedby();
                GetApprovedby();
                GetItems();
                GetFiles();

                if (Request.QueryString["CONTROLNO"] != null)
                {
                    BtnPrint.Visible = true;
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
                    AddSuppliers();
                    AddModeofTransfer();
                    AddTypeofTransfer();
                    GetRequesteddby();
                    GetCheckedby();
                    GetApprovedby();
                    GetItems();
                    GetFiles();
                }
            }
        }
        GetFiles();
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
        FarmOutDocumentDetails fdd = new FarmOutDocumentDetails();
        fdd.CONTROLNO = tbControlNo.Text;
        bool x = maint.CheckPurposeOfItemIfWithLOA(fdd);
        if (x == true)
        {
            ddlItemType.Items.Clear();
            ddlItemType.Items.Insert(0, new ListItem("N/A", ""));
        }
        else
        {
            ddlItemType.Items.Clear();
            sd.ID = ddlSupplierName.SelectedValue.ToString();
            ld.DIVISION = ddlDivision.SelectedValue.ToString();
            DataTable dt1 = maint.GetItemType(sd, ld);
            if (dt1.Rows.Count > 0)
            {
                ddlItemType.DataSource = dt1;
                ddlItemType.DataTextField = "DESCRIPTION";
                ddlItemType.DataValueField = "DESCRIPTION";
                ddlItemType.DataBind();
                ddlItemType.Items.Insert(0, new ListItem("Choose...", ""));
            }
            else
            {
                ddlItemType.Items.Insert(0, new ListItem("N/A", ""));
            }
        }
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

        EmailDetails ed = new EmailDetails();
        ed.CONTROLNO = tbControlNo.Text;
        ed.FROM_EMAIL = UserID;

        if (tbApproverID.Text == "1")
        {
            ed.TO_EMAIL = ddlCheckedby.SelectedValue;
        }
        else if (tbApproverID.Text == "2")
        {
            ed.TO_EMAIL = ddlApprovedby.SelectedValue;
        }
        else
        {
            ed.TO_EMAIL = "LCS";
        }

        ed.EMAILTYPE = "Approval";
        maint.SendEmail(ed);

        Page.Response.Redirect(Page.Request.Url.ToString(), true);

        //GetFarmOut();
        //DisableControl();

        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalConfirm", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
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

        EmailDetails ed = new EmailDetails();
        ed.CONTROLNO = tbControlNo.Text;

        if (tbApproverID.Text == "2")
        {
            ed.FROM_EMAIL = ddlCheckedby.SelectedValue;
            ed.TO_EMAIL = ddlRequestedby.SelectedValue;
        }
        else if (tbApproverID.Text == "3")
        {
            ed.FROM_EMAIL = ddlApprovedby.SelectedValue.ToString() + "," + ddlCheckedby.SelectedValue.ToString();
            ed.TO_EMAIL = ddlRequestedby.SelectedValue;
        }

        ed.EMAILTYPE = "Request Change";
        maint.SendEmail(ed);

        Page.Response.Redirect(Page.Request.Url.ToString(), true);

        //DisableControl();
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalRequestChange", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
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
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ReassignToAlert();", true);
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

            EmailDetails ed = new EmailDetails();
            ed.CONTROLNO = tbControlNo.Text;

            if (tbApproverID.Text == "2")
            {
                ed.FROM_EMAIL = ddlCheckedby.SelectedValue;
                ed.TO_EMAIL = ddlReassignto.SelectedValue;
            }
            else if (tbApproverID.Text == "3")
            {
                ed.FROM_EMAIL = ddlApprovedby.SelectedValue.ToString() + "," + ddlCheckedby.SelectedValue.ToString();
                ed.TO_EMAIL = ddlReassignto.SelectedValue;
            }

            ed.EMAILTYPE = "Re-assign";
            maint.SendEmail(ed);

            Page.Response.Redirect(Page.Request.Url.ToString(), true);

            //DisableControl();
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modalReassignTask", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "ReassignFarmOutSuccessAlert();", true);
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
            if (ddlItemType.SelectedItem.ToString() == "Choose..." || tbItemDescription.Text == "" || tbQuantity.Text == "" || tbUnitofMeasurement.Text == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "AddItemsFailedAlert();", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('.modal-backdrop').remove(); $('body').removeClass( 'modal - open' );", true);
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
            }
            else
            {
                items.ControlNo = tbControlNo.Text;
                items.TypeOfItem = ddlItemType.SelectedValue.ToString();
                items.ItemCode = tbItemNo.Text.ToUpper();
                items.ItemDescription = tbItemDescription.Text.ToUpper();
                items.Quantity = tbQuantity.Text;
                items.UnitOfMeasurement = tbUnitofMeasurement.Text.ToUpper();
                items.Amount = tbAmount.Text;
                items.AssetNo = tbAssetNo.Text.ToUpper();
                items.ODNo = tbOD.Text.ToUpper();
                items.ContainerNo = tbContainer.Text.ToUpper();
                items.PEZASeal = tbPEZASeal.Text.ToUpper();
                items.DSRDRNo = tbDSRDRNo.Text.ToUpper();
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
                if (ddlItemType.SelectedItem.ToString() == "Choose..." || tbItemNo.Text == "" || tbItemDescription.Text == "" || tbQuantity.Text == "" || tbUnitofMeasurement.Text == "")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "AddItemsFailedAlert();", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('.modal-backdrop').remove(); $('body').removeClass( 'modal - open' );", true);
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal", "$('#modal').modal('show');", true);
                }
                else
                {
                    items.ID = tbID.Text;
                    items.ControlNo = tbControlNo.Text;
                    items.TypeOfItem = ddlItemType.SelectedValue.ToString();
                    items.ItemCode = tbItemNo.Text.ToUpper();
                    items.ItemDescription = tbItemDescription.Text.ToUpper();
                    items.Quantity = tbQuantity.Text;
                    items.UnitOfMeasurement = tbUnitofMeasurement.Text.ToUpper();
                    items.Amount = tbAmount.Text;
                    items.AssetNo = tbAssetNo.Text.ToUpper();
                    items.ODNo = tbOD.Text.ToUpper();
                    items.ContainerNo = tbContainer.Text.ToUpper();
                    items.PEZASeal = tbPEZASeal.Text.ToUpper();
                    items.DSRDRNo = tbDSRDRNo.Text.ToUpper();
                    maint.UpdateItem(items, UserName);
                    GetItems();
                    ClearItemDetails();

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "#modal", "$('body').removeClass('modal-open');$('.modal-backdrop').remove();", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "UpdateItemsSuccessAlert();", true);
                }
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

        if (ddlDivision.SelectedValue != "" && ddlTypeofItem.SelectedValue != "" && ddlClassificationofItem.SelectedValue != "" &&
            ddlPurposeofItem.SelectedValue != "" && tbBearerEmployeeName.Text != "" && tbDateRequested.Text != "" &&
            tbActualDateofTransfer.Text != "" && ddlSupplierName.SelectedValue != "" && ddlCheckedby.SelectedValue != "" && ddlApprovedby.SelectedValue != "")
        {
            Maintenance maint = new Maintenance();
            DataSet ds = new DataSet();
            FarmOutDetails fo = new FarmOutDetails();


            fo.ControlNo = tbControlNo.Text;
            fo.Division = ddlDivision.SelectedValue;
            fo.NatureOfItem = ddlNatureofItem.SelectedValue;
            fo.TransferTo = ddlTransferto.SelectedValue;
            string selectedTypeOfItem = hfTypeofItem.Value;
            string TypeOfItem = selectedTypeOfItem.Replace(",", " | ");
            fo.TypeOfItem = TypeOfItem;
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
            fo.BearerEmployeeName = tbBearerEmployeeName.Text.ToUpper(); ;
            fo.RequestorEmployeeNo = tbEmployeeNo.Text;
            fo.RequestorEmployeeName = tbEmployeeName.Text;
            fo.Section = tbSection.Text;
            fo.LocalNo = tbLocalNo.Text;
            fo.DateRequested = tbDateRequested.Text;
            fo.ActualDateOfTransfer = tbActualDateofTransfer.Text;
            fo.TargetDateOfReturn = tbTargetDateofReturn.Text;
            fo.PackagingUsed = ddlPackagingUsed.SelectedValue;
            fo.SupplierID = ddlSupplierName.SelectedValue;
            fo.SupplierName = ddlSupplierName.SelectedItem.ToString();
            fo.DestinationAddress = tbDestinationAddress.Text;
            fo.OriginOfItem = tbOriginofItem.Text.ToUpper();
            fo.DeliveryReceiptNo = tbDeliveryReceiptNo.Text.ToUpper();
            fo.InvoiceNo = tbInvoiceNo.Text.ToUpper();
            fo.ContactPerson = tbContactPerson.Text.ToUpper();
            fo.ContactNo = tbContactNo.Text.ToUpper();
            fo.TelephoneNo = tbTelephoneNo.Text.ToUpper();
            fo.FaxNo = tbFaxNo.Text.ToUpper();
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

            Label lblTypeOfItem = (Label)row.FindControl("lblTypeOfItem");
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
            ddlItemType.SelectedValue = lblTypeOfItem.Text;
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

    private void AddSuppliers()
    {
        DataTable dt = maint.GetSuppliers();
        ddlSupplierName.DataSource = dt;
        ddlSupplierName.DataTextField = "SupplierName";
        ddlSupplierName.DataValueField = "SupplierID";
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
            string selectedTypeOfItem = ds.Tables[0].DefaultView[0]["TypeOfItem"].ToString();
            string TypeOfItem = selectedTypeOfItem.Replace(" | ", ",");
            hfTypeofItem.Value = TypeOfItem;
            ddlClassificationofItem.SelectedValue = ds.Tables[0].DefaultView[0]["ClassificationOfItem"].ToString();
            if (ddlPurposeofItem.Items.FindByValue(ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString()) == null)
            {
                ddlPurposeofItem.SelectedValue = "Others";
                tbOthers.Text = ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowOthers()", true);
            }
            else
            {
                ddlPurposeofItem.SelectedValue = ds.Tables[0].DefaultView[0]["PurposeOfItem"].ToString();
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
            if (ddlSupplierName.Items.FindByValue(ds.Tables[0].DefaultView[0]["SupplierID"].ToString()) == null)
            {
                ddlSupplierName.Items.Add(new ListItem(ds.Tables[0].DefaultView[0]["SupplierName"].ToString(), ds.Tables[0].DefaultView[0]["SupplierID"].ToString().ToUpper()));
            }
            ddlSupplierName.SelectedValue = ds.Tables[0].DefaultView[0]["SupplierID"].ToString();
            {
                GetTypeOfItems();
            }
            tbDestinationAddress.Text = ds.Tables[0].DefaultView[0]["DestinationAddress"].ToString();
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
        tbDestinationAddress.Enabled = false;
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
        if (ddlSupplierName.SelectedValue != "")
        {
            DataTable dt = frfm.GetSupplierAddress(ddlSupplierName.SelectedValue);
            tbDestinationAddress.Text = dt.Rows[0]["SupplierAddress"].ToString();
        }
        else
        {
            tbDestinationAddress.Text = "";
        }
    }

    protected void ddlPurposeofItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPurposeofItem.SelectedValue == "Others")
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "text", "ShowOthers()", true);
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

    private void GetTypeOfItems()
    {
        sd.ID = ddlSupplierName.SelectedValue.ToString();
        ld.DIVISION = ddlDivision.SelectedValue.ToString();
        DataTable dt1 = maint.GetItemType(sd, ld);
        if (dt1.Rows.Count > 0)
        {
            ddlItemType.DataSource = dt1;
            ddlItemType.DataTextField = "DESCRIPTION";
            ddlItemType.DataValueField = "DESCRIPTION";
            ddlItemType.DataBind();
            ddlItemType.Items.Insert(0, new ListItem("Choose...", ""));
        }
        else
        {
            ddlItemType.Items.Insert(0, new ListItem("N/A", ""));
        }
    }

    protected void lblFileName_Click(object sender, EventArgs g)
    {
        var TLink = (Control)sender;
        GridViewRow row = (GridViewRow)TLink.NamingContainer;
        LinkButton lnk = sender as LinkButton;
        string FilePath = Server.MapPath("~/RelatedDocu/" + tbControlNo.Text + "/" +lnk.Text);
        string filePath = "~/RelatedDocu/" + tbControlNo.Text + "/" + lnk.Text;
  
        if (File.Exists(FilePath))
        {
            Response.Redirect(filePath);
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ApprovedFarmOutSuccessAlert();", true);
        }
    }

    protected void gvFiles_RowCommand(object sender, GridViewCommandEventArgs g)
    {
        if (g.CommandName.Equals("Delete"))
        {
            GridViewRow row = (GridViewRow)(((Button)g.CommandSource).NamingContainer);
            string index = g.CommandArgument.ToString();
            string FilePath = Server.MapPath("~/RelatedDocu/" + tbControlNo.Text + "/" + index);

            FileDetails fd = new FileDetails();
            fd.ControlNo = tbControlNo.Text;
            fd.FileName = index;

            FileInfo file = new FileInfo(FilePath);
            if (file.Exists)
            {
                file.Delete();
                maint.DeleteFile(fd);
                GetFiles();
            }
            else
            {
                maint.DeleteFile(fd);
                GetFiles();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), Guid.NewGuid().ToString(), "ApprovedFarmOutSuccessAlert();", true);
            }
        }
    }

    protected void BtnPrint_Click(object sender, EventArgs e)
    {
        Response.Redirect("RequestFormPrint.aspx" + "?controlno=" + Request.QueryString["controlno"]);
    }
}