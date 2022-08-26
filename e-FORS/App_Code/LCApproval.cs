using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LCApproval
/// </summary>
public class LCApproval
{
    public string UserID { get; set; }
    public string WorkFlowID { get; set; }
    public string ApproverID { get; set; }
    public string ControlNo { get; set; }
    public string Preparedby { get; set; }
    public string Approvedby { get; set; }
    public string Comment { get; set; }
    public LCApproval()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}