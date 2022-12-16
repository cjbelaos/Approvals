using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for FarmOutDocumentsMaintenance
/// </summary>
public class FarmOutDocumentsMaintenance
{
    private readonly string EFORS;
    readonly SqlConnection conn;

    public FarmOutDocumentsMaintenance()
    {
        EFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        conn = new SqlConnection(EFORS);
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

    public DataSet GetPreparedby()
    {
        DataSet ds = new DataSet();
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

    public DataTable GetDocumentFormattobeUsed()
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

    public DataTable GetLOANo(string LOAType)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetLOANo", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOAType", LOAType);
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

    public DataTable GetSuretyBondNo(string LOANo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetSuretyBondNo", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@LOANo", LOANo);
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

    public void SaveFarmOutDocuments(
        string ControlNo,
        string DocumentFormat,
        string PEZADocumentNo,
        string GatepassNo,
        string LOANo,
        string LOAExpiryDate,
        string SuretyBondNo,
        string SuretyExpiryDate,
        string ContainerNo,
        string PEZASeal,
        string PlateNo,
        string ControlNo8105,
        string EPPIAuthorizedSignatory,
        string PEZAExaminerSignatory,
        string PEZAOICSignatory,
        string UserName
        )
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
                cmd.Parameters.AddWithValue("@ControlNo", ControlNo);
                cmd.Parameters.AddWithValue("@DocumentFormat", DocumentFormat);
                cmd.Parameters.AddWithValue("@PEZADocumentNo", PEZADocumentNo);
                cmd.Parameters.AddWithValue("@GatepassNo", GatepassNo);
                cmd.Parameters.AddWithValue("@LOANo", LOANo);
                cmd.Parameters.AddWithValue("@LOAExpiryDate", LOAExpiryDate);
                cmd.Parameters.AddWithValue("@SuretyBondNo", SuretyBondNo);
                cmd.Parameters.AddWithValue("@SuretyExpiryDate", SuretyExpiryDate);
                cmd.Parameters.AddWithValue("@ContainerNo", ContainerNo);
                cmd.Parameters.AddWithValue("@PEZASeal", PEZASeal);
                cmd.Parameters.AddWithValue("@PlateNo", PlateNo);
                cmd.Parameters.AddWithValue("@ControlNo8105", ControlNo8105);
                cmd.Parameters.AddWithValue("@EPPIAuthorizedSignatory", EPPIAuthorizedSignatory);
                cmd.Parameters.AddWithValue("@PEZAExaminerSignatory", PEZAExaminerSignatory);
                cmd.Parameters.AddWithValue("@PEZAOICSignatory", PEZAOICSignatory);
                cmd.Parameters.AddWithValue("@CreatedBy", UserName);
                cmd.Parameters.AddWithValue("@UpdatedBy", UserName);
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
    public void Approval(LCApproval la)
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
                cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
                cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
                cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
                cmd.Parameters.AddWithValue("@APPROVALCOMMENTS", la.Comment);
                cmd.Parameters.AddWithValue("@UID", la.UserID);
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

    public void RequestChange(LCApproval la)
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
                cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
                cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
                cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
                cmd.Parameters.AddWithValue("@REQUESTCHANGECOMMENT", la.Comment);
                cmd.Parameters.AddWithValue("@UID", la.UserID);
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

    public void ReassignTask(LCApproval la, string Reassignto)
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
                cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
                cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
                cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
                cmd.Parameters.AddWithValue("@REASSIGNEDCOMMENTS", la.Comment);
                cmd.Parameters.AddWithValue("@REASSIGNEDTO", Reassignto);
                cmd.Parameters.AddWithValue("@UID", la.UserID);
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

    public DataSet GetFarmOutDocument(string ControlNo)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GET_FARMOUT_DETAILS", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
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

    public void SaveFarmOutDocumentsApproval(string ControlNo, string Preparedby, string Approvedby, string UserID)
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
                cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
                cmd.Parameters.AddWithValue("@Preparedby", Preparedby);
                cmd.Parameters.AddWithValue("@Approvedby", Approvedby);
                cmd.Parameters.AddWithValue("@UserID", UserID);
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

    public DataSet GetGatepassForPrint(string ControlNo)
    {
        DataSet ds = new DataSet();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetGatepassForPrint", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@ControlNo", ControlNo);
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

    public DataTable GetAuthorizedOfficial(string APOAccount)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("GetAuthorizedOfficial", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@APOAccount", APOAccount);
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

    public DataTable GetItemContainers(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetItemContainers", conn) { CommandType = CommandType.StoredProcedure })
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
        return dt;
    }

    public DataTable GetItemSealNo(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("sp_GetItemSealNo", conn) { CommandType = CommandType.StoredProcedure })
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
        return dt;
    }

    public Boolean FarmOutDocumentsControlNoChecking(string ControlNo)
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

    public Boolean CheckIfWithContainer(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfWithContainer", conn) { CommandType = CommandType.StoredProcedure })
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

    public Boolean CheckIfWithLOA(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfWithLOA", conn) { CommandType = CommandType.StoredProcedure })
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

    public Boolean CheckIfWithItemContainer(string ControlNo)
    {
        DataTable dt = new DataTable();
        try
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
            conn.Open();
            using (var cmd = new SqlCommand("CheckIfWithItemContainer", conn) { CommandType = CommandType.StoredProcedure })
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
}