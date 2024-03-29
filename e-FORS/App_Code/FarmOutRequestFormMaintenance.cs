﻿using System;
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
        DataSet ds = new DataSet();
        try
        {
            conn.Open();
            using (var cmd = new SqlCommand("GET_FARMOUT", conn) { CommandType = CommandType.StoredProcedure })
            {
                cmd.Parameters.AddWithValue("@CONTROLNO", fo.ControlNo);
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
        finally
        {
            conn.Close();
        }
        return ds;
    }

    public DataTable GetSupplierAddress(string SupplierID)
    {
        SqlCommand cmd = new SqlCommand("GetSupplierAddress", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@SupplierID", SupplierID);

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

    public void SaveFiles(FileDetails fd)
    {
        SqlCommand cmd = new SqlCommand("SaveFile", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", fd.ControlNo);
        cmd.Parameters.AddWithValue("@FileName", fd.FileName);
        cmd.Parameters.AddWithValue("@FilePath", fd.FilePath);
        cmd.Parameters.AddWithValue("@FileType", fd.FileType);
        cmd.Parameters.AddWithValue("@UserID", fd.UserID);

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

    public DataTable GetFiles(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("GetFiles", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

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
        catch (SqlException sqlex)
        {
            throw sqlex;
        }
        return dt;
    }

    public DataTable DeleteFile(string ControlNo, int ID)
    {
        SqlCommand cmd = new SqlCommand("DeleteFile", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);
        cmd.Parameters.AddWithValue("@ID", ID);

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

    public Boolean FarmOutRequestFormApprovalChecking(string ControlNo)
    {
        SqlCommand cmd = new SqlCommand("FarmOutRequestFormApprovalChecking", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ControlNo", ControlNo);

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