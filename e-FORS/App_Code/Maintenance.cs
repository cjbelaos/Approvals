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

    public DataTable GetUser(LoginDetails ld)
    {
        DataTable dt = new DataTable();
        try
        {
            if (SqlConEPPIIIP.State == ConnectionState.Open)
            {
                SqlConEPPIIIP.Close();
            }
            SqlConEPPIIIP.Open();
            using (var cmd = new SqlCommand("LOGIN_GetUser", SqlConEPPIIIP) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@system_name", ld.system);
                cmd.Parameters.AddWithValue("@user_id", ld.username);
                cmd.Parameters.AddWithValue("@password", ld.password);
                cmd.Parameters.AddWithValue("@LDAP", ld.ldap);

                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            SqlConEPPIIIP.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            SqlConEPPIIIP.Close();
        }
        return dt;
    }

    public DataTable GetAllTasks()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GET_TASKLIST_ALL", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                } 
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetPendingTasks(string UserID)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GET_TASKLIST_SECTION_REQUESTOR", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", UserID);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetMyTasks(string UserID)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GET_TASKLIST_USER", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", UserID);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinishedTasks()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetFinishedTasks", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinishedTasksPerSection(string UserID)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetFinishedTasksPerSection", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", UserID);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetCancelledTasks()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetCancelledTasks", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinished8112Tasks(string DIVISION, string LOANO, string SUPPLIER, string PURPOSE)
    {
        if (DIVISION == null)
        {
            DIVISION = "";
        }
        if (LOANO == null)
        {
            LOANO = "";
        }
        if (SUPPLIER == null)
        {
            SUPPLIER = "";
        }
        if (PURPOSE == null)
        {
            PURPOSE = "";
        }

        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetFinished8112Tasks", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@DIVISION", DIVISION);
                cmd.Parameters.AddWithValue("@LOANO", LOANO);
                cmd.Parameters.AddWithValue("@SUPPLIER", SUPPLIER);
                cmd.Parameters.AddWithValue("@PURPOSE", PURPOSE);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinished8112LOANOs()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetFinished8112LOANOs", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinished8112Purpose()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetFinished8112Purpose", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFinished8112Suppliers()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetFinished8112Suppliers", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public Boolean FinishTaskChecking(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("FinishTaskChecking", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public Boolean CheckIfCancelled(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfCancelled", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public Boolean CheckIfFinishedRequestor(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfFinishedRequestor", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public Boolean CheckIfApproveByRequestor(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfApproveByRequestor", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public DataTable GetAssignedForRequestChange(FarmOutDocumentDetails fod)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetAssignedForRequestChange", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fod.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataSet SaveFarmOutRequestForm(FarmOutDetails fo, string strUsername)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
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
                cmd.Parameters.AddWithValue("@SupplierID", fo.SupplierID);
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
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    //public DataSet GetUserInformation(string UserID)
    //{
    //    DataSet ds = new DataSet();
    //    try
    //    {
    //        if (SqlConEPPIIIP_New.State == ConnectionState.Open)
    //        {
    //            SqlConEPPIIIP_New.Close();
    //        }
    //        SqlConEPPIIIP_New.Open();
    //        using (var cmd = new SqlCommand("GetUserInformation", SqlConEPPIIIP_New) { CommandType = CommandType.StoredProcedure })
    //        {
    //            cmd.Parameters.AddWithValue("@APOAccount", UserID);
    //            using (var da = new SqlDataAdapter(cmd))
    //            {
    //                da.Fill(ds);
    //            }
    //        }
    //        SqlConEPPIIIP_New.Close();
    //    }
    //    catch (SqlException sqlex)
    //    {
    //        throw sqlex;
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //    finally
    //    {
    //        SqlConEPPIIIP_New.Close();
    //    }
    //    return ds;
    //}

    public DataSet GetUserInformation(string UserID)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetUserInformation", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@APOAccount", UserID);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public string GetSectionDepartment(string Section)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            SqlConEPPIIIP_New.Open();
            using (var cmd = new SqlCommand("GetSectionDepartment", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@SECTION", Section);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt.Rows[0]["DEPARTMENTNAME"].ToString();
    }

    public DataTable GetAllItems(string strControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetAllItems", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", strControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public void SaveSupplier(string UserName, string Supplier, string LOAType, string LOANo, string ExpirationDate1, string LOAAmountLimit, string LOAQuantityLimit, string SuretyBondNo, string ExpirationDate2)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveSupplier", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@Username", UserName);
                cmd.Parameters.AddWithValue("@SupplierName", Supplier);
                cmd.Parameters.AddWithValue("@LOAType", LOAType);
                cmd.Parameters.AddWithValue("@LOANo", LOANo);
                cmd.Parameters.AddWithValue("@LOAExpirationDate", ExpirationDate1);
                cmd.Parameters.AddWithValue("@AmountLimit", LOAAmountLimit);
                cmd.Parameters.AddWithValue("@QuantityLimit", LOAQuantityLimit);
                cmd.Parameters.AddWithValue("@SuretyBondNo", SuretyBondNo);
                cmd.Parameters.AddWithValue("@SuretyExpirationDate", ExpirationDate2);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public string SaveItem(Items i, string strUsername)
    {
        string Message = "";
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveItem", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", i.ControlNo);
                cmd.Parameters.AddWithValue("@TypeOfItem", i.TypeOfItem);
                cmd.Parameters.AddWithValue("@ItemCode", i.ItemCode);
                cmd.Parameters.AddWithValue("@ItemDescription", i.ItemDescription);
                cmd.Parameters.AddWithValue("@Quantity", i.Quantity);
                cmd.Parameters.AddWithValue("@UnitOfMeasurement", i.UnitOfMeasurement);
                cmd.Parameters.AddWithValue("@Amount", i.Amount.ToString());
                cmd.Parameters.AddWithValue("@AssetNo", i.AssetNo);
                cmd.Parameters.AddWithValue("@ODNo", i.ODNo);
                cmd.Parameters.AddWithValue("@ContainerNo", i.ContainerNo);
                cmd.Parameters.AddWithValue("@PEZASeal", i.PEZASeal);
                cmd.Parameters.AddWithValue("@DSRDRNo", i.DSRDRNo);
                cmd.Parameters.AddWithValue("@CreatedBy", strUsername);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            Message = sqlex.Message.ToString();
        }
        catch (Exception ex)
        {
            Message = ex.Message.ToString();
        }
        finally
        {
            conn.Close();
        }
        return Message;
    }

    public void UpdateItem(Items i, string strUsername)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("UpdateItem", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ID", i.ID.ToString());
                cmd.Parameters.AddWithValue("@ControlNo", i.ControlNo);
                cmd.Parameters.AddWithValue("@TypeOfItem", i.TypeOfItem);
                cmd.Parameters.AddWithValue("@ItemCode", i.ItemCode);
                cmd.Parameters.AddWithValue("@ItemDescription", i.ItemDescription);
                cmd.Parameters.AddWithValue("@Quantity", i.Quantity);
                cmd.Parameters.AddWithValue("@UnitOfMeasurement", i.UnitOfMeasurement);
                cmd.Parameters.AddWithValue("@Amount", i.Amount);
                cmd.Parameters.AddWithValue("@AssetNo", i.AssetNo);
                cmd.Parameters.AddWithValue("@ODNo", i.ODNo);
                cmd.Parameters.AddWithValue("@ContainerNo", i.ContainerNo);
                cmd.Parameters.AddWithValue("@PEZASeal", i.PEZASeal);
                cmd.Parameters.AddWithValue("@DSRDRNo", i.DSRDRNo);
                cmd.Parameters.AddWithValue("@UpdatedBy", strUsername);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void DeleteItem(Items i)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("DeleteItem", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ID", i.ID.ToString());

                cmd.ExecuteNonQuery(); 
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void Approval(Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("APPROVE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo);
                cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID);
                cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID);
                cmd.Parameters.AddWithValue("@APPROVALCOMMENTS", a.Comment);
                cmd.Parameters.AddWithValue("@UID", a.UserID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public string GetRequestCreator(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetRequestCreator", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);

                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt.Rows[0]["ASSIGNEDUSERID"].ToString();
    }

    public void RequestChange(Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("REQUEST_CHANGE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo);
                cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID);
                cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID);
                cmd.Parameters.AddWithValue("@REQUESTCHANGECOMMENT", a.Comment);
                cmd.Parameters.AddWithValue("@UID", a.UserID);
                cmd.ExecuteNonQuery(); 
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void ReassignTask(Approval a, string strReassignto)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("REASSIGN_TASK_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo.ToString());
                cmd.Parameters.AddWithValue("@WORKFLOWID", a.WorkFlowID.ToString());
                cmd.Parameters.AddWithValue("@APPROVERID", a.ApproverID.ToString());
                cmd.Parameters.AddWithValue("@REASSIGNEDCOMMENTS", a.Comment.ToString());
                cmd.Parameters.AddWithValue("@REASSIGNEDTO", strReassignto);
                cmd.Parameters.AddWithValue("@UID", a.UserID.ToString());
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void SaveMirrorApproval(Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveMirrorApproval", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo);
                cmd.Parameters.AddWithValue("@Createdby", a.UserID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void SaveApproval(Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveApproval", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo);
                cmd.Parameters.AddWithValue("@Requestedby", a.Requestedby);
                cmd.Parameters.AddWithValue("@Checkedby", a.Checkedby);
                cmd.Parameters.AddWithValue("@Approvedby", a.Approvedby);
                cmd.Parameters.AddWithValue("@UserID", a.UserID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void UpdateApproval(string ControlNo, string ApproverID, string ApproverUserID, string UserID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("UpdateApproval", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                cmd.Parameters.AddWithValue("@APPROVERID", ApproverID);
                cmd.Parameters.AddWithValue("@APPROVERUSERID", ApproverUserID);
                cmd.Parameters.AddWithValue("@USERID", UserID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public DataSet GetApproval(Approval a)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetApproval", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", a.ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
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
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetGatepass", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@Section", rd.Section);
                cmd.Parameters.AddWithValue("@Supplier", rd.Supplier);
                cmd.Parameters.AddWithValue("@DateFrom", rd.DateFrom);
                cmd.Parameters.AddWithValue("@DateTo", rd.DateTo); ;
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataSet GetFarmOut(ReportDetails rd)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetFarmOut", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@Section", rd.Section);
                cmd.Parameters.AddWithValue("@Supplier", rd.Supplier);
                cmd.Parameters.AddWithValue("@DateFrom", rd.DateFrom);
                cmd.Parameters.AddWithValue("@DateTo", rd.DateTo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public DataTable GetTasksCount()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetTasksCount", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }


    public DataTable GetMyTasksCount(string APOAccount)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetMyTasksCount", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@APOAccount", APOAccount);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds.Tables[1];
    }

    public Boolean CheckAuthorization(string APO)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckAuthorization", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@APO", APO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public Boolean CheckIfBypassAccount(LoginDetails ld)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfBypassAccount", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@username", ld.username);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public DataTable GetFarmOutDetailsCreatorandApprover(FarmOutDetails fo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetFarmOutDetailsCreatorandApprover", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetTotalQuantityWithUnitOfMeasurement(FarmOutDetails fo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetTotalQuantityWithUnitOfMeasurement", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", fo.ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetLOAofSupplierInControlNo(FarmOutDetails fo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLOAofSupplierInControlNo", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fo.ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetControlNoOf8112WithSameLOA(string LOA, string CTRLNO)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetControlNoOf8112WithSameLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOA", LOA);
                cmd.Parameters.AddWithValue("@CTRLNO", CTRLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public string Get8112Dates(string CTRLNOS)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_Get8112Dates", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CTRLNOS", CTRLNOS);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        if (dt.Rows.Count > 0)
        {
            return dt.Rows[0]["ACTUALDELIVERYDATES"].ToString();
        }
        else
        {
            return "";
        }
    }

    public DataTable GetSuppliers()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetSuppliers", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public void AddSupplier(SupplierDetails sd, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_AddSupplier", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@SUPPLIERNAME", sd.Supplier);
                cmd.Parameters.AddWithValue("@SUPPLIERADDRESS", sd.Address);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void UpdateSupplier(SupplierDetails sd, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_UpdateSupplier", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@SUPPLIERID", sd.ID);
                cmd.Parameters.AddWithValue("@SUPPLIERNAME", sd.Supplier);
                cmd.Parameters.AddWithValue("@SUPPLIERADDRESS", sd.Address);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void DeleteSupplier(SupplierDetails sd, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_DeleteSupplier", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@SUPPLIERID", sd.ID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public DataTable GetLOA()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public void AddLOA(LOADetails ld, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_AddLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@SUPPLIERID", ld.SUPPLIERID);
                cmd.Parameters.AddWithValue("@DIVISION", ld.DIVISION);
                cmd.Parameters.AddWithValue("@LOANO", ld.LOANO);
                cmd.Parameters.AddWithValue("@LOAEXP", ld.LOAEXP);
                cmd.Parameters.AddWithValue("@SBNO", ld.SBNO);
                cmd.Parameters.AddWithValue("@SBEXP", ld.SBEXP);
                cmd.Parameters.AddWithValue("@DESCRIPTION", ld.DESCRIPTION);
                cmd.Parameters.AddWithValue("@QTYLIMIT", ld.QTYLIMIT);
                cmd.Parameters.AddWithValue("@UM", ld.UM);
                cmd.Parameters.AddWithValue("@AMTLIMIT", ld.AMTLIMIT);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void UpdateLOA(LOADetails ld, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_UpdateLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@SUPPLIERID", ld.SUPPLIERID);
                cmd.Parameters.AddWithValue("@LOAID", ld.LOAID);
                cmd.Parameters.AddWithValue("@DIVISION", ld.DIVISION);
                cmd.Parameters.AddWithValue("@LOANO", ld.LOANO);
                cmd.Parameters.AddWithValue("@LOAEXP", ld.LOAEXP);
                cmd.Parameters.AddWithValue("@SBNO", ld.SBNO);
                cmd.Parameters.AddWithValue("@SBEXP", ld.SBEXP);
                cmd.Parameters.AddWithValue("@DESCRIPTION", ld.DESCRIPTION);
                cmd.Parameters.AddWithValue("@QTYLIMIT", ld.QTYLIMIT);
                cmd.Parameters.AddWithValue("@UM", ld.UM);
                cmd.Parameters.AddWithValue("@AMTLIMIT", ld.AMTLIMIT);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void DeleteLOA(LOADetails ld, string USERID)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_DeleteLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@USERID", USERID);
                cmd.Parameters.AddWithValue("@LOAID", ld.LOAID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public DataTable GetLOAInvetory()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLOA_Inventory", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetLOAInventoryDetails(LOAInventoryDetails lid)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLOA_Inventory_Details", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOAID", lid.LOAID);
                cmd.Parameters.AddWithValue("@SUPPLIERID", lid.SUPPLIERID);
                cmd.Parameters.AddWithValue("@DIVISION", lid.DIVISION);
                cmd.Parameters.AddWithValue("@LOANO", lid.LOANO);
                cmd.Parameters.AddWithValue("@DATEFROM", lid.DATEFROM);
                cmd.Parameters.AddWithValue("@DATETO", lid.DATETO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetLOADetails(LOADetails ld)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetLOADetails", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOANO", ld.LOANO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetItemType(SupplierDetails sd, LOADetails ld)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetItemType", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@SUPPLIERID", sd.ID);
                cmd.Parameters.AddWithValue("@DIVISION", ld.DIVISION);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetFarmOutDocument(FarmOutDetails fd)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetFarmOutDocument", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fd.ControlNo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetDocumentFormat()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetDocumentFormattobeUsed", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetEPPIAuthorizedSignatory()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetEPPIAuthorizedSignatory", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetPreparedby()
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetPreparedby", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public void SaveFarmOutDocuments(FarmOutDocumentDetails fdd)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveFarmOutDocuments", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", fdd.CONTROLNO);
                cmd.Parameters.AddWithValue("@DocumentFormat", fdd.DOCFORMAT);
                cmd.Parameters.AddWithValue("@PEZADocumentNo", fdd.PEZADOCNO);
                cmd.Parameters.AddWithValue("@GatepassNo", fdd.GPNO);
                cmd.Parameters.AddWithValue("@LOANo", fdd.LOANO);
                cmd.Parameters.AddWithValue("@LOAExpiryDate", fdd.LOAEXP);
                cmd.Parameters.AddWithValue("@SuretyBondNo", fdd.SBNO);
                cmd.Parameters.AddWithValue("@SuretyExpiryDate", fdd.SBEXP);
                cmd.Parameters.AddWithValue("@ContainerNo", fdd.CONTNO);
                cmd.Parameters.AddWithValue("@PEZASeal", fdd.PEZASEAL);
                cmd.Parameters.AddWithValue("@PlateNo", fdd.PLATENO);
                cmd.Parameters.AddWithValue("@ControlNo8105", fdd.CN8105);
                cmd.Parameters.AddWithValue("@EPPIAuthorizedSignatory", fdd.EPPIAS);
                cmd.Parameters.AddWithValue("@PEZAExaminerSignatory", fdd.PEZAES);
                cmd.Parameters.AddWithValue("@PEZAOICSignatory", fdd.PEZAOIC);
                cmd.Parameters.AddWithValue("@CreatedBy", fdd.USERID);
                cmd.Parameters.AddWithValue("@UpdatedBy", fdd.USERID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void SaveFarmOutDocumentsApproval(FarmOutDocumentDetails fdd)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SaveFarmOutDocumentsApproval", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fdd.CONTROLNO);
                cmd.Parameters.AddWithValue("@Preparedby", fdd.PREPARED);
                cmd.Parameters.AddWithValue("@Approvedby", fdd.APPROVED);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void DeleteFile(FileDetails fd)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_DeleteFile", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fd.ControlNo);
                cmd.Parameters.AddWithValue("@FILENAME", fd.FileName);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public Boolean FarmOutDocumentsControlNoChecking(FarmOutDocumentDetails fdd)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("FarmOutDocumentsControlNoChecking", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fdd.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public DataSet GetPEZASignatory()
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetPEZASignatory", conn) { CommandType = CommandType.StoredProcedure })
            {
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public Boolean CheckPurposeOfItemIfWithLOA(FarmOutDocumentDetails fdd)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckPurposeOfItemIfWithLOA", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fdd.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
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

    public void SendEmail(EmailDetails ed)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SEND_EMAIL", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ed.CONTROLNO);
                cmd.Parameters.AddWithValue("@FROM", ed.FROM_EMAIL);
                cmd.Parameters.AddWithValue("@TO", ed.TO_EMAIL);
                cmd.Parameters.AddWithValue("@EMAILTYPE", ed.EMAILTYPE);
                cmd.Parameters.AddWithValue("@COMMENT", ed.COMMENT);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void SendEmailRequestApproved(EmailDetails ed)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SendEmailRequestApproved", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ed.CONTROLNO);
                cmd.Parameters.AddWithValue("@FROM", ed.FROM_EMAIL);
                cmd.Parameters.AddWithValue("@TO", ed.TO_EMAIL);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        } 
    }

    public void AddPrinted8112(Printed8112 p8112)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_AddPrinted8112", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", p8112.CONTROLNO);
                cmd.Parameters.AddWithValue("@SUBCONTROLNO", p8112.SUBCONTROLNO);
                cmd.Parameters.AddWithValue("@USERID", p8112.USERID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public DataTable GetCtrlNoPrinted8112(Printed8112 p8112)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetCtrlNoPrinted8112", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", p8112.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetSumofQty8112Items(Printed8112 p8112)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetSumofQty8112Items", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", p8112.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetMultipleUOM(FarmOutDocumentDetails fdd)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetMultipleUOM", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fdd.CONTROLNO);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataSet GetLOAReport(ReportDetails rd)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLOAReport", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@SECTION", rd.Section);
                cmd.Parameters.AddWithValue("@SUPPLIER", rd.Supplier);
                cmd.Parameters.AddWithValue("@DATEFROM", rd.DateFrom);
                cmd.Parameters.AddWithValue("@DATETO", rd.DateTo);
                cmd.Parameters.AddWithValue("@LOANO", rd.LOANo);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public DataSet GetLiquidationLedger(ReportDetails rd)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLiquidationLedger", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOANO", rd.LOANo); ;
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public DataTable GetLiquidationLedgerInfo (LiquidationLedgerDetails ll)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetLiquidationLedgerInfo", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOANO", ll.LOANO);
                cmd.Parameters.AddWithValue("@SUPPLIERID", ll.SUPPLIERID);
                cmd.Parameters.AddWithValue("@TYPEOFITEM", ll.TYPEOFITEM);
                cmd.Parameters.AddWithValue("@PEZADOCUMENTNO", ll.PEZADOCUMENTNO);
                cmd.Parameters.AddWithValue("@DATEOFTRANSFER", ll.DATEOFTRANSFER);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public DataTable GetLOALimitPercentage(LOADetails ld)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetLOALimitPercentage", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@SUPPLIERID", ld.SUPPLIERID);
                cmd.Parameters.AddWithValue("@DIVISION", ld.DIVISION);
                cmd.Parameters.AddWithValue("@DESCRIPTION", ld.DESCRIPTION);
                using (var da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
        return dt;
    }

    public void SendEmailLOALimit(FarmOutDetails fod, Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("SendEmailLOALimit", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@FROM", a.Requestedby);
                cmd.Parameters.AddWithValue("@SUPPLIERID", fod.SupplierID);
                cmd.Parameters.AddWithValue("@DIVISION", fod.Division);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void CancelRequest(Approval a)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_CancelRequest", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", a.ControlNo);
                cmd.Parameters.AddWithValue("@COMMENT", a.Comment);
                cmd.Parameters.AddWithValue("@USERID", a.UserID);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void MarkAsPrinted(string ControlNo, string UserId)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_MarkAsPrinted", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                cmd.Parameters.AddWithValue("@USERID", UserId);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }

    public void RemoveMarkAsPrinted(string ControlNo, string UserId)
    {
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_RemoveMarkAsPrinted", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                cmd.Parameters.AddWithValue("@USERID", UserId);
                cmd.ExecuteNonQuery();
            }
            conn.Close();
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            conn.Close();
        }
    }
}