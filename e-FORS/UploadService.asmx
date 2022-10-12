<%@ WebService Language="C#" Class="UploadService" %>

using System;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Net;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class UploadService : System.Web.Services.WebService
{
    public static string ControlNo = "";
    public static string UserID = "";
    public UploadService()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }

    [WebMethod]
    public void SetVariables(string controlno, string userid)
    {
        ControlNo = controlno;
        UserID = userid;
    }

    [WebMethod]
    public void UploadFile()
    {
        FileDetails fd = new FileDetails();
        fd.UserID = UserID;
        fd.ControlNo = ControlNo;

        //Create the Directory.
        string path = HttpContext.Current.Server.MapPath(Path.Combine("~/RelatedDocu/", fd.ControlNo));
        if (!Directory.Exists(path))
        {
            Directory.CreateDirectory(path);
        }

        //Fetch the File.
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        string fileName = HttpContext.Current.Request.Form["fileName"] + Path.GetExtension(postedFile.FileName);

        //Customize
        fd.FileName = Path.GetFileName(postedFile.FileName);
        fd.FileType = Path.GetExtension(postedFile.FileName);
        fd.FilePath = path;

        FarmOutRequestFormMaintenance farm = new FarmOutRequestFormMaintenance();
        farm.SaveFiles(fd);

        //Save the File.
        //postedFile.SaveAs(path + fileName);
        postedFile.SaveAs(fd.FilePath + "/" + fd.FileName);
        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fd.FileName);
        HttpContext.Current.Response.Flush();
    }

}