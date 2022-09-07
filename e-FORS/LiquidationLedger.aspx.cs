using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LiquidationLedger : System.Web.UI.Page
{
    private static readonly Maintenance maint = new Maintenance();
    private DataSet ds = new DataSet();
    private DataTable dt = new DataTable();
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

                GetLiquidationLedger();
                GetLOANOs();
            }
        }

        grdLiquidationLedger.UseAccessibleHeader = true;
        grdLiquidationLedger.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void GetLiquidationLedger()
    {
        ReportDetails rd = new ReportDetails();
        rd.LOANo = ddlLOANo.SelectedValue;
        ds = maint.GetLiquidationLedger(rd);

        grdLiquidationLedger.DataSource = ds.Tables[0];
        grdLiquidationLedger.DataBind();

        grdLiquidationLedger.UseAccessibleHeader = true;
        grdLiquidationLedger.HeaderRow.TableSection = TableRowSection.TableHeader;
    }

    private void GetLOANOs()
    {
        if (ds.Tables[1].Rows.Count > 0)
        {
            ddlLOANo.DataSource = ds.Tables[1];
            ddlLOANo.DataTextField = "LOANO";
            ddlLOANo.DataValueField = "LOANO";
            ddlLOANo.DataBind();
            ddlLOANo.Items.Insert(0, new ListItem("Choose...", ""));
        }
    }

    protected void BtnSearch_OnClick(object sender, EventArgs e)
    {
        GetLiquidationLedger();
    }

    protected void DownloadTemplate()
    {
        ReportDetails rd = new ReportDetails();
        rd.LOANo = ddlLOANo.SelectedValue;
        ds = maint.GetLiquidationLedger(rd);

        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            /////////////////////////////////////EDITING EXCEL TEMPLATE/////////////////////////////////////////////////////////////
            string LOANO = ddlLOANo.SelectedValue.ToString().Replace("/", "-");
            string strFileName = LOANO + DateTime.Now.ToString("(yyyyMMddHHmmss)") + ".xlsx";
            string strTemplatePath = Server.MapPath(@"~\UploadedExcel\Template\Liquidation_Ledger_Template.xlsx");

            string strFilePath = Server.MapPath(@"~\UploadedExcel\Temp\" + strFileName);

            int ccc2 = 13; //excel row start    
            int i = 1; //
            int lastRowCount = 1;

            if (File.Exists(strTemplatePath))
            {
                File.Copy(strTemplatePath, strFilePath);
                FileInfo file = new FileInfo(strFilePath);

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
                        var DocumentNo = dt.Rows[row - 1]["PEZADOCUMENTNO"].ToString().ToUpper().Trim();
                        var Date = dt.Rows[row - 1]["DATEOFTRANSFER"].ToString().Trim();
                        var Qty = dt.Rows[row - 1]["TOTALQUANTITY"].ToString().Trim();
                        var Amt = dt.Rows[row - 1]["TOTALAMOUNT"].ToString().Trim();

                        //int cs = currentWorkSheet + 1;
                        //currentSheet = cs.ToString();

                        if ((lastRowCount == 2) || (row == 1))
                        {
                            nextWorkSheet = currentWorkSheet + 1;
                            nextSheet = nextWorkSheet.ToString();

                            ExcelWorksheet worksheet = excel.Workbook.Worksheets["Sheet1"];
                            excel.Workbook.Worksheets.Add(nextSheet, worksheet);

                            ccc2 = 13;

                            lastRowCount = 0;
                            currentSheet = nextSheet;
                            currentWorkSheet++;
                        }

                        //plotting the values
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

                    //convert the excel package to a byte array
                    byte[] bin = excel.GetAsByteArray();

                    //clear the buffer stream
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.Buffer = true;

                    //set the correct contenttype
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                    //set the correct length of the data being send
                    Response.AddHeader("content-length", bin.Length.ToString());

                    //set the filename for the excel package
                    Response.AddHeader("content-disposition", "attachment; filename=\""+ strFileName +"\"");

                    //send the byte array to the browser
                    Response.OutputStream.Write(bin, 0, bin.Length);

                    //cleanup
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                    //excel.Save();

                    //Response.Clear();
                    //Response.AddHeader("content-disposition", "attachment;filename=" + strFileName);
                    //Response.WriteFile(Server.MapPath(strFilePath));
                    //Response.Flush();
                    Response.Close();

                }
            }
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        if (ddlLOANo.SelectedValue != "")
        {
            DownloadTemplate();
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Popup", "SelectLOAAlert();", true);
        }
    }
}