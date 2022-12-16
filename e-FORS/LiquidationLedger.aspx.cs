using Newtonsoft.Json;
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LiquidationLedger : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    public static string UserID;
    public static string UserName;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Session["Link"] = HttpContext.Current.Request.Url.AbsoluteUri;
            //not logged in
            //Redirect to Login

            Response.Redirect("Login.aspx?expired=1");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                UserID = Session["UserID"].ToString();
                UserName = Session["UserName"].ToString();
                Session["Link"] = "";

                GetLOANos();
            }
        }
    }

    [WebMethod]
    public static string GetLiquidationLedger(ReportDetails rd)
    {
        return JsonConvert.SerializeObject(maint.GetLiquidationLedger(rd));
    }

    [WebMethod]
    public static string GetLiquidInfo(LiquidationLedgerDetails ll)
    {
        return JsonConvert.SerializeObject(maint.GetLiquidationLedgerInfo(ll));
    }

    public void GetLOANos()
    {
        ReportDetails rd = new ReportDetails();
        rd.LOANo = ddlLOANo.SelectedValue;
        DataSet ds = maint.GetLiquidationLedger(rd);

        if (ds.Tables[1].Rows.Count > 0)
        {
            ddlLOANo.DataSource = ds.Tables[1];
            ddlLOANo.DataTextField = "LOANO";
            ddlLOANo.DataValueField = "LOANO";
            ddlLOANo.DataBind();
            ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));
        }
    }

    public void CreateExcelFile(DataTable dt, String TemplatePath, String CopyPath)
    {
        try
        {
            string LOANO = ddlLOANo.SelectedValue;

            LOADetails ld = new LOADetails();
            ld.LOANO = LOANO;
            DataTable dt1 = new DataTable();
            dt1 = maint.GetLOADetails(ld);
            string LOAEXP = Convert.ToDateTime(dt1.Rows[0]["LOAEXP"]).ToString("MMMM dd, yyyy").ToUpper();
            string QTYLEFT = dt1.Rows[0]["QTYLEFT"].ToString();
            string AMTLEFT = dt1.Rows[0]["AMTLEFT"].ToString();

            int ccc2 = 13; //excel row start    
            int i = 1; //
            int lastRowCount = 1;

            if (File.Exists(TemplatePath))
            {
                File.Copy(TemplatePath, CopyPath);
                FileInfo file = new FileInfo(CopyPath);

                using (ExcelPackage excel = new ExcelPackage(file))
                {
                    //iterate through dataset tables
                    //for row data

                    int previousWorkSheet = 0;
                    int currentWorkSheet = 0;
                    int nextWorkSheet = 0;

                    string previousSheet = "";
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
                        var AmtLeft = Convert.ToDouble(AMTLEFT.Trim());
                        //int cs = currentWorkSheet + 1;
                        //currentSheet = cs.ToString();

                        if ((lastRowCount == 19) || (row == 1))
                        {
                            nextWorkSheet = currentWorkSheet + 1;
                            nextSheet = nextWorkSheet.ToString();

                            ExcelWorksheet worksheet = excel.Workbook.Worksheets["Sheet1"];
                            excel.Workbook.Worksheets.Add(nextSheet, worksheet);

                            ccc2 = 13;

                            lastRowCount = 0;
                            currentSheet = nextSheet;
                            currentWorkSheet++;

                            excel.Workbook.Worksheets[currentSheet].Cells["D35"].Value = QtyLeft;
                            excel.Workbook.Worksheets[currentSheet].Cells["F35"].Value = AmtLeft;
                        }

                        if (currentWorkSheet >= 2)
                        {
                            currentSheet = currentWorkSheet.ToString();
                            previousWorkSheet = currentWorkSheet - 1;
                            previousSheet = previousWorkSheet.ToString();

                            excel.Workbook.Worksheets[currentSheet].Cells["D35"].Formula = "'"+previousSheet+"'!D37";
                            excel.Workbook.Worksheets[currentSheet].Cells["F35"].Formula = "'"+previousSheet+"'!F37";
                        }

                        //plotting the values
                        excel.Workbook.Worksheets[currentSheet].Cells["B8"].Value = "LOA NO.     "+LOANO;
                        excel.Workbook.Worksheets[currentSheet].Cells["H8"].Value = "LOA EXPIRY:  "+LOAEXP;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 2].Value = Supplier;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 3].Value = TypeOfItem;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 4].Value = DocumentNo;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 5].Value = Date;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 6].Value = Qty;
                        excel.Workbook.Worksheets[currentSheet].Cells[ccc2, 7].Value = Amt;

                        ccc2++;
                        i++;
                        lastRowCount++;


                    }

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

    protected void LnkDownload_Click(object sender, EventArgs e)
    {
        if (ddlLOANo.SelectedValue != "")
        {
            ReportDetails rd = new ReportDetails();
            rd.LOANo = ddlLOANo.SelectedValue;
            DataSet ds = maint.GetLiquidationLedger(rd);
            DataTable dt = ds.Tables[0];

            string LOANo = ddlLOANo.SelectedValue;
            string FileName = LOANo.Replace("/", "-") + DateTime.Now.ToString("(yyyyMMddHHmmss)");
            string FilePath = Server.MapPath(@"~\UploadedExcel\Temp\");
            string Path = @"~\UploadedExcel\Temp\" + FileName + ".xlsx";
            string TemplatePath = Server.MapPath(@"~\UploadedExcel\Template\Liquidation_Ledger_Template.xlsx");
            string CopyPath = Server.MapPath(@"~\UploadedExcel\Temp\" + FileName + ".xlsx");

            if (!Directory.Exists(FilePath))
            {
                Directory.CreateDirectory(FilePath);
            }

            CreateExcelFile(dt, TemplatePath, CopyPath);
            Response.Redirect(Path);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SelectLOAAlert();", true);
        }
    }
}