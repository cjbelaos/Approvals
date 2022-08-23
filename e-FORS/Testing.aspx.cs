using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.OleDb;
using System.Text;
using System.Net.Mail;
using System.Drawing;
using System.Globalization;
using OfficeOpenXml;
using OfficeOpenXml.Style;

public partial class Testing : System.Web.UI.Page
{
    private static readonly LOAMaintenance loamaint = new LOAMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    public static string UserName;
    public static string UserID;

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

                AddSupplierName();
                GetLOA();
            }
        }

        gvLOA.UseAccessibleHeader = true;
        gvLOA.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        hfFileName.Value = ddlLOANo.SelectedValue;
        GetLOA();
    }

    protected void BtnClear_OnClick(object sender, EventArgs e)
    {
        tbSection.Text = "";
        ddlSupplier.SelectedIndex = 0;
        tbDateFrom.Text = "";
        tbDateTo.Text = "";
    }

    private void AddSupplierName()
    {
        DataTable dt = maint.GetSuppliers();
        ddlSupplier.DataSource = dt;
        ddlSupplier.DataTextField = "SupplierName";
        ddlSupplier.DataValueField = "SupplierID";
        ddlSupplier.DataBind();
        ddlSupplier.Items.Insert(0, new ListItem("Choose...", ""));
    }

    private void GetLOA()
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        rd.LOANo = ddlLOANo.SelectedValue;
        DataSet ds = maint.GetLOAReport(rd);

        gvLOA.DataSource = ds.Tables[0];
        gvLOA.DataBind();

        gvLOA.UseAccessibleHeader = true;
        gvLOA.HeaderRow.TableSection = TableRowSection.TableHeader;

        DataTable dt = ds.Tables[1];
        if (dt.Rows.Count > 0)
        {
            divLOA.Visible = true;

            ddlLOANo.DataSource = dt;
            ddlLOANo.DataTextField = "LOANO";
            ddlLOANo.DataValueField = "LOANO";
            ddlLOANo.DataBind();
            ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));
        }
    }

    protected void DownloadTemplate()
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        rd.LOANo = hfFileName.Value;
        DataSet ds = maint.GetLOAReport(rd);

        DataTable dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            /////////////////////////////////////EDITING EXCEL TEMPLATE/////////////////////////////////////////////////////////////
            string strFileName = hfFileName.Value + DateTime.Now.ToString("(yyyyMMddHHmmss)") + ".xlsx";
            string strOriginalPath = Server.MapPath(@"~\UploadedExcel\Template\LOA_Report_Template.xlsx");

            string strCopyPath = Server.MapPath(@"~\UploadedExcel\Temp\" + strFileName);
            hfFileName.Value = strFileName;

            int ccc2 = 2; //excel row start
            int i = 1; //
            int lastRowCount = 1;

            if (File.Exists(strOriginalPath))
            {
                File.Copy(strOriginalPath, strCopyPath);
                FileInfo fileExcel = new FileInfo(strCopyPath);
                ExcelPackage excel = new ExcelPackage(fileExcel);

                string previousTypeofItem = "";
                string nextTypeofItem = "";

                //iterate through dataset tables
                //for row data
                for (var row = 1; row <= dt.Rows.Count; row++)
                {
                    //setting the values
                    var DateOfTransfer = dt.Rows[row - 1]["DATEOFTRANSFER"].ToString().Trim();
                    var Supplier = dt.Rows[row - 1]["SUPPLIER"].ToString().Trim();
                    var Description = dt.Rows[row - 1]["DESCRIPTION"].ToString().Trim();
                    var Model = dt.Rows[row - 1]["MODEL"].ToString().Trim();
                    var PartCode = dt.Rows[row - 1]["PARTCODE"].ToString().Trim();
                    var Quantity = dt.Rows[row - 1]["QUANTITY"].ToString().Trim();
                    var InvoiceValue = dt.Rows[row - 1]["INVOICEVALUE"].ToString().Trim();
                    var InvoiceNo = dt.Rows[row - 1]["INVOICENO"].ToString().Trim();
                    var Origin = dt.Rows[row - 1]["ORIGIN"].ToString().Trim();
                    var PezaDocumentNo = dt.Rows[row - 1]["PEZADOCUMENTNO"].ToString().Trim();
                    var PezaPermitNo = dt.Rows[row - 1]["PEZAPERMITNO"].ToString().Trim();
                    var GatepassNo = dt.Rows[row - 1]["GATEPASSNO"].ToString().Trim();
                    var ControlNo = dt.Rows[row - 1]["CONTROLNO"].ToString().Trim();
                    var DeliverySlipNo = dt.Rows[row - 1]["DELIVERYSLIPNO"].ToString().Trim();
                    var Subcon8105No = dt.Rows[row - 1]["SUBCON8105NO"].ToString().Trim();
                    var PEZAPermitNo8105 = dt.Rows[row - 1]["PEZAPERMITNO8105"].ToString().Trim();
                    var DateReturned = dt.Rows[row - 1]["DATERETURNED"].ToString().Trim();
                    var Subcon8106No = dt.Rows[row - 1]["SUBCON8106NO"].ToString().Trim();
                    var PEZAPermitNo8106 = dt.Rows[row - 1]["PEZAPERMITNO8106"].ToString().Trim();
                    var DRNo = dt.Rows[row - 1]["DRNO"].ToString().Trim();
                    var EPPI8105No = dt.Rows[row - 1]["EPPI8105NO"].ToString().Trim();
                    var EPPI8105NoPermitNo = dt.Rows[row - 1]["EPPI8105NOPERMITNO"].ToString().Trim();
                    var Qty = dt.Rows[row - 1]["QTY"].ToString().Trim();
                    var BondAmount = dt.Rows[row - 1]["BONDAMOUNT"].ToString().Trim();

                    string TypeOfItem = dt.Rows[row - 1]["TYPEOFITEM"].ToString().Trim();

                    if (row == dt.Rows.Count)
                    {
                        nextTypeofItem = TypeOfItem;
                    }
                    else
                    {
                        nextTypeofItem = dt.Rows[(row + 1) - 1]["TYPEOFITEM"].ToString().Trim();
                    }

                    //create new sheet for every Type of Item
                    if (TypeOfItem != previousTypeofItem)
                    {
                        ExcelWorksheet Sheet1 = excel.Workbook.Worksheets["Sheet1"];
                        excel.Workbook.Worksheets.Add(TypeOfItem, Sheet1);

                        ccc2 = 1;
                        i = 1;
                    }

                    //plotting the values
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 1].Value = DateOfTransfer;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 2].Value = Supplier;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 3].Value = Description;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 4].Value = Model;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 5].Value = PartCode;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 6].Value = Quantity;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 7].Value = InvoiceValue;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 8].Value = InvoiceNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 9].Value = Origin;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 10].Value = PezaDocumentNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 11].Value = PezaPermitNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 12].Value = GatepassNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 13].Value = ControlNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 14].Value = DeliverySlipNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 15].Value = Subcon8105No;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 16].Value = PEZAPermitNo8105;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 17].Value = DateReturned;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 18].Value = Subcon8106No;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 19].Value = PEZAPermitNo8106;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 20].Value = DRNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 21].Value = EPPI8105No;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 22].Value = EPPI8105NoPermitNo;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 22].Value = Qty;
                    excel.Workbook.Worksheets[TypeOfItem].Cells[ccc2 + i, 23].Value = BondAmount;

                    previousTypeofItem = TypeOfItem;

                    i++;
                    lastRowCount++;

                }

                excel.Workbook.Worksheets["Sheet1"].Hidden = OfficeOpenXml.eWorkSheetHidden.VeryHidden;

                excel.Save();
            }
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        //DownloadTemplate();

        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        rd.LOANo = hfFileName.Value;
        DataSet ds = maint.GetLOAReport(rd);

        DataTable dt = ds.Tables[0];
        DataSet ds1 = new DataSet();

        var result = from rows in dt.AsEnumerable()
                     group rows by new { TypeOfItem = rows["TYPEOFITEM"] } into grp
                     select grp;

        foreach (var item in result)
        {
            ds1.Tables.Add(item.CopyToDataTable());
        }

        string LOANo = hfFileName.Value;
        string FileName = LOANo.Replace("/", "-");
        createExcelFile(ds1, Server.MapPath(@"~\Reports\LOA\" + FileName + ".xlsx"));
    }

    public Boolean createExcelFile(DataSet ds1, String FullFilePathName)
    {
        Boolean IsDone = false;
        try
        {
            FileInfo CreatedFile = new FileInfo(FullFilePathName);
            Boolean ISNew = false;
            if (!CreatedFile.Exists)
            {
                ISNew = true;
            }
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var pck = new ExcelPackage(CreatedFile))
            {
                ExcelWorksheet ws;
                foreach (DataTable Table in ds1.Tables)
                {
                    if (ISNew == true)
                    {
                        ws = pck.Workbook.Worksheets.Add(Table.Rows[0]["TYPEOFITEM"].ToString());

                        if (System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.IsRightToLeft)// Right to Left for Arabic lang
                        {
                            ExcelWorksheetView wv = ws.View;
                            wv.RightToLeft = true;
                            ws.PrinterSettings.Orientation = eOrientation.Landscape;
                        }
                        else
                        {
                            ExcelWorksheetView wv = ws.View;
                            wv.RightToLeft = false;
                            ws.PrinterSettings.Orientation = eOrientation.Landscape;
                        }
                        ws.Cells.AutoFitColumns();
                        ws.Cells[1, 1].LoadFromDataTable(Table, ISNew, OfficeOpenXml.Table.TableStyles.Light8);
                    }
                    else
                    {
                        ws = pck.Workbook.Worksheets.FirstOrDefault();
                        ws.Cells[2, 1].LoadFromDataTable(Table, ISNew);
                    }
                }
                pck.Save();
                IsDone = true;
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
        return IsDone;
    }
}