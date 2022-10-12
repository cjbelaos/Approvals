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
        SqlCommand cmd = new SqlCommand("GetPEZASignatory", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

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
        return ds;
    }

    public DataSet GetPreparedby()
    {
        SqlCommand cmd = new SqlCommand("GetPreparedby", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

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
        return ds;

    }

    public DataTable GetDocumentFormattobeUsed()
    {
        SqlCommand cmd = new SqlCommand("GetDocumentFormattobeUsed", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        try
        {
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

        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
        return dt;
    }

    public DataTable GetEPPIAuthorizedSignatory()
    {
        using (var cmd = new SqlCommand("GetEPPIAuthorizedSignatory", conn) { CommandType = CommandType.StoredProcedure })
        {
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            try
            {
                if (conn.State == ConnectionState.Open)
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

    public DataTable GetLOANo(string LOAType)
    {
        using (var cmd = new SqlCommand("GetLOANo", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@LOAType", LOAType);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            if (conn.State == ConnectionState.Open)
            {
                da.Fill(dt);

                return dt;
            }
            else
            {
                conn.Open();
                da.Fill(dt);
                conn.Close();

                return dt;
            }
        }
    }

    public DataTable GetSuretyBondNo(string LOANo)
    {
        SqlCommand cmd = new SqlCommand("GetSuretyBondNo", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@LOANo", LOANo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        if (conn.State == ConnectionState.Open)
        {
            da.Fill(dt);
            conn.Close();

            return dt;
        }
        else
        {
            conn.Open();
            da.Fill(dt);
            conn.Close();

            return dt;
        }
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
            SqlCommand cmd = new SqlCommand("SaveFarmOutDocuments", conn);
            cmd.CommandType = CommandType.StoredProcedure;
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

            if (conn.State == ConnectionState.Open)
            {
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            else
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
            conn.Close();
        }
    }
    public void Approval(LCApproval la)
    {
        using (var cmd = new SqlCommand("APPROVE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
            cmd.Parameters.AddWithValue("@APPROVALCOMMENTS", la.Comment);
            cmd.Parameters.AddWithValue("@UID", la.UserID);

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            catch (Exception ex)
            {
                ex.Message.ToString();
            }

        }
    }

    public void RequestChange(LCApproval la)
    {
        using (var cmd = new SqlCommand("REQUEST_CHANGE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
            cmd.Parameters.AddWithValue("@REQUESTCHANGECOMMENT", la.Comment);
            cmd.Parameters.AddWithValue("@UID", la.UserID);

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public void ReassignTask(LCApproval la, string Reassignto)
    {
        using (var cmd = new SqlCommand("REASSIGN_TASK_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", la.ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", la.WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", la.ApproverID);
            cmd.Parameters.AddWithValue("@REASSIGNEDCOMMENTS", la.Comment);
            cmd.Parameters.AddWithValue("@REASSIGNEDTO", Reassignto);
            cmd.Parameters.AddWithValue("@UID", la.UserID);

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (SqlException sqlex)
            {
                throw sqlex;
            }
        }
    }

    public DataSet GetFarmOutDocument(string ControlNo)
    {
        using (var cmd = new SqlCommand("GET_FARMOUT_DETAILS", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.CommandTimeout = 360000;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            if (conn.State == ConnectionState.Open)
            {
                da.Fill(ds);

                return ds;
            }
            else
            {
                conn.Open();
                da.Fill(ds);

                return ds;
            }
        }
    }

    public void SaveFarmOutDocumentsApproval(string ControlNo, string Preparedby, string Approvedby, string UserID)
    {
        using (var cmd = new SqlCommand("SaveFarmOutDocumentsApproval", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.Parameters.AddWithValue("@Preparedby", Preparedby);
            cmd.Parameters.AddWithValue("@Approvedby", Approvedby);
            cmd.Parameters.AddWithValue("@UserID", UserID);

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
        }
    }

    public DataSet GetGatepassForPrint(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("GetGatepassForPrint", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();

        try
        {
            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
                da.Fill(ds);
            }
            else
            {
                da.Fill(ds);
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
        return ds;
    }

    public DataTable GetAuthorizedOfficial(string APOAccount)
    {
        SqlCommand cmd = new SqlCommand("GetAuthorizedOfficial", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@APOAccount", APOAccount);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
            {
                da.Fill(dt);
            }
            else
            {
                conn.Open();
                da.Fill(dt);
            }
            return dt;
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        finally
        {
            conn.Close();
        }

    }

    public DataTable GetItemContainers(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("sp_GetItemContainers", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
            {
                da.Fill(dt);
            }
            else
            {
                conn.Open();
                da.Fill(dt);
            }
            return dt;
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        finally
        {
            conn.Close();
        }

    }

    public DataTable GetItemSealNo(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("sp_GetItemSealNo", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
            {
                da.Fill(dt);
            }
            else
            {
                conn.Open();
                da.Fill(dt);
            }
            return dt;
        }
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        finally
        {
            conn.Close();
        }

    }

    public Boolean FarmOutDocumentsControlNoChecking(string ControlNo)
    {
        using (var cmd = new SqlCommand("FarmOutDocumentsControlNoChecking", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    da.Fill(dt);
                }
                else
                {
                    conn.Open();
                    da.Fill(dt);
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
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

    public Boolean CheckIfWithContainer(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("CheckIfWithContainer", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
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
        SqlCommand cmd = new SqlCommand("CheckIfWithLOA", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
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
        SqlCommand cmd = new SqlCommand("CheckIfWithItemContainer", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        try
        {
            if (conn.State == ConnectionState.Open)
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