<%@ WebHandler Language="C#" Class="hn_FileUpload" %>

using System;
using System.IO;
using System.Web;

public class hn_FileUpload : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string controlno = System.Convert.ToString(context.Request.QueryString["controlno"]);
        string userid = System.Convert.ToString(context.Request.QueryString["userid"]);
        context.Response.ContentType = "text/plain";
        try
        {
            string str_file = "";
            string fileName = "";
            string fileExtension = "";
            string filePath = "";

            foreach (string s in context.Request.Files)
            {
                HttpPostedFile file = context.Request.Files[s];
                fileName = file.FileName;
                filePath = HttpContext.Current.Server.MapPath(Path.Combine("~/RelatedDocu/", controlno));

                if (!Directory.Exists(filePath))
                {
                    Directory.CreateDirectory(filePath);
                }
                if (!string.IsNullOrEmpty(fileName))
                {
                    fileExtension = Path.GetExtension(fileName);
                    str_file = fileName;
                    file.SaveAs(filePath + "/" + str_file);
                }
            }
            FileDetails fd = new FileDetails();
            fd.ControlNo = controlno;
            fd.UserID = userid;
            fd.FileName = fileName;
            fd.FileType = fileExtension;
            fd.FilePath = filePath;
            FarmOutRequestFormMaintenance frfm = new FarmOutRequestFormMaintenance();
            frfm.SaveFiles(fd);
            //  database record update logic here  ()

            context.Response.Write(str_file);
        }
        catch (Exception ac)
        {
            throw ac;
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