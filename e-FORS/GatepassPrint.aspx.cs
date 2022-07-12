using System;
using System.Data;
using System.IO;
using System.Web;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class GatepassPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNo"].ToString() == null)
        {
            Response.Redirect("FarmOutDocuments.aspx?expired=1");
        }
        else 
        {
            if (!Page.IsPostBack)
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
                dsEFORS eFORS = new dsEFORS();

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

                reportDocument.SetDataSource(eFORS);
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
    }
}