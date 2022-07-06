using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TestPrint : System.Web.UI.Page
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
            string Date = Session["Date"].ToString();
            string AuthorizedOfficial = Session["AuthorizedOffical"].ToString();
            string ContainerNo = Session["ContainerNo"].ToString();
            string SealNo = Session["SealNo"].ToString();
            string WithContainer = Session["WithContainer"].ToString();
            string WithLOA = Session["WithLOA"].ToString();
            string WithItemContainer = Session["WithItemContainer"].ToString();

            ReportDocument reportDocument = new ReportDocument();
            dsPEZA8106 ds8106 = new dsPEZA8106();

            string reportPath;
            if ( WithContainer == "True")
            {
                reportPath = Server.MapPath("~/crPEZA8106WithContainer.rpt");
            }
            else if (WithLOA == "False")
            {
                reportPath = Server.MapPath("~/crPEZA8106WithoutLOA.rpt");
            }
            else if (WithItemContainer == "True")
            {
                reportPath = Server.MapPath("~/crPEZA8106WithItemContainer.rpt");
            }
            else 
            {
                reportPath = Server.MapPath("~/crPEZA8106.rpt");
            }

            reportDocument.Load(reportPath);

            reportDocument.SetDataSource(ds8106);
            reportDocument.SetParameterValue("@ControlNo", ControlNo);
            reportDocument.SetParameterValue("@Date", Date);
            reportDocument.SetParameterValue("@AuthorizedOfficial", AuthorizedOfficial);
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
}