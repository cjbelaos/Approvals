using System;
using System.Web;
using System.Web.Services;
using Newtonsoft.Json;

public partial class FarmOutRequestForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session["Link"] = HttpContext.Current.Request.Url.AbsoluteUri;
            Response.Redirect("Login.aspx?expired=1");
        }
    }

    [WebMethod]
    public static string GetUserInformation(string UserID)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetUserInformation(UserID));
    }

    [WebMethod]
    public static string GetSectionDepartment(string Section)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetSectionDepartment(Section));
    }

    [WebMethod]
    public static string GetBearerEmployeeName(string EmployeeNo)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return JsonConvert.SerializeObject(form.GetBearerEmployeeName(EmployeeNo));
    }

    [WebMethod]
    public static string GetFarmOut(FarmOutDetails fo)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return JsonConvert.SerializeObject(form.GetFarmOut(fo));
    }

    [WebMethod]
    public static string SaveFarmOut(FarmOutDetails fo, string UserID)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.SaveFarmOutRequestForm(fo, UserID));
    }

    [WebMethod]
    public static void SaveApproval(Approval a)
    {
        Maintenance maint = new Maintenance();
        maint.SaveApproval(a);
    }

    [WebMethod]
    public static void UpdateApproval(string ControlNo, string ApproverID, string ApproverUserID, string UserID)
    {
        Maintenance maint = new Maintenance();
        maint.UpdateApproval(ControlNo, ApproverID, ApproverUserID, UserID);
    }

    [WebMethod]
    public static void SaveMirrorApproval(Approval a)
    {
        Maintenance maint = new Maintenance();
        maint.SaveMirrorApproval(a);
    }

    [WebMethod]
    public static void Approve(Approval a)
    {
        Maintenance maint = new Maintenance();
        maint.Approval(a);
    }

    [WebMethod]
    public static void RequestChange(Approval a)
    {
        Maintenance maint = new Maintenance();
        maint.RequestChange(a);
    }

    [WebMethod]
    public static void ReassignTask(Approval a, string ReassignTo)
    {
        Maintenance maint = new Maintenance();
        maint.ReassignTask(a, ReassignTo);
    }

    [WebMethod]
    public static void CancelRequest(Approval a)
    {
        Maintenance maint = new Maintenance();
        maint.CancelRequest(a);
    }

    [WebMethod]
    public static void SendEmail(EmailDetails ed)
    {
        Maintenance maint = new Maintenance();
        maint.SendEmail(ed);
    }

    [WebMethod]
    public static string GetItems(string ControlNo)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetAllItems(ControlNo));
    }

    [WebMethod]
    public static void SaveItem(Items i, string UserID)
    {
        Maintenance maint = new Maintenance();
        maint.SaveItem(i, UserID);
    }

    [WebMethod]
    public static void UpdateItem(Items i, string UserID)
    {
        Maintenance maint = new Maintenance();
        maint.UpdateItem(i, UserID);
    }

    [WebMethod]
    public static void DeleteItem(Items i)
    {
        Maintenance maint = new Maintenance();
        maint.DeleteItem(i);
    }

    [WebMethod]
    public static string GetFiles(string ControlNo)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return JsonConvert.SerializeObject(form.GetFiles(ControlNo));
    }

    [WebMethod]
    public static void DeleteFile(string ControlNo, int ID)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        form.DeleteFile(ControlNo, ID);
    }

    [WebMethod]
    public static bool CheckPurposeOfItemIfWithLOA(FarmOutDocumentDetails fdd)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckPurposeOfItemIfWithLOA(fdd);
    }

    [WebMethod]
    public static bool FarmOutRequestFormApprovalChecking(string ControlNo)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return form.FarmOutRequestFormApprovalChecking(ControlNo);
    }

    [WebMethod]
    public static bool CheckAuthorization(string UserID)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckAuthorization(UserID);
    }

    [WebMethod]
    public static bool CheckIfBypassAccount(LoginDetails ld)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckIfBypassAccount(ld);
    }

    [WebMethod]
    public static bool CheckIfCancelled(string ControlNo)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckIfCancelled(ControlNo);
    }

    [WebMethod]
    public static bool CheckIfApproveByRequestor(string ControlNo)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckIfApproveByRequestor(ControlNo);
    }

    [WebMethod]
    public static bool CheckIfFinishedRequestor(string ControlNo)
    {
        Maintenance maint = new Maintenance();
        return maint.CheckIfFinishedRequestor(ControlNo);
    }

    [WebMethod]
    public static string CheckIfLOALimit(LOADetails ld)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetLOALimitPercentage(ld));
    }

    [WebMethod]
    public static string GetLOADescription(SupplierDetails sd, LOADetails ld)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetItemType(sd, ld));
    }

    [WebMethod]
    public static string GetDivision()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetDivision());
    }

    [WebMethod]
    public static string GetNatureOfItem()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetNatureOfItem());
    }

    [WebMethod]
    public static string GetTransferTo()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetTransferTo());
    }

    [WebMethod]
    public static string GetTypeOfItem()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetTypeOfItem());
    }

    [WebMethod]
    public static string GetClassificationOfItem()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetClassificationOfItem());
    }

    [WebMethod]
    public static string GetPurposeOfItem()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetPurposeOfItem());
    }

    [WebMethod]
    public static string GetPackagingUsed()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetPackagingUsed());
    }

    [WebMethod]
    public static string GetSupplierName()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetSuppliers());
    }

    [WebMethod]
    public static string GetSupplierAddress(string Supplier)
    {
        FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
        return JsonConvert.SerializeObject(form.GetSupplierAddress(Supplier));
    }

    [WebMethod]
    public static string GetModeOfTransfer()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetModeOfTransfer());
    }

    [WebMethod]
    public static string GetTypeOfTransfer()
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetTypeOfTransfer());
    }

    [WebMethod]
    public static string GetRequestedby(UserInfo ui)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetRequestedby(ui));
    }

    [WebMethod]
    public static string GetCheckedBy(UserInfo ui)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetCheckedby(ui));
    }

    [WebMethod]
    public static string GetApprovedby(UserInfo ui)
    {
        Maintenance maint = new Maintenance();
        return JsonConvert.SerializeObject(maint.GetApprovedby(ui));
    }
}