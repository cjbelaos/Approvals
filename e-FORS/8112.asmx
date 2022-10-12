<%@ WebService Language="C#" Class="_8112" %>

using Newtonsoft.Json;
using System.Collections.Generic;
using System.Web.Services;
using System;
using System.Data;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class _8112 : System.Web.Services.WebService
{
    private static readonly Maintenance maint = new Maintenance();
    [WebMethod(EnableSession = true)]
    public void Print(string ControlNos, string Division, string LOANo, string Supplier, string Purpose, string Date )
    {
        Session["ControlNos"] = ControlNos;

        Session["Division"] = Division;

        Session["LOANo"] = LOANo;

        Session["Supplier"] = Supplier;

        Session["Purpose"] = Purpose;

        Session["Dates"] = maint.Get8112Dates(ControlNos);

        var parsedDate = DateTime.Parse(Date);
        Session["Date"] = parsedDate.ToString("MMMM dd, yyyy").ToUpper();
    }
}