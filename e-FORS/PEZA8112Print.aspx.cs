using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Data;
using System.IO;

public partial class PEZA8112Print : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNos"] != null)
        {
            if (!Page.IsPostBack)
            {
                //string ControlNo = Session["ControlNo"].ToString();
                string ControlNos = Session["ControlNos"].ToString();
                string Date = Session["Date"].ToString();
                string Dates = Session["Dates"].ToString();
                string LOANO = Session["LOANo"].ToString();
                //string AuthorizedOfficial = Session["AuthorizedOffical"].ToString();

                using (var reportDocument = new ReportDocument())
                {
                    dsEFORS eFORS = new dsEFORS();

                    string reportPath = Server.MapPath("~/crPEZA8112 - Copy.rpt");

                    reportDocument.Load(reportPath);

                    reportDocument.SetDataSource(eFORS);
                    //reportDocument.SetParameterValue("@ControlNo", ControlNo);
                    reportDocument.SetParameterValue("@CONTROLNOS", ControlNos);
                    reportDocument.SetParameterValue("@Date", Date);
                    reportDocument.SetParameterValue("@Dates", Dates);
                    reportDocument.SetParameterValue("@LOANO", LOANO);
                    //reportDocument.SetParameterValue("@AuthorizedOfficial", AuthorizedOfficial);
                    reportDocument.SetDatabaseLogon("sa", "sqladmin", "172.16.53.149", "db_EFORS");

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
        else
        {
            Response.Redirect("Testing.aspx");
        }
    }
}