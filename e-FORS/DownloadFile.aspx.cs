using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DownloadFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Session["OUTPUTFILE"] == null) && (Session["OUTPUTFILEFOLDER"] == null))
        {

        }
        else
        {
            string filename = Session["OUTPUTFILE"].ToString();
            string foldername = Session["OUTPUTFILEFOLDER"].ToString();
            string delete = Session["OUTPUTDELETE"].ToString();

            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + filename);
            Response.WriteFile(Server.MapPath(foldername + filename));
            Response.Flush();
            Response.Close();

            Session["OUTPUTFILE"] = null;
            Session["OUTPUTFILEFOLDER"] = null;
            Session["OUTPUTDELETE"] = null;

            if (delete == "YES")
            {
                File.Delete(Server.MapPath(@"" + foldername + filename)); //delete temporary file created
            }

           

        }

        
    }
}