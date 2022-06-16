using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for FarmOutRequestFormMaintenance
/// </summary>
public class FarmOutRequestFormMaintenance
{
    private readonly string EFORS;
    readonly SqlConnection conn;

    public FarmOutRequestFormMaintenance()
    {
        this.EFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        conn = new SqlConnection(EFORS);
    }

    public DataSet GetFarmOut(FarmOutDetails fo)
    {
        SqlCommand cmd = new SqlCommand("GET_FARMOUT", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CONTROLNO", fo.ControlNo);
        cmd.CommandTimeout = 360000;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        try
        {
            conn.Open();
            da.Fill(ds);
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

    public DataTable GetSupplierAddress(string Supplier)
    {
        SqlCommand cmd = new SqlCommand("GetSupplierAddress", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Supplier", Supplier);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        try
        {
            conn.Open();
            da.Fill(dt);
            conn.Close();
        }
        catch
        {
            conn.Close();
        }

        return dt;
    }

    public void SaveFiles(string ControlNo, string FileName, string FilePath, string FileType, string UserName)
    {
        SqlCommand cmd = new SqlCommand("SaveFiles", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);
        cmd.Parameters.AddWithValue("@FileName", FileName);
        cmd.Parameters.AddWithValue("@FilePath", FilePath);
        cmd.Parameters.AddWithValue("@FileType", FileType);
        cmd.Parameters.AddWithValue("@UserName", UserName);

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
    }

    public DataTable GetFiles(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("GetFiles", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();
        da.Fill(dt);
        conn.Close();

        return dt;
    }

    public DataTable GetBearerEmployeeName(string EmployeeNo)
    {
        SqlCommand cmd = new SqlCommand("GetBearerEmployeeName", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmployeeNo", EmployeeNo);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();
        da.Fill(dt);
        conn.Close();

        return dt;
    }
}