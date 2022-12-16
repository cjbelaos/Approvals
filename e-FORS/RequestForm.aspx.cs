using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RequestForm : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    private static readonly FarmOutRequestFormMaintenance form = new FarmOutRequestFormMaintenance();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string GetUserInformation(string UserID)
    {
        return JsonConvert.SerializeObject(maint.GetUserInformation(UserID));
    }

    [WebMethod]
    public static string GetBearerEmployeeName(string EmployeeNo)
    {
        return JsonConvert.SerializeObject(form.GetBearerEmployeeName(EmployeeNo));
    }

    [WebMethod]
    public static string GetFarmOut(FarmOutDetails fo)
    {
        return JsonConvert.SerializeObject(form.GetFarmOut(fo));
    }

    [WebMethod]
    public static string SaveFarmOut(FarmOutDetails fo, string UserID)
    {
        return JsonConvert.SerializeObject(maint.SaveFarmOutRequestForm(fo, UserID));
    }

    [WebMethod]
    public static void SaveApproval(Approval a)
    {
        maint.SaveApproval(a);
    }

    [WebMethod]
    public static void UpdateApproval(string ControlNo, string ApproverID, string ApproverUserID, string UserID)
    {
        maint.UpdateApproval(ControlNo, ApproverID, ApproverUserID, UserID);
    }

    [WebMethod]
    public static void SaveMirrorApproval(Approval a)
    {
        maint.SaveMirrorApproval(a);
    }

    [WebMethod]
    public static void Approve(Approval a)
    {
        maint.Approval(a);
    }

    [WebMethod]
    public static void RequestChange(Approval a)
    {
        maint.RequestChange(a);
    }

    [WebMethod]
    public static void ReassignTask(Approval a, string ReassignTo)
    {
        maint.ReassignTask(a, ReassignTo);
    }

    [WebMethod]
    public static void CancelRequest(Approval a)
    {
        maint.CancelRequest(a);
    }

    [WebMethod]
    public static void SendEmail(EmailDetails ed)
    {
        maint.SendEmail(ed);
    }

    [WebMethod]
    public static string GetItems(string ControlNo)
    {
        return JsonConvert.SerializeObject(maint.GetAllItems(ControlNo));
    }

    [WebMethod]
    public static void SaveItem(Items i, string UserID)
    {
        maint.SaveItem(i, UserID);
    }

    [WebMethod]
    public static void UpdateItem(Items i, string UserID)
    {
        maint.UpdateItem(i, UserID);
    }

    [WebMethod]
    public static void DeleteItem(Items i)
    {
        maint.DeleteItem(i);
    }

    [WebMethod]
    public static string GetFiles(string ControlNo)
    {
        return JsonConvert.SerializeObject(form.GetFiles(ControlNo));
    }

    [WebMethod]
    public static void DeleteFile(string ControlNo, int ID)
    {
        form.DeleteFile(ControlNo, ID);
    }

    [WebMethod]
    public static bool CheckPurposeOfItemIfWithLOA(FarmOutDocumentDetails fdd)
    {
        return maint.CheckPurposeOfItemIfWithLOA(fdd);
    }

    [WebMethod]
    public static bool FarmOutRequestFormApprovalChecking(string ControlNo)
    {
        return form.FarmOutRequestFormApprovalChecking(ControlNo);
    }

    [WebMethod]
    public static bool CheckAuthorization(string UserID)
    {
        return maint.CheckAuthorization(UserID);
    }

    [WebMethod]
    public static bool CheckIfBypassAccount(LoginDetails ld)
    {
        return maint.CheckIfBypassAccount(ld);
    }

    [WebMethod]
    public static bool CheckIfCancelled(string ControlNo)
    {
        return maint.CheckIfCancelled(ControlNo);
    }

    [WebMethod]
    public static bool CheckIfApproveByRequestor(string ControlNo)
    {
        return maint.CheckIfApproveByRequestor(ControlNo);
    }

    [WebMethod]
    public static bool CheckIfFinishedRequestor(string ControlNo)
    {
        return maint.CheckIfFinishedRequestor(ControlNo);
    }

    [WebMethod]
    public static string GetLOADescription(SupplierDetails sd, LOADetails ld)
    {
        return JsonConvert.SerializeObject(maint.GetItemType(sd, ld));
    }

    [WebMethod]
    public static string GetDivision()
    {
        return JsonConvert.SerializeObject(maint.GetDivision());
    }

    [WebMethod]
    public static string GetNatureOfItem()
    {
        return JsonConvert.SerializeObject(maint.GetNatureOfItem());
    }

    [WebMethod]
    public static string GetTransferTo()
    {
        return JsonConvert.SerializeObject(maint.GetTransferTo());
    }

    [WebMethod]
    public static string GetTypeOfItem()
    {
        return JsonConvert.SerializeObject(maint.GetTypeOfItem());
    }

    [WebMethod]
    public static string GetClassificationOfItem()
    {
        return JsonConvert.SerializeObject(maint.GetClassificationOfItem());
    }

    [WebMethod]
    public static string GetPurposeOfItem()
    {
        return JsonConvert.SerializeObject(maint.GetPurposeOfItem());
    }

    [WebMethod]
    public static string GetPackagingUsed()
    {
        return JsonConvert.SerializeObject(maint.GetPackagingUsed());
    }

    [WebMethod]
    public static string GetSupplierName()
    {
        return JsonConvert.SerializeObject(maint.GetSuppliers());
    }

    [WebMethod]
    public static string GetSupplierAddress(string Supplier)
    {
        return JsonConvert.SerializeObject(form.GetSupplierAddress(Supplier));
    }

    [WebMethod]
    public static string GetModeOfTransfer()
    {
        return JsonConvert.SerializeObject(maint.GetModeOfTransfer());
    }

    [WebMethod]
    public static string GetTypeOfTransfer()
    {
        return JsonConvert.SerializeObject(maint.GetTypeOfTransfer());
    }

    [WebMethod]
    public static string GetRequestedby(UserInfo ui)
    {
        return JsonConvert.SerializeObject(maint.GetRequestedby(ui));
    }

    [WebMethod]
    public static string GetCheckedBy(UserInfo ui)
    {
        return JsonConvert.SerializeObject(maint.GetCheckedby(ui));
    }

    [WebMethod]
    public static string GetApprovedby(UserInfo ui)
    {
        return JsonConvert.SerializeObject(maint.GetApprovedby(ui));
    }
}