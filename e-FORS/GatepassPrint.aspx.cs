using System;
using System.Data;
using System.IO;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class GatepassPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNo"].ToString() == null)
        {
            Response.Redirect("FarmOutDocuments.aspx");
        }
        else if (!Page.IsPostBack)
        {
            string ControlNo = Session["ControlNo"].ToString();
            string TotalQuantity = Session["TotalQuantity"].ToString();
            string Date = Session["Date"].ToString();
            string PreparedBy = Session["PreparedBy"].ToString();
            string Approvedby = Session["Approvedby"].ToString();
            string ContainerNo = Session["ContainerNo"].ToString();
            string SealNo = Session["SealNo"].ToString();
            string WithItemContainer = Session["WithItemContainer"].ToString();

            ReportDocument reportDocument = new ReportDocument();
            dsPEZA8106 ds8106 = new dsPEZA8106();

            string reportPath;
            if (WithItemContainer == "True")
            {
                reportPath = Server.MapPath("~/crGatepassWithItemContainer.rpt");
            }
            else
            {
                reportPath = Server.MapPath("~/crGatepass.rpt");
            }

            reportDocument.Load(reportPath);

            reportDocument.SetDataSource(ds8106);
            reportDocument.SetParameterValue("@ControlNo", ControlNo);
            reportDocument.SetParameterValue("@TotalQuantity", TotalQuantity);
            reportDocument.SetParameterValue("@Date", Date);
            reportDocument.SetParameterValue("@PreparedBy", PreparedBy);
            reportDocument.SetParameterValue("@Approvedby", Approvedby);
            reportDocument.SetParameterValue("@ContainerNo", ContainerNo);
            reportDocument.SetParameterValue("@SealNo", SealNo);
            reportDocument.SetDatabaseLogon("sa", "sqladmin", "172.16.53.149", "db_EFORS");

            //Load the report by setting the report source
            CrystalReportViewer1.ReportSource = reportDocument;

            ExportOptions options = new ExportOptions();

            options.ExportFormatType = ExportFormatType.PortableDocFormat;

            options.FormatOptions = new PdfRtfWordFormatOptions();

            ExportRequestContext req = new ExportRequestContext();

            req.ExportInfo = options;


            Stream s = reportDocument.FormatEngine.ExportToStream(req);

            Response.ClearHeaders();

            Response.ClearContent();

            Response.ContentType = "application/pdf";


            s.Seek(0, SeekOrigin.Begin);

            byte[] buffer = new byte[s.Length];

            s.Read(buffer, 0, (int)s.Length);

            Response.BinaryWrite(buffer);

            Response.End();

            reportDocument.Close();
            reportDocument.Dispose();

        }
    }
    //private void PrintGatepass()
    //{
    //    string DateOfPullOut = Session["DateOfPullOut"].ToString();

    //    DataSet ds = (DataSet)Session["dsGatepass"];
    //    dvTable = ds.Tables[0].DefaultView;
    //    dvTable1 = ds.Tables[1].DefaultView;
    //    dvTable2 = ds.Tables[2].DefaultView;
    //    dvTable3 = ds.Tables[3].DefaultView;
    //    dvTable4 = ds.Tables[4].DefaultView;

    //    dsGatepass dg = new dsGatepass();
    //    ReportDocument crystalReport = new ReportDocument();

    //    string Section = "", RequestorEmployeeName = "", BearerEmployeeName = "", TypeOfItem = "", PurposeOfItem = "", Destination = "", TargetDateofReturn = "";
    //    string No = "", Quantity = "", ItemCode = "", ItemDescription = "";
    //    string Total = "", TotalQTY = "";
    //    string FullName1 = "";
    //    string FullName2 = "";

    //    if (dvTable.Count > 0)
    //    {
    //        foreach (DataRow dr in dvTable.Table.Rows)
    //        {
    //            Section = dr["SECTION"].ToString().ToUpper();
    //            RequestorEmployeeName = dr["RequestorEmployeeName"].ToString().ToUpper();
    //            BearerEmployeeName = dr["BearerEmployeeName"].ToString().ToUpper();
    //            TypeOfItem = dr["TypeOfItem"].ToString().ToUpper();
    //            PurposeOfItem = dr["PurposeOfItem"].ToString().ToUpper();
    //            Destination = dr["Destination"].ToString().ToUpper();
    //            TargetDateofReturn = dr["TargetDateofReturn"].ToString().ToUpper();

    //            dg.DataTable1.AddDataTable1Row(Section, RequestorEmployeeName, BearerEmployeeName, TypeOfItem, PurposeOfItem, Destination, TargetDateofReturn);
    //        }
    //    }

    //    if (dvTable1.Count > 0)
    //    {
    //        foreach (DataRow dr in dvTable1.Table.Rows)
    //        {
    //            No = dr["No"].ToString().ToUpper();
    //            Quantity = dr["Quantity"].ToString().ToUpper();
    //            ItemCode = dr["ItemCode"].ToString().ToUpper();
    //            ItemDescription = dr["ItemDescription"].ToString().ToUpper();

    //            dg.DataTable2.AddDataTable2Row(No, Quantity, ItemCode, ItemDescription);
    //        }
    //    }

    //    if (dvTable2.Count > 0)
    //    {
    //        foreach (DataRow dr in dvTable2.Table.Rows)
    //        {
    //            Total = dr["Total"].ToString().ToUpper();
    //            TotalQTY = dr["TotalQTY"].ToString().ToUpper();

    //            dg.DataTable3.AddDataTable3Row(Total, TotalQTY);
    //        }
    //    }

    //    if (dvTable3.Count > 0)
    //    {
    //        foreach (DataRow dr in dvTable3.Table.Rows)
    //        {
    //            FullName1 = dr["FullName"].ToString().ToUpper();

    //            dg.DataTable4.AddDataTable4Row(FullName1);
    //        }
    //    }

    //    if (dvTable4.Count > 0)
    //    {
    //        foreach (DataRow dr in dvTable4.Table.Rows)
    //        {
    //            FullName2 = dr["FullName"].ToString().ToUpper();

    //            dg.DataTable5.AddDataTable5Row(FullName2);
    //        }
    //    }

    //    crystalReport.Load(Server.MapPath("~/crGatepass.rpt"));

    //    crystalReport.SetDataSource(dg);
    //    crystalReport.SetParameterValue("@DateOfPullOut", DateOfPullOut);
    //    CrystalReportViewer1.ReportSource = crystalReport;

    //    ExportOptions options = new ExportOptions();

    //    options.ExportFormatType = ExportFormatType.PortableDocFormat;

    //    options.FormatOptions = new PdfRtfWordFormatOptions();

    //    ExportRequestContext req = new ExportRequestContext();

    //    req.ExportInfo = options;


    //    Stream s = crystalReport.FormatEngine.ExportToStream(req);

    //    Response.ClearHeaders();

    //    Response.ClearContent();

    //    Response.ContentType = "application/pdf";


    //    s.Seek(0, SeekOrigin.Begin);

    //    byte[] buffer = new byte[s.Length];

    //    s.Read(buffer, 0, (int)s.Length);

    //    Response.BinaryWrite(buffer);

    //    Response.End();

    //    crystalReport.Close();
    //    crystalReport.Dispose();

    //}
}