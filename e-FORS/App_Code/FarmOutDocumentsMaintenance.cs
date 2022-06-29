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

    public DataSet GetDocumentFormattobeUsed()
    {
        SqlCommand cmd = new SqlCommand("GetDocumentFormattobeUsed", conn);
        cmd.CommandType = CommandType.StoredProcedure;

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
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
        return ds;
    }

    public DataTable GetEPPIAuthorizedSignatory()
    {
        SqlCommand cmd = new SqlCommand("GetEPPIAuthorizedSignatory", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();

        da.Fill(dt);

        conn.Close();

        return dt;
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
        string LOAType,
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
            cmd.Parameters.AddWithValue("@LOAType", LOAType);
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
    public void Approval(string ControlNo, string WorkFlowID, string ApproverID, string ApprovalComments, string UserID)
    {
        using (var cmd = new SqlCommand("APPROVE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", ApproverID);
            cmd.Parameters.AddWithValue("@APPROVALCOMMENTS", ApprovalComments);
            cmd.Parameters.AddWithValue("@UID", UserID);

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

    public void RequestChange(string ControlNo, string WorkFlowID, string ApproverID, string ApprovalComments, string UserID)
    {
        using (var cmd = new SqlCommand("REQUEST_CHANGE_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", ApproverID);
            cmd.Parameters.AddWithValue("@REQUESTCHANGECOMMENT", ApprovalComments);
            cmd.Parameters.AddWithValue("@UID", UserID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public void ReassignTask(string ControlNo, string WorkFlowID, string ApproverID, string ApprovalComments, string Reassignto, string UserID)
    {
        using (var cmd = new SqlCommand("REASSIGN_TASK_WORKFLOW", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.Parameters.AddWithValue("@WORKFLOWID", WorkFlowID);
            cmd.Parameters.AddWithValue("@APPROVERID", ApproverID);
            cmd.Parameters.AddWithValue("@REASSIGNEDCOMMENTS", ApprovalComments);
            cmd.Parameters.AddWithValue("@REASSIGNEDTO", Reassignto);
            cmd.Parameters.AddWithValue("@UID", UserID);

            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public DataSet GetFarmOutDocument(string ControlNo)
    {
        using (var cmd = new SqlCommand("GET_FARMOUT_DETAILS", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);

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

    public void SaveFarmOutDocumentsApproval(string ControlNo, string Preparedby, string Approvedby)
    {
        using (var cmd = new SqlCommand("SaveFarmOutDocumentsApproval", conn) { CommandType = CommandType.StoredProcedure })
        {
            cmd.Parameters.AddWithValue("@CONTROLNO", ControlNo);
            cmd.Parameters.AddWithValue("@Preparedby", Preparedby);
            cmd.Parameters.AddWithValue("@Approvedby", Approvedby);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            try
            {
                conn.Open();
                da.Fill(ds);
            }
            catch (Exception)
            {

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

    public DataSet PrintLOA8106(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("PrintLOA8106", conn);
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

    public DataTable GetAuthorizedOfficial(string APO)
    {
        SqlCommand cmd = new SqlCommand("GetAuthorizedOfficial", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@APOAccount", APO);

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

    public Boolean FinishTaskChecking(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("FinishTaskChecking", conn);
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

        if(dt.Rows.Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }



}