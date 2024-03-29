﻿using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.IO;

public partial class PEZA8112PrintNew : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ControlNos"] != null)
        {
            if (!Page.IsPostBack)
            {
                string ControlNos = Session["ControlNos"].ToString();
                string Division = Session["Division"].ToString();
                string LOANO = Session["LOANo"].ToString();
                string Supplier = Session["Supplier"].ToString();
                string Purpose = Session["Purpose"].ToString();
                string Date = Session["Date"].ToString();
                string Dates = Session["Dates"].ToString();

                using (var reportDocument = new ReportDocument())
                {
                    dsEFORS eFORS = new dsEFORS();

                    string reportPath = Server.MapPath("~/crPEZA8112New.rpt");

                    reportDocument.Load(reportPath);

                    reportDocument.SetDataSource(eFORS);
                    reportDocument.SetParameterValue("@CONTROLNOS", ControlNos);
                    reportDocument.SetParameterValue("@DIVISION", Division);
                    reportDocument.SetParameterValue("@Date", Date);
                    reportDocument.SetParameterValue("@Dates", Dates);
                    reportDocument.SetParameterValue("@LOANO", LOANO);
                    reportDocument.SetParameterValue("@Supplier", Supplier);
                    reportDocument.SetParameterValue("@Purpose", Purpose);
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
        else
        {
            Response.Redirect("Finished8112Tasks.aspx");
        }
    }
}