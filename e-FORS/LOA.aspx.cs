using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Globalization;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Net;

public partial class LOA : System.Web.UI.Page
{
    private static readonly LOAMaintenance loamaint = new LOAMaintenance();
    private static readonly Maintenance maint = new Maintenance();
    private DataTable dtLOANo = new DataTable();
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
                GetLOANos();
            }
        }

        gvLOA.UseAccessibleHeader = true;
        gvLOA.HeaderRow.TableSection = TableRowSection.TableHeader;
    }
    
    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        GetLOA();
    }

    protected void BtnClear_OnClick(object sender, EventArgs e)
    {
        tbSection.Text = "";
        ddlSupplier.SelectedIndex = 0;
        tbDateFrom.Text = "";
        tbDateTo.Text = "";
        ddlLOANo.SelectedIndex = 0;
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

        dtLOANo = ds.Tables[1];
    }

    private void GetLOANos()
    {
        if (dtLOANo.Rows.Count > 0)
        {
            divLOA.Visible = true;

            ddlLOANo.DataSource = dtLOANo;
            ddlLOANo.DataTextField = "LOANO";
            ddlLOANo.DataValueField = "LOANO";
            ddlLOANo.DataBind();
            ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        if (ddlLOANo.SelectedValue != "")
        {
            ReportDetails rd = new ReportDetails();
            rd.Supplier = ddlSupplier.SelectedValue;
            rd.Section = tbSection.Text;
            rd.DateFrom = tbDateFrom.Text;
            rd.DateTo = tbDateTo.Text;
            rd.LOANo = ddlLOANo.SelectedValue.Trim();
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

            string LOANo = ddlLOANo.SelectedValue;
            string FileName = LOANo.Replace("/", "-");
            string FilePath = Server.MapPath( @"~\Reports\LOA");
            string Path = @"~\Reports\LOA\" + FileName + ".xls";

            if (!Directory.Exists(FilePath))
            {
                Directory.CreateDirectory(FilePath);
            }

            createExcelFile(ds1, Server.MapPath(Path), FileName);
            Response.Redirect(Path);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SelectLOAAlert();", true);
        }
    }

    public Boolean createExcelFile(DataSet ds1, String FullFilePathName, String FileName)
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
            else
            {
                CreatedFile.Delete();
            }

            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;
            using (var package = new ExcelPackage(CreatedFile))
            {
                //ExcelWorksheet ws;
                foreach (DataTable Table in ds1.Tables)
                {
                    string sheetName = Table.Rows[0]["TYPEOFITEM"].ToString();
                    //ws = package.Workbook.Worksheets.Add(Table.Rows[0]["TYPEOFITEM"].ToString());
                    //Add a worksheet
                    var sheet = package.Workbook.Worksheets.Add(sheetName);

                    //Load the datatable into the worksheet...
                    sheet.Cells["A1"].LoadFromDataTable(Table, PrintHeaders: true/*, TableStyles.Light1*/);

                    sheet.Cells[1, 1, 1, sheet.Dimension.End.Column].Style.Font.Bold = true;
                    //if (System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.IsRightToLeft)// Right to Left for Arabic lang
                    //{
                    //    ExcelWorksheetView wv = ws.View;
                    //    wv.RightToLeft = true;
                    //    ws.PrinterSettings.Orientation = eOrientation.Landscape;
                    //}
                    //else
                    //{
                    //    ExcelWorksheetView wv = ws.View;
                    //    wv.RightToLeft = false;
                    //    ws.PrinterSettings.Orientation = eOrientation.Landscape;
                    //}
                    //ws.Cells.AutoFitColumns();
                    //ws.Cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                    //ws.Cells[1, 1].LoadFromDataTable(Table, ISNew, OfficeOpenXml.Table.TableStyles.Light8);
                    //ws.Column(1).Style.Numberformat.Format = DateTimeFormatInfo.CurrentInfo.ShortDatePattern;
                    //else
                    //{
                    //    ws = package.Workbook.Worksheets.FirstOrDefault();
                    //    ws.Cells[2, 1].LoadFromDataTable(Table, ISNew);
                    //}
                    for (int j = 1; j <= Table.Columns.Count; j++)
                    {
                        sheet.Column(j).AutoFit();
                    }
                }

                //Response.Clear();
                //Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                //Response.AddHeader("content-disposition", "attachment;  filename=" + FileName);
                //Response.BinaryWrite(package.GetAsByteArray());
                //Response.End();

                package.Save();
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