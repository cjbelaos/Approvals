<%@ WebHandler Language="C#" Class="hn_DeleteFile" %>

using System;
using System.IO;
using System.Web;
using System.Linq;

public class hn_DeleteFile : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string controlno = System.Convert.ToString(context.Request.QueryString["controlno"]);
        string filename = System.Convert.ToString(context.Request.QueryString["filename"]);
        context.Response.ContentType = "text/plain";
        try
        {
            string Path = HttpContext.Current.Server.MapPath("~/RelatedDocu/" + controlno);
            int FileCount = Directory.GetFiles(Path, "*", SearchOption.TopDirectoryOnly).Length;

            string FilePath = HttpContext.Current.Server.MapPath("~/RelatedDocu/" + controlno + "/" + filename);

            if (FileCount > 1)
            {
                FileInfo file = new FileInfo(FilePath);
                if (file.Exists)
                {
                    file.Delete();
                    FileDetails fd = new FileDetails();
                    fd.ControlNo = controlno;
                    fd.FileName = filename;
                    Maintenance maint = new Maintenance();
                    maint.DeleteFile(fd);
                }
            }
            else
            {
                FileInfo file = new FileInfo(FilePath);
                if (file.Exists)
                {
                    file.Delete();
                    FileDetails fd = new FileDetails();
                    fd.ControlNo = controlno;
                    fd.FileName = filename;
                    Maintenance maint = new Maintenance();
                    maint.DeleteFile(fd);
                }
                DirectoryInfo directory = new DirectoryInfo(Path);
                if (directory.Exists)
                {
                    directory.Delete();
                }

            }
        }
        catch (Exception ac)
        {
            throw ac;
        }
    }

    //public bool IsDirectoryEmpty(string path)
    //{
    //    return !Directory.EnumerateFileSystemEntries(path).Any();
    //}

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}