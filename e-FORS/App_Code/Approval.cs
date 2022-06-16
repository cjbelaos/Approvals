using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Approval
/// </summary>
public class Approval
{
    public string UserID { get; set; }
    public string WorkFlowID { get; set; }
    public string ApproverID { get; set; }
    public string ControlNo { get; set; }
    public string Requestedby { get; set; }
    public string Checkedby { get; set; }
    public string Approvedby { get; set; }
    public string Comment { get; set; }

    public Approval()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}