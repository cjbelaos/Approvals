using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SupplierDetails
/// </summary>
public class SupplierDetails
{
    public string SupplierID { get; set; }
    public string Address { get; set; }
    public string LOANo { get; set; }
    public string @LOAExpirationDate { get; set; }
    public string AmountLimit { get; set; }
    public string QuantityLimit { get; set; }
    public string SuretyBondNo { get; set; }
    public string @SuretyExpirationDate { get; set; }
    public string UserName { get; set; }

    public SupplierDetails()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}