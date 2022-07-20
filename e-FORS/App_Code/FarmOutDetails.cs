using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FarmOutDetails
/// </summary>
public class FarmOutDetails
{
    public string ControlNo { get; set; }
    public string Division { get; set; }
    public string NatureOfItem { get; set; }
    public string TransferTo { get; set; }
    public string TypeOfItem { get; set; }
    public string ClassificationOfItem { get; set; }
    public string PurposeOfItem { get; set; }
    public string BearerEmployeeNo { get; set; }
    public string BearerEmployeeName { get; set; }
    public string RequestorEmployeeNo { get; set; }
    public string RequestorEmployeeName { get; set; }
    public string Section { get; set; }
    public string LocalNo { get; set; }
    public string DateRequested { get; set; }
    public string ActualDateOfTransfer { get; set; }
    public string TargetDateOfReturn { get; set; }
    public string PackagingUsed { get; set; }
    public string SupplierID { get; set; }
    public string SupplierName { get; set; }
    public string DestinationAddress { get; set; }
    public string OriginOfItem { get; set; }
    public string DeliveryReceiptNo { get; set; }
    public string InvoiceNo { get; set; }
    public string ContactPerson { get; set; }
    public string ContactNo { get; set; }
    public string TelephoneNo { get; set; }
    public string FaxNo { get; set; }
    public string ModeOfTransfer { get; set; }
    public string TypeOfTransfer { get; set; }
    public FarmOutDetails()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}