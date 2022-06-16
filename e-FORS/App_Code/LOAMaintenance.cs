using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for LOAMaintenance
/// </summary>
public class LOAMaintenance
{
    private readonly string EFORS;
    readonly SqlConnection conn;

    public LOAMaintenance()
    {
        this.EFORS = System.Configuration.ConfigurationManager.AppSettings["EFORS"];
        conn = new SqlConnection(EFORS);
    }

    public DataTable GetLOA(ReportDetails rd)
    {
        SqlCommand cmd = new SqlCommand("GetLOA", conn);
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
}