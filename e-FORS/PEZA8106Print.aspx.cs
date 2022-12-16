using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.IO;
using System.Web.UI;


public partial class TestPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNo"] == null)
        {
            Response.Redirect("FarmOutDocuments.aspx?expired=1");
        }
        else 
        {
            if (!Page.IsPostBack)
            {
                string ControlNo = Session["ControlNo"].ToString();
                string Date = Session["Date"].ToString();
                string AuthorizedOfficial = Session["AuthorizedOffical"].ToString();
                string ContainerNo = Session["ContainerNo"].ToString();
                string SealNo = Session["SealNo"].ToString();
                string UOM = Session["UOM"].ToString();
                string WithContainer = Session["WithContainer"].ToString();
                string WithLOA = Session["WithLOA"].ToString();
                string WithItemContainer = Session["WithItemContainer"].ToString();

                using (var reportDocument = new ReportDocument())
                {
                    dsEFORS eFORS = new dsEFORS();

                    string reportPath;
                    if (WithContainer == "True")
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

                    reportDocument.SetDataSource(eFORS);
                    reportDocument.SetParameterValue("@ControlNo", ControlNo);
                    reportDocument.SetParameterValue("@Date", Date);
                    reportDocument.SetParameterValue("@AuthorizedOfficial", AuthorizedOfficial);
                    reportDocument.SetParameterValue("@ContainerNo", ContainerNo);
                    reportDocument.SetParameterValue("@SealNo", SealNo);
                    reportDocument.SetParameterValue("@UOM", UOM);
                    reportDocument.SetDatabaseLogon("sa", "Sql@dmin2015", "172.16.52.193", "db_eFORS");

                    //Load the report by setting the report source
                    CrystalReportViewer1.ReportSource = reportDocument;

                    ExportOptions options = new ExportOptions();

                    options.ExportFormatType = ExportFormatType.PortableDocFormat;

                    options.FormatOptions = new PdfRtfWordFormatOptions();

                    ExportRequestContext req = new ExportRequestContext();

                    req.ExportInfo = options;


                    Stream s = reportDocument.FormatEngine.ExportToStream(req);

                    reportDocument.Close();
                    reportDocument.Dispose();

                    Response.ClearHeaders();

                    Response.ClearContent();

                    Response.ContentType = "application/pdf";


                    s.Seek(0, SeekOrigin.Begin);

                    byte[] buffer = new byte[s.Length];

                    s.Read(buffer, 0, (int)s.Length);

                    Response.BinaryWrite(buffer);

                    Response.End();
                }
            }
        }
    }
}