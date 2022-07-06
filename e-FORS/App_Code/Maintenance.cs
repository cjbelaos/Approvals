using Microsoft.ApplicationBlocks.Data;
using Newtonsoft.Json;
using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for Maintenance
/// </summary>
public class Maintenance
{
    private readonly string EPPIIIP;
    readonly SqlConnection SqlConEPPIIIP;

    private readonly string EFORS;
    readonly SqlConnection conn;

    private readonly string EPPIIIP_New;
    readonly SqlConnection SqlConEPPIIIP_New;

    public Maintenance()
    {
        this.EPPIIIP = System.Configuration.ConfigurationManager.AppSettings["EPPIIIP"];
        SqlConEPPIIIP = new SqlConnection(EPPIIIP);

        this.EPPIIIP_New = System.Configuration.ConfigurationManager.AppSettings["EPPIIIP_New"];
        SqlConEPPIIIP_New = new SqlConnection(EPPIIIP_New);

        this.EFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        conn = new SqlConnection(EFORS);
    }

    public DataView GetUser(string strSystemName, string strUsername)
    {
        //using (var cmd = new SqlCommand("LOGIN_GetUser", SqlConEPPIIIP) { CommandType = CommandType.StoredProcedure })
        //{
        //    cmd.Parameters.AddWithValue("@system_name", strSystemName);
        //    cmd.Parameters.AddWithValue("@user_id", strUsername);
        //    cmd.Parameters.AddWithValue("@password", "");
        //    cmd.Parameters.AddWithValue("@LDAP", true);

        //    cmd.CommandTimeout = 360000;

        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    DataSet ds = new DataSet();

        //    conn.Open();

        //    da.Fill(ds);
        //    cmd.ExecuteNonQuery();

        //    conn.Close();

        //    return ds;
        //}

        return SqlHelper.ExecuteDataset(this.EPPIIIP, "LOGIN_GetUser", strSystemName, strUsername, "", true).Tables[0].DefaultView;
    }

    public DataView GetUser(string strSystemName, string strUsername, string strPassword)
    {
        //using (var cmd = new SqlCommand("LOGIN_GetUser", SqlConEPPIIIP) { CommandType = CommandType.StoredProcedure })
        //{
        //    cmd.Parameters.AddWithValue("@system_name", strSystemName);
        //    cmd.Parameters.AddWithValue("@user_id", strUsername);
        //    cmd.Parameters.AddWithValue("@password", strPassword);
        //    cmd.Parameters.AddWithValue("@LDAP", true);

        //    cmd.CommandTimeout = 360000;

        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    DataSet ds = new DataSet();

        //    conn.Open();

        //    da.Fill(ds);
        //    cmd.ExecuteNonQuery();

        //    conn.Close();

        //    return ds;
        //}

        return SqlHelper.ExecuteDataset(this.EPPIIIP, "LOGIN_GetUser", strSystemName, strUsername, strPassword, false).Tables[0].DefaultView;
    }

    public DataView GetAllTasks()
    {
        return SqlHelper.ExecuteDataset(EFORS, "GET_TASKLIST_ALL").Tables[0].DefaultView;
    }

    public DataTable GetMyTasks(string UserID)
    {
        using (var cmd = new SqlCommand("GET_TASKLIST_USER", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@USERID", UserID);
            cmd.CommandTimeout = 360000;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            try
            {
                if(conn.State == ConnectionState.Open)
                {
                    da.Fill(dt);
                    
                }
                else
                {
                    conn.Open();
                    da.Fill(dt);
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            finally
            {
                conn.Close();
            }
            return dt;
        }
    }

    public DataTable GetFinishedTasks()
    {
        using (SqlCommand cmd = new SqlCommand("GetFinishedTasks", conn) { CommandType = CommandType.StoredProcedure })
        {
            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            DataTable dataTable = new DataTable();

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    sqlDataAdapter.Fill(dataTable);
                }
                else
                {
                    conn.Open();
                    sqlDataAdapter.Fill(dataTable);
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            return dataTable;
        }
    }

    public DataSet SaveFarmOutRequestForm(FarmOutDetails fo, string strUsername)
    {
        using (var cmd = new SqlCommand("SaveFarmOutRequestForm", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);
            cmd.Parameters.AddWithValue("@Division", fo.Division);
            cmd.Parameters.AddWithValue("@NatureOfItem", fo.NatureOfItem);
            cmd.Parameters.AddWithValue("@TransferTo", fo.TransferTo);
            cmd.Parameters.AddWithValue("@TypeOfItem", fo.TypeOfItem);
            cmd.Parameters.AddWithValue("@ClassificationOfItem", fo.ClassificationOfItem);
            cmd.Parameters.AddWithValue("@PurposeOfItem", fo.PurposeOfItem);
            cmd.Parameters.AddWithValue("@BearerEmployeeNo", fo.BearerEmployeeNo);
            cmd.Parameters.AddWithValue("@BearerEmployeeName", fo.BearerEmployeeName);
            cmd.Parameters.AddWithValue("@RequestorEmployeeNo", fo.RequestorEmployeeNo);
            cmd.Parameters.AddWithValue("@RequestorEmployeeName", fo.RequestorEmployeeName);
            cmd.Parameters.AddWithValue("@Section", fo.Section);
            cmd.Parameters.AddWithValue("@LocalNo", fo.LocalNo);
            cmd.Parameters.AddWithValue("@DateRequested", fo.DateRequested);
            cmd.Parameters.AddWithValue("@ActualDateOfTransfer", fo.ActualDateOfTransfer);
            cmd.Parameters.AddWithValue("@TargetDateOfReturn", fo.TargetDateOfReturn);
            cmd.Parameters.AddWithValue("@PackagingUsed", fo.PackagingUsed);
            cmd.Parameters.AddWithValue("@SupplierName", fo.SupplierName);
            cmd.Parameters.AddWithValue("@DestinationAddress", fo.DestinationAddress);
            cmd.Parameters.AddWithValue("@OriginOfItem", fo.OriginOfItem);
            cmd.Parameters.AddWithValue("@DeliveryReceiptNo", fo.DeliveryReceiptNo);
            cmd.Parameters.AddWithValue("@InvoiceNo", fo.InvoiceNo);
            cmd.Parameters.AddWithValue("@ContactPerson", fo.ContactPerson);
            cmd.Parameters.AddWithValue("@ContactNo", fo.ContactNo);
            cmd.Parameters.AddWithValue("@TelephoneNo", fo.TelephoneNo);
            cmd.Parameters.AddWithValue("@FaxNo", fo.FaxNo);
            cmd.Parameters.AddWithValue("@ModeOfTransfer", fo.ModeOfTransfer);
            cmd.Parameters.AddWithValue("@TypeOfTransfer", fo.TypeOfTransfer);
            cmd.Parameters.AddWithValue("@CreatedBy", strUsername);
            cmd.Parameters.AddWithValue("@UpdatedBy", strUsername);
            cmd.CommandTimeout = 360000;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    da.Fill(ds);

                    conn.Close();
                }
                else
                {
                    conn.Open();

                    da.Fill(ds);

                    conn.Close();
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            return ds;
        }
    }

    public DataSet GetUserInformation(string UserID)
    {
        SqlCommand cmd = new SqlCommand("GetUserInformation", SqlConEPPIIIP_New);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@APOAccount", UserID);
        cmd.CommandTimeout = 360000;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        if (SqlConEPPIIIP_New.State == ConnectionState.Open)
        {
            da.Fill(ds);
            cmd.ExecuteNonQuery();

            SqlConEPPIIIP_New.Close();
        }
        else
        {
            SqlConEPPIIIP_New.Open();

            da.Fill(ds);
            cmd.ExecuteNonQuery();

            SqlConEPPIIIP_New.Close();
        }
        return ds;
    }

    public DataTable GetAllItems(string strControlNo)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(conn, "GetAllItems", strControlNo).Tables[0];
        return dt;
    }

    public void SaveSupplier(string UserName, string Supplier, string LOAType, string LOANo, string ExpirationDate1, string LOAAmountLimit, string LOAQuantityLimit, string SuretyBondNo, string ExpirationDate2)
    {
        SqlCommand cmd = new SqlCommand("SaveSupplier", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Username", UserName);
        cmd.Parameters.AddWithValue("@SupplierName", Supplier);
        cmd.Parameters.AddWithValue("@LOAType", LOAType);
        cmd.Parameters.AddWithValue("@LOANo", LOANo);
        cmd.Parameters.AddWithValue("@LOAExpirationDate", ExpirationDate1);
        cmd.Parameters.AddWithValue("@AmountLimit", LOAAmountLimit);
        cmd.Parameters.AddWithValue("@QuantityLimit", LOAQuantityLimit);
        cmd.Parameters.AddWithValue("@SuretyBondNo", SuretyBondNo);
        cmd.Parameters.AddWithValue("@SuretyExpirationDate", ExpirationDate2);
        cmd.CommandTimeout = 36000;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
            conn.Close();
        }

    }
    public string SaveItem(Items i, string strUsername)
    {
        string Message = "";
        try
        {
            SqlDataAdapter da = new SqlDataAdapter();
            using (var cmd = new SqlCommand("SaveItem", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", i.ControlNo);
                cmd.Parameters.AddWithValue("@ItemCode", i.ItemCode);
                cmd.Parameters.AddWithValue("@ItemDescription", i.ItemDescription);
                cmd.Parameters.AddWithValue("@Quantity", i.Quantity.ToString());
                cmd.Parameters.AddWithValue("@UnitOfMeasurement", i.UnitOfMeasurement);
                cmd.Parameters.AddWithValue("@Amount", i.Amount.ToString());
                cmd.Parameters.AddWithValue("@AssetNo", i.AssetNo);
                cmd.Parameters.AddWithValue("@ODNo", i.ODNo);
                cmd.Parameters.AddWithValue("@ContainerNo", i.ContainerNo);
                cmd.Parameters.AddWithValue("@PEZASeal", i.PEZASeal);
                cmd.Parameters.AddWithValue("@DSRDRNo", i.DSRDRNo);
                cmd.Parameters.AddWithValue("@CreatedBy", strUsername);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            Message = ex.Message.ToString();
            conn.Close();
        }
        return Message;
    }

    public void UpdateItem(Items i, string strUsername)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("UpdateItem", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ID", i.ID.ToString());
            cmd.Parameters.AddWithValue("@ControlNo", i.ControlNo);
            cmd.Parameters.AddWithValue("@ItemCode", i.ItemCode);
            cmd.Parameters.AddWithValue("@ItemDescription", i.ItemDescription);
            cmd.Parameters.AddWithValue("@Quantity", i.Quantity.ToString());
            cmd.Parameters.AddWithValue("@UnitOfMeasurement", i.UnitOfMeasurement);
            cmd.Parameters.AddWithValue("@Amount", i.Amount.ToString());
            cmd.Parameters.AddWithValue("@AssetNo", i.AssetNo);
            cmd.Parameters.AddWithValue("@ODNo", i.ODNo);
            cmd.Parameters.AddWithValue("@ContainerNo", i.ContainerNo);
            cmd.Parameters.AddWithValue("@PEZASeal", i.PEZASeal);
            cmd.Parameters.AddWithValue("@DSRDRNo", i.DSRDRNo);
            cmd.Parameters.AddWithValue("@UpdatedBy", strUsername);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                conn.Close();
            }
        }
    }

    public void DeleteItem(Items i)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("DeleteItem", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ID", i.ID.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public void Approval(Approval a)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("APPROVE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo.ToString());
            cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID.ToString());
            cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID.ToString());
            cmd.Parameters.AddWithValue("@APPROVALCOMMENTS", a.Comment.ToString());
            cmd.Parameters.AddWithValue("@UID", a.UserID.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public void RequestChange(Approval a)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("REQUEST_CHANGE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo.ToString());
            cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID.ToString());
            cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID.ToString());
            cmd.Parameters.AddWithValue("@REQUESTCHANGECOMMENT", a.Comment.ToString());
            cmd.Parameters.AddWithValue("@UID", a.UserID.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public void ReassignTask(Approval a, string strReassignto)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("REASSIGN_TASK_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo.ToString());
            cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID.ToString());
            cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID.ToString());
            cmd.Parameters.AddWithValue("@REASSIGNEDCOMMENTS", a.Comment.ToString());
            cmd.Parameters.AddWithValue("@REASSIGNEDTO", strReassignto);
            cmd.Parameters.AddWithValue("@UID", a.UserID.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public void SaveMirrorApproval(Approval a)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("SaveMirrorApproval", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo.ToString());
            cmd.Parameters.AddWithValue("@Createdby", a.Requestedby.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public void SaveApproval(Approval a)
    {
        SqlDataAdapter da = new SqlDataAdapter();
        using (var cmd = new SqlCommand("SaveApproval", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo.ToString());
            cmd.Parameters.AddWithValue("@11", a.Requestedby.ToString());
            cmd.Parameters.AddWithValue("@12", a.Checkedby.ToString());
            cmd.Parameters.AddWithValue("@13", a.Approvedby.ToString());

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }
    }

    public DataSet GetApproval(Approval a)
    {
        using (var cmd = new SqlCommand("GetApproval", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo);
            cmd.CommandTimeout = 360000;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            conn.Open();

            da.Fill(ds);
            cmd.ExecuteNonQuery();

            conn.Close();

            return ds;
        }
    }

    public DataTable GetDivision()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetDivision").Tables[0];
        return dt;
    }

    public DataTable GetNatureOfItem()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetNatureOfItem").Tables[0];
        return dt;
    }

    public DataTable GetTransferTo()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetTransferTo").Tables[0];
        return dt;
    }

    public DataTable GetTypeOfItem()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetTypeOfItem").Tables[0];
        return dt;
    }

    public DataTable GetClassificationOfItem()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetClassificationOfItem").Tables[0];
        return dt;
    }

    public DataTable GetPurposeOfItem()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetPurposeOfItem").Tables[0];
        return dt;
    }

    public DataTable GetPackagingUsed()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetPackagingUsed").Tables[0];
        return dt;
    }

    public DataTable GetSupplier()
    {
        SqlCommand cmd = new SqlCommand("GetSupplier", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            conn.Open();
            da.Fill(dt);
            conn.Close();
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
            conn.Close();
        }
        return dt;
    }

    public DataTable GetModeOfTransfer()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetModeOfTransfer").Tables[0];
        return dt;
    }

    public DataTable GetTypeOfTransfer()
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetTypeOfTransfer").Tables[0];
        return dt;
    }

    public DataTable GetRequestedby(UserInfo ui)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetRequestedby", ui.Section).Tables[0];
        return dt;
    }

    public DataTable GetCheckedby(UserInfo ui)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetCheckedby", ui.Section).Tables[0];
        return dt;
    }

    public DataTable GetApprovedby(UserInfo ui)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetApprovedby", ui.Section).Tables[0];
        return dt;
    }

    public DataTable GetReassignto(UserInfo ui, Approval a)
    {
        DataTable dt = new DataTable();
        dt = SqlHelper.ExecuteDataset(EFORS, "GetReassignto", ui.Section, a.Approvedby, a.ApproverID).Tables[0];
        return dt;
    }

    public DataTable GetGatepass(ReportDetails rd)
    {
        SqlCommand cmd = new SqlCommand("GetGatepass", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Section", rd.Section);
        cmd.Parameters.AddWithValue("@Supplier", rd.Supplier);
        cmd.Parameters.AddWithValue("@DateFrom", rd.DateFrom);
        cmd.Parameters.AddWithValue("@DateTo", rd.DateTo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();

        da.Fill(dt);

        conn.Close();

        return dt;
    }

    public DataTable GetFarmOut(ReportDetails rd)
    {
        SqlCommand cmd = new SqlCommand("GetFarmOut", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Section", rd.Section);
        cmd.Parameters.AddWithValue("@Supplier", rd.Supplier);
        cmd.Parameters.AddWithValue("@DateFrom", rd.DateFrom);
        cmd.Parameters.AddWithValue("@DateTo", rd.DateTo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();

        da.Fill(dt);

        conn.Close();

        return dt;
    }

    public string GetTasksCount()
    {
        SqlCommand cmd = new SqlCommand("GetTasksCount", conn);
        cmd.CommandType = CommandType.StoredProcedure;


        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        conn.Open();

        da.Fill(ds);

        conn.Close();

        return JsonConvert.SerializeObject(ds.Tables[1]);
    }

    public DataTable GetMyTasksCount(string APOAccount)
    {
        SqlCommand cmd = new SqlCommand("GetMyTasksCount", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@APOAccount", APOAccount);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        try
        {
            if (conn.State == ConnectionState.Open)
            {
                da.Fill(ds);
                conn.Close();
            }
            else
            {
                conn.Open();
                da.Fill(ds);
                conn.Close();
            }
            return ds.Tables[1];
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
    }

    public Boolean CheckAuthorization(string APO)
    {
        SqlCommand cmd = new SqlCommand("CheckAuthorization", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@APO", APO);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        if (conn.State == ConnectionState.Open)
        {
            da.Fill(dt);
            conn.Close();
        }
        else
        {
            conn.Open();
            da.Fill(dt);
            conn.Close();
        }

        if (dt.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public DataTable GetLOAType()
    {
        SqlCommand cmd = new SqlCommand("GetLOAType", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();

        da.Fill(dt);

        conn.Close();

        return dt;
    }

    public void SaveLOAType(string LOAType, string UserID)
    {
        using (SqlCommand cmd = new SqlCommand("sp_SaveLOAType", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@LOAType", LOAType);
            cmd.Parameters.AddWithValue("@UserID", UserID);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public DataTable GetSuppliers()
    {
        using (SqlCommand cmd = new SqlCommand("sp_GetSuppliers", conn) { CommandType = CommandType.StoredProcedure })
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                if(conn.State == ConnectionState.Open)
                {
                    da.Fill(dt);
                    conn.Close();
                }
                else
                {
                    conn.Open();
                    da.Fill(dt);
                    conn.Close();
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
            return dt;
        }
    }

    public void AddSupplier(SupplierDetails sd)
    {
        using (SqlCommand cmd = new SqlCommand("sp_AddSupplier", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@UserID", sd.UserID);
            cmd.Parameters.AddWithValue("@SupplierName", sd.Supplier);
            cmd.Parameters.AddWithValue("@SupplierAddress", sd.Address);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public void UpdateSupplier(SupplierDetails sd)
    {
        using (SqlCommand cmd = new SqlCommand("sp_UpdateSupplier", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@UserID", sd.UserID);
            cmd.Parameters.AddWithValue("@ID", sd.ID);
            cmd.Parameters.AddWithValue("@SupplierName", sd.Supplier);
            cmd.Parameters.AddWithValue("@SupplierAddress", sd.Address);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public void DeleteSupplier(SupplierDetails sd)
    {
        using (SqlCommand cmd = new SqlCommand("sp_DeleteSupplier", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@UserID", sd.UserID);
            cmd.Parameters.AddWithValue("@ID", sd.ID);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public DataTable GetFarmOutDetailsCreatorandApprover(FarmOutDetails fo)
    {
        using (SqlCommand cmd = new SqlCommand("sp_GetFarmOutDetailsCreatorandApprover", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                conn.Open();
                da.Fill(dt);
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }

            return dt;
        }
    }

    public DataTable GetTotalQuantityWithUnitOfMeasurement(FarmOutDetails fo)
    {
        using (SqlCommand cmd = new SqlCommand("sp_GetTotalQuantityWithUnitOfMeasurement", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                conn.Open();
                da.Fill(dt);
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }

            return dt;
        }
    }

    public DataTable GetTypeOfItem(FarmOutDetails fo)
    {
        using (SqlCommand cmd = new SqlCommand("sp_GetTypeOfItem", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                conn.Open();
                da.Fill(dt);
                conn.Close();
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }

            return dt;
        }
    }
}