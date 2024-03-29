﻿using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.IO;

public partial class RequestFormPrint : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ControlNo = Request.QueryString["controlno"];

        using (var reportDocument = new ReportDocument())
        {
            dsEFORS eFORS = new dsEFORS();

            reportDocument.Load(Server.MapPath("~/crRequestForm.rpt"));
            reportDocument.SetDataSource(eFORS);
            reportDocument.SetParameterValue("@ControlNo", ControlNo);
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
        //    ReportDocument reportDocument = new ReportDocument();
        //dsEFORS eFORS = new dsEFORS();

        //reportDocument.Load(Server.MapPath("~/crRequestForm.rpt"));
        //reportDocument.SetDataSource(eFORS);
        //reportDocument.SetParameterValue("@ControlNo", ControlNo);
        //reportDocument.SetDatabaseLogon("sa", "Sql@dmin2015", "172.16.52.193", "db_eFORS");
        

        ////Load the report by setting the report source
        //CrystalReportViewer1.ReportSource = reportDocument;

        //ExportOptions options = new ExportOptions();

        //options.ExportFormatType = ExportFormatType.PortableDocFormat;

        //options.FormatOptions = new PdfRtfWordFormatOptions();

        //ExportRequestContext req = new ExportRequestContext();

        //req.ExportInfo = options;


        //Stream s = reportDocument.FormatEngine.ExportToStream(req);

        //Response.ClearHeaders();

        //Response.ClearContent();

        //Response.ContentType = "application/pdf";


        //s.Seek(0, SeekOrigin.Begin);

        //byte[] buffer = new byte[s.Length];

        //s.Read(buffer, 0, (int)s.Length);

        //Response.BinaryWrite(buffer);

        //Response.End();

        //reportDocument.Close();
        //reportDocument.Dispose();
    }
}