using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Data;
using System.IO;

public partial class PEZA8106Print : System.Web.UI.Page
{
    DataView dvTable = new DataView();
    DataView dvTable1 = new DataView();
    DataView dvTable2 = new DataView();
    DataView dvTable3 = new DataView();
    protected void Page_Load(object sender, EventArgs e)
    {
        PrintPEZA8106();
    }

    private void PrintPEZA8106()
    {
        DataSet ds = (DataSet)Session["dsPEZA8106"];
        DataTable dt = (DataTable)Session["dtAuthorizedOfficial"];
        dvTable = ds.Tables[0].DefaultView;
        dvTable1 = ds.Tables[1].DefaultView;
        dvTable2 = ds.Tables[2].DefaultView;
        dvTable3 = dt.DefaultView;

        dsPEZA8106 ds8106 = new dsPEZA8106();
        ReportDocument crystalReport = new ReportDocument();

        string ItemCode = "", Quantity = "", UnitOfMeasurement = "", Amount = "";
        string PurposeOfItem = "", Destination = "";
        string LOA = "", SB = "", CONTROLNO = "", GATEPASSNO = "";
        string AuthorizedOfficial = "";

        if (dvTable.Count > 0)
        {
            foreach (DataRow dr in dvTable.Table.Rows)
            {
                ItemCode = dr["ItemCode"].ToString().ToUpper();
                Quantity = dr["Quantity"].ToString().ToUpper();
                UnitOfMeasurement = dr["UnitOfMeasurement"].ToString().ToUpper();
                Amount = dr["Amount"].ToString().ToUpper();

                ds8106.DataTable1.AddDataTable1Row(ItemCode, Quantity, UnitOfMeasurement, Amount);
            }
        }

        if (dvTable1.Count > 0)
        {
            foreach (DataRow dr in dvTable1.Table.Rows)
            {
                PurposeOfItem = dr["PurposeOfItem"].ToString().ToUpper();
                Destination = dr["Destination"].ToString().ToUpper();

                ds8106.DataTable2.AddDataTable2Row(PurposeOfItem, Destination);
            }
        }

        if (dvTable2.Count > 0)
        {
            foreach (DataRow dr in dvTable2.Table.Rows)
            {
                LOA = dr["LOA"].ToString().ToUpper();
                SB = dr["SB"].ToString().ToUpper();
                CONTROLNO = dr["CONTROLNO"].ToString().ToUpper();
                GATEPASSNO = dr["GATEPASSNO"].ToString().ToUpper();

                ds8106.DataTable3.AddDataTable3Row(LOA, SB, CONTROLNO, GATEPASSNO);
            }
        }

        if (dvTable3.Count > 0)
        {
            foreach (DataRow dr in dvTable3.Table.Rows)
            {
                AuthorizedOfficial = dr["AuthorizedOfficial"].ToString().ToUpper();

                ds8106.DataTable4.AddDataTable4Row(AuthorizedOfficial);
            }
        }

        crystalReport.Load(Server.MapPath("~/crPEZA8106.rpt"));

        crystalReport.SetDataSource(ds8106);
        CrystalReportViewer1.ReportSource = crystalReport;

        ExportOptions options = new ExportOptions();

        options.ExportFormatType = ExportFormatType.PortableDocFormat;

        options.FormatOptions = new PdfRtfWordFormatOptions();

        ExportRequestContext req = new ExportRequestContext();

        req.ExportInfo = options;


        Stream s = crystalReport.FormatEngine.ExportToStream(req);

        Response.ClearHeaders();

        Response.ClearContent();

        Response.ContentType = "application/pdf";


        s.Seek(0, SeekOrigin.Begin);

        byte[] buffer = new byte[s.Length];

        s.Read(buffer, 0, (int)s.Length);

        Response.BinaryWrite(buffer);

        Response.End();

        crystalReport.Close();
        crystalReport.Dispose();

    }
}