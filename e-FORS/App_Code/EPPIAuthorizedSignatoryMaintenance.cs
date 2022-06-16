using Newtonsoft.Json;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for EPPIAuthorizedSignatoryMaintenance
/// </summary>
public class EPPIAuthorizedSignatoryMaintenance
{
    private readonly string EFORS;
    readonly SqlConnection conn;

    public EPPIAuthorizedSignatoryMaintenance()
    {
        EFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        conn = new SqlConnection(EFORS);
    }

    public string GetEmployeeName(string APO)
    {
        SqlCommand cmd = new SqlCommand("GetEmployeeName", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@APOAccount", APO);

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

        return JsonConvert.SerializeObject(dt);

    }

    public string GetEPPIAuthorizedSignatory()
    {
        SqlCommand cmd = new SqlCommand("GetEPPIAuthorizedSignatory", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        conn.Open();

        da.Fill(dt);

        conn.Close();

        return JsonConvert.SerializeObject(dt);
    }

    public void SaveEPPIAuthorizedSignatory(string APO, string Name, string UserName)
    {
        SqlCommand cmd = new SqlCommand("SaveEPPIAuthorizedSignatory", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter()
        {
            ParameterName = "@APO",
            Value = APO
        });
        cmd.Parameters.Add(new SqlParameter()
        {
            ParameterName = "@Name",
            Value = Name
        });
        cmd.Parameters.Add(new SqlParameter()
        {
            ParameterName = "@UserName",
            Value = UserName
        });

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
    }

    public void DeleteEPPIAuthorizedSignatory(string APO)
    {
        SqlCommand cmd = new SqlCommand("DeleteEPPIAuthorizedSignatory", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter()
        {
            ParameterName = "@APO",
            Value = APO
        });

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
    }
}