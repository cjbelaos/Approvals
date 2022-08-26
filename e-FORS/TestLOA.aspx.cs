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

public partial class TestLOA : System.Web.UI.Page
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

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        ReportDetails rd = new ReportDetails();
        rd.Supplier = ddlSupplier.SelectedValue;
        rd.Section = tbSection.Text;
        rd.DateFrom = tbDateFrom.Text;
        rd.DateTo = tbDateTo.Text;
        rd.LOANo = hfFileName.Value;
        DataSet ds = maint.GetLOAReport(rd);

        DataTable dt = ds.Tables[0];
        DataSet ds1 = new DataSet();
        DataSet ds2 = new DataSet();

        var LOA = from rows in dt.AsEnumerable()
                  group rows by new { TypeOfItem = rows["LOANO"] } into grp
                  select grp;

        foreach (var item in LOA)
        {
            ds1.Tables.Add(item.CopyToDataTable());
        }

        foreach (DataTable Table in ds1.Tables)
        {
            var result = from rows in Table.AsEnumerable()
                         group rows by new { TypeOfItem = rows["TYPEOFITEM"] } into grp
                         select grp;

            foreach (var item in result)
            {
                ds2.Tables.Add(item.CopyToDataTable());
            }

            //string LOANo = Typeof;
            //string FileName = LOANo.Replace("/", "-");
            //string Path = @"~\Reports\LOA\" + FileName + ".xlsx";
            //createExcelFile(ds2, Server.MapPath(Path));
            //Response.Redirect(Path);
        }
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
                        ws.Cells.Style.HorizontalAlignment = ExcelHorizontalAlignment.Left;
                        ws.Cells[1, 1].LoadFromDataTable(Table, ISNew, OfficeOpenXml.Table.TableStyles.Light8);
                        ws.Column(1).Style.Numberformat.Format = DateTimeFormatInfo.CurrentInfo.ShortDatePattern;
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