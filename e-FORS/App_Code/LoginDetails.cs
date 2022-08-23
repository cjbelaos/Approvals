using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LoginDetails
/// </summary>
public class LoginDetails
{
    public string system { get; set; }
    public string username { get; set; }
    public string password { get; set; }
    public bool ldap { get; set; }

    public LoginDetails()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}