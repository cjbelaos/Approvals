using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PEZA8110Print : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNo"].ToString() == null)
        {
            Response.Redirect("FarmOutDocuments.aspx");
        }
        else 
        {
            if (!Page.IsPostBack)
            {
                string ControlNo = Session["ControlNo"].ToString();
                string Date = Session["Date"].ToString();
                string AuthorizedOfficial = Session["AuthorizedOffical"].ToString();
                string TotalQuantity = Session["TotalQuantity"].ToString();

                ReportDocument reportDocument = new ReportDocument();
                dsEFORS eFORS = new dsEFORS();

                string reportPath = Server.MapPath("~/crPEZA8110.rpt");

                reportDocument.Load(reportPath);

                reportDocument.SetDataSource(eFORS);
                reportDocument.SetParameterValue("@ControlNo", ControlNo);
                reportDocument.SetParameterValue("@Date", Date);
                reportDocument.SetParameterValue("@AuthorizedOfficial", AuthorizedOfficial);
                reportDocument.SetParameterValue("@TotalQuantity", TotalQuantity);
                reportDocument.SetDatabaseLogon("sa", "Sql@dmin2015", "172.16.52.193", "db_eFORS");

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
}