using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for EmailDetails
/// </summary>
public class EmailDetails
{
    public string CONTROLNO { get; set; }
    public string FROM_EMAIL { get; set; }
    public string TO_EMAIL { get; set; }
    public string EMAILTYPE { get; set; }
    public string COMMENT { get; set; }

    public EmailDetails()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}