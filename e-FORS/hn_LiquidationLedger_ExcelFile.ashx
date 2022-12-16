<%@ WebHandler Language="C#" Class="hn_LiquidationLedger_ExcelFile" %>

using System;
using System.Data;
using System.IO;
using System.Web;
using OfficeOpenXml;

public class hn_LiquidationLedger_ExcelFile : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string loano = System.Convert.ToString(context.Request.QueryString["loano"]);
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        try
        {
            ReportDetails rd = new ReportDetails();
            rd.LOANo = loano;
            Maintenance maint = new Maintenance();
            DataSet ds = maint.GetLiquidationLedger(rd);
            DataTable dt = ds.Tables[0];

            string LOANo = loano;
            string FileName = LOANo.Replace("/", "-") + DateTime.Now.ToString("(yyyyMMddHHmmss)");
            string FilePath = HttpContext.Current.Server.MapPath(@"~\UploadedExcel\Temp\");
            string Path = @"~\UploadedExcel\Temp\" + FileName + ".xlsx";
            string TemplatePath = HttpContext.Current.Server.MapPath(@"~\UploadedExcel\Template\Liquidation_Ledger_Template.xlsx");
            string CopyPath = HttpContext.Current.Server.MapPath(@"~\UploadedExcel\Temp\" + FileName + ".xlsx");

            if (!Directory.Exists(FilePath))
            {
                Directory.CreateDirectory(FilePath);
            }

            LOADetails ld = new LOADetails();
            ld.LOANO = loano;
            DataTable dt1 = new DataTable();
            dt1 = maint.GetLOADetails(ld);

            string LOAEXP = Convert.ToDateTime(dt1.Rows[0]["LOAEXP"]).ToString("MMMM dd,yyyy").ToUpper();
            string QTYLEFT = dt1.Rows[0]["QTYLEFT"].ToString();
            string AMTLEFT = dt1.Rows[0]["AMTLEFT"].ToString();

            //int ccc2 = 13; //excel row start    
            //int i = 1;
            int lastRowCount = 1;

            if (File.Exists(TemplatePath))
            {
                File.Copy(TemplatePath, CopyPath);
                FileInfo file = new FileInfo(CopyPath);

                using (ExcelPackage excel = new ExcelPackage(file))
                {
                    //iterate through dataset tables
                    //for row data

                    int currentWorkSheet = 0;
                    int nextWorkSheet = 0;
                    string currentSheet = "";
                    string nextSheet = "";

                    //for row data
                    for (var row = 1; row <= dt.Rows.Count; row++)
                    {
                        //setting the values
                        var Supplier = dt.Rows[row - 1]["SUPPLIER"].ToString().ToUpper().Trim();
                        var TypeOfItem = dt.Rows[row - 1]["TYPEOFITEM"].ToString().ToUpper().Trim();

                        string PEZADOCUMENTNO = dt.Rows[row - 1]["PEZADOCUMENTNO"].ToString().ToUpper().Trim();
                        if (PEZADOCUMENTNO == "")
                        {
                            PEZADOCUMENTNO = "0";
                        }
                        var DocumentNo = Convert.ToInt64(PEZADOCUMENTNO);
                        var Date = DateTime.Parse(dt.Rows[row - 1]["DATEOFTRANSFER"].ToString().Trim());
                        var Qty = Convert.ToDouble(dt.Rows[row - 1]["TOTALQUANTITY"].ToString().Trim());
                        var Amt = Convert.ToDecimal(dt.Rows[row - 1]["TOTALAMOUNT"].ToString().Trim());

                        var QtyLeft = Convert.ToDouble(QTYLEFT.Trim());

                        if ((lastRowCount == 19) || (row == 1))
                        {
                            nextWorkSheet = currentWorkSheet + 1;
                            nextSheet = nextWorkSheet.ToString();

                            ExcelWorksheet worksheet = excel.Workbook.Worksheets["Sheet1"];
                            excel.Workbook.Worksheets.Add(nextSheet, worksheet);

                            //ccc2 = 13;

                            lastRowCount = 0;
                            currentSheet = nextSheet;
                            currentWorkSheet++;

                            excel.Workbook.Worksheets[currentSheet].Cells["D35"].Value = QtyLeft;
                        }

                        //fill cell data with a loop, note that row and column indexes start at 1
                        for (int i = 13; i <= 25; i++)
                        {
                            for (int j = 2; j <= 7; j++)
                            {
                                //plotting the values
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = Supplier;
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = TypeOfItem;
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = DocumentNo;
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = Date;
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = Qty;
                                excel.Workbook.Worksheets[currentSheet].Cells[i, j].Value = Amt;
                            }
                        }

                        excel.Workbook.Worksheets[currentSheet].Cells["B8"].Value = "LOA NO.     " + loano;
                        excel.Workbook.Worksheets[currentSheet].Cells["H8"].Value = "LOA EXPIRY:  " + LOAEXP;

                        lastRowCount++;
                    }
                    //ccc2++;
                    //i++;
                    excel.Workbook.Worksheets["Sheet1"].Hidden = OfficeOpenXml.eWorkSheetHidden.VeryHidden;

                    excel.Save();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}