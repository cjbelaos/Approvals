<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RequestForm.aspx.cs" Inherits="RequestForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
    <style type="text/css">
        .hidden-label {
            color: transparent;
            text-shadow: none;
            background-color: transparent;
            border: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Farm-out Request Form</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Farm-out Request Form</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <!-- SELECT2 EXAMPLE -->
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Request Form</h3>
                    <input type="text" id="txtUserID" class="form-control" disabled hidden>
                </div>
                <!-- /.card-header -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4">
                                        <label for="txtControlNo"><i class="far fa-bell"></i>&nbsp;Control No.</label>
                                    </div>
                                    <div class="col-md-8 text-right">
                                        <button type="button" id="btnCancel" class="badge badge-pill badge-danger" data-toggle="modal" data-target="#modalCancel" hidden><i class="fas fa-ban"></i>&nbsp;Cancel</button>
                                        <button type="button" id="btnPrint" class="badge badge-pill badge-info" hidden><i class="fas fa-print"></i>&nbsp;Print</button>
                                        <button type="button" id="btnView" class="badge badge-pill badge-primary" hidden><i class="fas fa-eye"></i>&nbsp;View</button>
                                    </div>
                                </div>
                                <input type="text" id="txtControlNo" class="form-control" disabled>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="selectDivision">Division</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <select id="selectDivision" class="form-control select2" name="Division" required="required">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="selectNatureofItem">Nature of Item</label>
                                <select id="selectNatureofItem" class="form-control select2" style="width: 100%;">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="selectTypeofItem">Type of Item</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <select id="selectTypeofItem" class="form-control select2" name="TypeofItem" multiple="multiple" data-placeholder="Choose..." required="required">
                                </select>
                                <input type="hidden" id="hiddenTypeofItem" />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="selectPurposeofItem">Purpose of Item</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <select id="selectPurposeofItem" class="form-control select2" name="PurposeofItem" required="required">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="selectTransferto">Transfer to</label>
                                <select id="selectTransferto" class="form-control select2" style="width: 100%;">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="selectClassificationofItem">Classification of Item</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <select id="selectClassificationofItem" class="form-control select2" name="ClassificationofItem" multiple="multiple" data-placeholder="Choose..." required="required">
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div id="divOthers" class="form-group" hidden>
                                <label for="txtOthers">Others</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <input type="text" id="txtOthers" class="form-control" name="Others" required="required">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <h5 class="card-subtitle mb-2 text-danger text-center">For Fixed Assets and Quasi Fixed Assets Only</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Bearer</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtBearerEmployeeNo">Employee No.</label>
                                <input type="text" name="BearerEmployeeNo" id="txtBearerEmployeeNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtBearerName">Name</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <input type="text" name="BearerEmployeeName" id="txtBearerName" class="form-control" required="required">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <h6 class="card-subtitle mb-2 text-muted">Requestor</h6>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="txtRequestorEmployeeNo">Employee No.</label>
                                <input type="text" id="txtRequestorEmployeeNo" class="form-control" disabled>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtRequestorEmployeeName">Employee Name</label>
                                <input type="text" id="txtRequestorEmployeeName" class="form-control" disabled>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="txtRequestorSection">Section</label>
                                <input type="text" id="txtRequestorSection" class="form-control" disabled>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtLocalNo">Local No.</label>
                                <input type="text" name="LocalNo" id="txtLocalNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <!-- Date -->
                            <div class="form-group">
                                <label>Date Requested</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <div class="input-group date" id="DateRequested" data-target-input="nearest">
                                    <input type="text" name="DateRequested" id="txtDateRequested" class="form-control datetimepicker-input" data-target="#DateRequested" />
                                    <div class="input-group-append" data-target="#DateRequested" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.row -->

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Date -->
                            <div class="form-group">
                                <label>Actual Date of Transfer</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <div class="input-group date" id="ActualDateofTransfer" data-target-input="nearest">
                                    <input type="text" name="ActualDateofTransfer" id="txtActualDateofTransfer" class="form-control datetimepicker-input" data-target="#ActualDateofTransfer" />
                                    <div class="input-group-append" data-target="#ActualDateofTransfer" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Date -->
                            <div class="form-group">
                                <label>Target Date of Return</label>
                                <div class="input-group date" id="TargetDateofReturn" data-target-input="nearest">
                                    <input type="text" name="TargetDateofReturn" id="txtTargetDateofReturn" class="form-control datetimepicker-input" data-target="#TargetDateofReturn" />
                                    <div class="input-group-append" data-target="#TargetDateofReturn" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div id="divItems" class="card-body" hidden>
                    <button type="button" id="btnNew" class="btn btn-primary mb-1" data-toggle="modal" data-target="#modal"><i class="fas fa-external-link-alt"></i>&nbsp;New</button>
                    <div class="table-responsive">
                        <table id="tableItems" class="table table-bordered table-striped table-hover table-sm" style="white-space: nowrap">
                            <thead id="thead">
                                <tr>
                                    <th>LOA Description</th>
                                    <th>Item/Part Code/Serial No.</th>
                                    <th>Item Description</th>
                                    <th>Quantity</th>
                                    <th>Unit of Measurement</th>
                                    <th>Amount ($)</th>
                                    <th>Fixed/Quasi Fixed Asset No.	</th>
                                    <th>OD</th>
                                    <th>Container</th>
                                    <th>PEZA Seal</th>
                                    <th>DS/RDR Number</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Packaging Used</label>
                                <select id="selectPackagingUsed" class="form-control select2" style="width: 100%;">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div id="divFiles" class="card-body" hidden>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="fileUpload">File Uploaded</label>
                                <div class="input-group">
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="fileUpload">
                                        <label class="custom-file-label" for="fileUpload">Choose file...</label>
                                    </div>
                                    <div class="input-group-append">
                                        <button type="button" id="btnUpload" class="btn btn-primary"><i class="fas fa-upload"></i>&nbsp;Upload</button>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="card">
                                <div class="card-body p-0">
                                    <table id="tableFiles" class="table table-sm table-borderless">
                                        <tbody id="tbody">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->


                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Supplier Name</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                <select id="selectSupplierName" name="SupplierName" class="form-control select2" required="required">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtDestinationAddress">Destination Address</label>
                                <input type="text" name="DestinationAddress" id="txtDestinationAddress" class="form-control" disabled required="required">
                            </div>
                        </div>
                    </div>
                    <!-- /.form-group -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtOriginofItem">Origin of Item</label>
                                <input type="text" name="OriginofItem" id="txtOriginofItem" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtInvoiceNo">Invoice No.</label>
                                <input type="text" name="InvoiceNo" id="txtInvoiceNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtDeliveryReceiptNo">Delivery Receipt No.</label>
                                <input type="text" name="DeliveryReceiptNo" id="txtDeliveryReceiptNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtContactPerson">Contact Person</label>
                                <input type="text" name="ContactPerson" id="txtContactPerson" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtContactNo">Contact No.</label>
                                <input type="text" name="ContactNo" id="txtContactNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtTelephoneNo">Telephone No.</label>
                                <input type="text" name="TelephoneNo" id="txtTelephoneNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="txtFaxNo">Fax No.</label>
                                <input type="text" name="FaxNo" id="txtFaxNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Mode of Transfer</label>
                                <select id="selectModeofTransfer" class="form-control select2" style="width: 100%;">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Type of Transfer</label>
                                <select id="selectTypeofTransfer" class="form-control select2" style="width: 100%;">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="selectRequestedby">Requested by</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <button type="button" id="btnConfirm1" class="badge badge-pill badge-success" hidden><i class="fas fa-exclamation-circle"></i>&nbsp;Confirm</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select id="selectRequestedby" name="Requestby" class="form-control select2" required="required">
                                        <option selected value="0">Choose...</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblStatus1">Status</label>
                                        <label id="lblStatus1" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblComment1">Comment</label>
                                        <label id="lblComment1" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblDate1">Date</label>
                                        <label id="lblDate1" class="form-control border-0"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="selectCheckedby">Checked by</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <button type="button" id="btnEditCheckedby" class="badge badge-pill badge-warning" hidden><i class="fas fa-people-arrows"></i>&nbsp;Edit</button>
                                        <button type="button" id="btnSaveCheckedby" class="badge badge-pill badge-primary" hidden><i class="fas fa-user-shield"></i>&nbsp;Save</button>
                                        <button type="button" id="btnCancelEditCheckedby" class="badge badge-pill badge-danger" hidden><i class="fas fa-user-times"></i>&nbsp;Cancel Edit</button>
                                        <button type="button" id="btnConfirm2" data-toggle="modal" data-target="#modalConfirm" class="badge badge-pill badge-success" hidden><i class="fas fa-exclamation-circle"></i>&nbsp;Confirm</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <select id="selectCheckedby" name="Checkedby" class="form-control select2" required="required">
                                        <option selected value="">Choose...</option>
                                    </select>
                                </div>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblStatus2" class="hidden-label">Status</label>
                                        <label id="lblStatus2" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblComment2" class="hidden-label">Comment</label>
                                        <label id="lblComment2" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblDate2" class="hidden-label">Date</label>
                                        <label id="lblDate2" class="form-control border-0"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="selectApprovedby">Approved by</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    </div>
                                    <div class="col-md-6 text-right">
                                        <button type="button" id="btnEditApprovedby" class="badge badge-pill badge-warning" hidden><i class="fas fa-people-arrows"></i>&nbsp;Edit</button>
                                        <button type="button" id="btnSaveApprovedby" class="badge badge-pill badge-primary" hidden><i class="fas fa-user-shield"></i>&nbsp;Save</button>
                                        <button type="button" id="btnCancelEditApprovedby" class="badge badge-pill badge-danger" hidden><i class="fas fa-user-times"></i>&nbsp;Cancel Edit</button>
                                        <button type="button" id="btnConfirm3" data-toggle="modal" data-target="#modalConfirm" class="badge badge-pill badge-success" hidden><i class="fas fa-exclamation-circle"></i>&nbsp;Confirm</button>
                                    </div>
                                </div>
                                <div class="input-group">
                                    <select id="selectApprovedby" name="Approvedby" class="form-control select2" required="required">
                                        <option selected value="">Choose...</option>
                                    </select>
                                </div>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblStatus3" class="hidden-label">Status</label>
                                        <label id="lblStatus3" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblComment3" class="hidden-label">Comment</label>
                                        <label id="lblComment3" class="form-control border-0"></label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group text-center">
                                        <label for="lblDate3" class="hidden-label">Date</label>
                                        <label id="lblDate3" class="form-control border-0"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->


                <div class="card-footer">
                    <button type="submit" id="btnSave" class="btn btn-primary"><i class="fas fa-share-square"></i>&nbsp;Save</button>
                </div>
            </div>
            <!-- /.card -->
        </div>

        <!-- Modal -->
        <div class="modal fade" id="modal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Item Information</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="selectLOADescription">LOA Description</label>
                                    <span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <select id="selectLOADescription" name="loadesc" class="form-control select2">
                                        <option selected value=""></option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <input type="text" id="txtID" class="form-control" disabled hidden>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtItemNo">Item/Part Code/Serial No.</label>
                                    <input type="text" id="txtItemNo" name="itemcode" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtItemDescription">Item Description</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <input type="text" id="txtItemDescription" name="itemdesc" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtQuantity">Quantity</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <input type="text" id="txtQuantity" name="qty" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtUnitofMeasure">Unit of Measurement</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <input type="text" id="txtUnitofMeasure" name="uom" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtAmount">Amount ($)</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <input type="text" id="txtAmount" name="amt" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtAssetNo">Fixed/Quasi Fixed Asset No.</label>
                                    <input type="text" id="txtAssetNo" name="asset" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtOD">OD</label>
                                    <input type="text" id="txtOD" name="od" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtContainer">Container</label>
                                    <input type="text" id="txtContainer" name="cont" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtPEZASeal">PEZA Seal</label>
                                    <input type="text" id="txtPEZASeal" name="seal" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="txtDSRDRNo">DS/RDR Number</label>
                                    <input type="text" id="txtDSRDRNo" name="drno" class="form-control">
                                </div>
                                <!-- /.form-group -->
                            </div>
                            <!-- /.col -->
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-chevron-circle-left"></i>&nbsp;Back</button>
                        <button type="button" id="btnSaveItem" class="btn btn-primary"><i class="fas fa-location-arrow"></i>&nbsp;Save</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

        <!-- Modal -->
        <div class="modal fade" id="modalConfirm" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-1">
                                    <textarea id="txtApproveComment" name="comment" class="form-control" placeholder="Approve Comment" cols="3"></textarea>
                                </div>
                                <!-- /.form-group -->
                            </div>
                        </div>
                        <!-- /.row -->
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" id="btnApprove" class="btn btn-success btn-sm" style="width: 120px"><i class="fas fa-thumbs-up"></i>&nbsp;Approve</button>
                        <button type="button" id="btnChange" class="btn btn-primary btn-sm" style="width: 120px"><i class="fas fa-user-edit"></i>&nbsp;Change</button>
                        <button type="button" id="btnReassign" class="btn btn-primary btn-sm" style="width: 120px"><i class="fas fa-people-arrows"></i>&nbsp;Reassign</button>
                        <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 120px"><i class="fas fa-chevron-circle-left"></i>&nbsp;Back</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

        <!-- Modal -->
        <div class="modal fade" id="modalRequestChange" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-1">
                                    <textarea id="txtRequestChangeComment" name="requestchangecomment" class="form-control" placeholder="Request Change Comment" cols="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" id="btnSaveRequestChange" class="btn btn-primary btn-sm" style="width: 120px"><i class="fas fa-check-circle"></i>&nbsp;Confirm</button>
                        <button type="button" id="btnCancelChange" class="btn btn-danger btn-sm" style="width: 120px"><i class="fas fa-chevron-circle-left"></i>&nbsp;Back</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.Modal -->

        <!-- Modal -->
        <div class="modal fade" id="modalReassignTask" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group mb-1">
                                    <label for="selectReassign">Checked by</label><span style="color: #ff0000; font-weight: bold">&nbsp;*</span>
                                    <select id="selectReassign" class="form-control select2" name="reassign">
                                        <option selected value="">Choose...</option>
                                    </select>
                                </div>
                                <textarea id="txtReassignComment" name="reassigncomment" class="form-control" placeholder="Re-assign Comment" cols="3"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" id="btnSaveReassign" class="btn btn-primary btn-sm" style="width: 120px"><i class="fas fa-check-circle"></i>&nbsp;Confirm</button>
                        <button type="button" id="btnCancelReassign" class="btn btn-danger btn-sm" style="width: 120px"><i class="fas fa-chevron-circle-left"></i>&nbsp;Back</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.Modal -->

        <!-- Modal -->
        <div class="modal fade" id="modalCancel" data-backdrop="static">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-body justify-content-between">
                        <textarea id="txtReason" name="reason" class="form-control" placeholder="Reason for cancellation" cols="3"></textarea>
                    </div>
                    <div class="modal-footer justify-content-between">
                        <button type="button" id="btnCancelRequest" class="btn btn-primary btn-sm" style="width: 120px"><i class="fas fa-check-circle"></i>&nbsp;Confirm</button>
                        <button type="button" id="btnCancelCancelRequest" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 120px"><i class="fas fa-chevron-circle-left"></i>&nbsp;Back</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.Modal -->

    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        //Variables
        var current_url;

        var userid;
        var user_section;

        var controlno;
        var section;

        var requestedby;
        var checkedby;
        var approvedby;

        var reassignto;

        var current_workflowid;
        var current_approverid;
        var current_assigneduserid;

        //var isApproved;
        var isAuthorized;
        var isApprovedbyRequestor;
        var isFinishedRequestor;

        var tableItems;

        //Initialize Select2 Elements
        $('.select2').select2()

        //Date picker
        $('#DateRequested').datetimepicker({
            format: 'L',
            defaultDate: new Date()
        });
        $('#ActualDateofTransfer').datetimepicker({
            format: 'L'
        });
        $('#TargetDateofReturn').datetimepicker({
            format: 'L'
        });

        //FileInput
        bsCustomFileInput.init();

        function GetSession(callback) {
            $.ajax({
                type: "POST",
                url: "SharedService.asmx/GetSession",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    Session = d;
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetUserInformation(userid, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetUserInformation",
                data: JSON.stringify({ UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetBearerEmployeeName(empno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetBearerEmployeeName",
                data: JSON.stringify({ EmployeeNo: empno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetDivision(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetDivision",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetNatureOfItem(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetNatureOfItem",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetTransferTo(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetTransferTo",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetTypeOfItem(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetTypeOfItem",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetClassificationOfItem(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetClassificationOfItem",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetPurposeOfItem(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetPurposeOfItem",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetPackagingUsed(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetPackagingUsed",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetSupplierName(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetSupplierName",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetSupplierAddress(supplier, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetSupplierAddress",
                data: JSON.stringify({ Supplier: supplier }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetModeOfTransfer(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetModeOfTransfer",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetTypeOfTransfer(callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetTypeOfTransfer",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetRequestedby(section, callback) {
            var UserInfo = {};
            UserInfo.Section = section;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetRequestedby",
                data: JSON.stringify({ ui: UserInfo }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetCheckedby(section, callback) {
            var UserInfo = {};
            UserInfo.Section = section;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetCheckedby",
                data: JSON.stringify({ ui: UserInfo }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetApprovedby(section, callback) {
            var UserInfo = {};
            UserInfo.Section = section;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetApprovedby",
                data: JSON.stringify({ ui: UserInfo }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetFarmOut(controlno, callback) {
            var FarmOutDetails = {};
            FarmOutDetails.ControlNo = controlno;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetFarmOut",
                data: JSON.stringify({ fo: FarmOutDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetItems(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetItems",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    if (d.length > 0) {
                        $("#tableItems").empty();
                        if (tableItems !== undefined) {
                            tableItems.clear().destroy();
                        }
                        var btnUpdate = '<button type="button" data-toggle="modal" data-target="#modal" class="btn btn-sm btn-primary btn-update-row" title="Update"><i class="fas fa-edit"></i>&nbsp;Edit</button>';
                        var btnDelete = '<button type="button" class="btn btn-sm btn-danger btn-delete-row" title="Delete"><i class="fas fa-eraser"></i>&nbsp;Delete</button>';
                        var tableItems = $('#tableItems').DataTable({
                            paging: false,
                            filtering: false,
                            info: false,
                            searching: false,
                            data: d,
                            columns: [
                                {
                                    data: 'ID', title: '', render: function (e) {
                                        return btnDelete;
                                    }
                                },
                                {
                                    data: 'ID', title: '', render: function (e) {
                                        return btnUpdate;
                                    }
                                },
                                { data: 'ID', title: 'ID', visible: false, searchable: false },
                                { data: 'TypeOfItem', title: 'LOA Description' },
                                { data: 'ItemCode', title: 'Item/Part Code/Serial No.' },
                                { data: 'ItemDescription', title: 'Item Description' },
                                { data: 'Quantity', title: 'Quantity' },
                                { data: 'UnitOfMeasurement', title: 'Unit of Measurement' },
                                { data: 'Amount', title: 'Amount ($)' },
                                { data: 'AssetNo', title: 'Fixed/Quasi Fixed Asset No.' },
                                { data: 'ODNo', title: 'OD' },
                                { data: 'ContainerNo', title: 'Container' },
                                { data: 'PEZASeal', title: 'PEZA Seal' },
                                { data: 'DSRDRNo', title: 'DS/RDR Number' },
                            ],
                            columnDefs: [
                                { className: "dt-nowrap", targets: "_all" }
                            ]
                        });

                    }
                    else {
                        tableItems = $('#tableItems').DataTable({
                            paging: false,
                            filtering: false,
                            info: false,
                            searching: false,
                            columnDefs: [
                                { className: "dt-head-nowrap", targets: "_all" }
                            ]
                        });
                    }
                },
                error: function (err) {
                    console.log(err);
                },

            });
        }

        function SaveFarmOut(
            controlno,
            division,
            natureofitem,
            transferto,
            typeofitem,
            classificationofitem,
            purposeofitem,
            beareremployeeno,
            beareremployeename,
            requestoremployeeno,
            requestoremployeename,
            requestorsection,
            localno,
            daterequested,
            dateoftransfer,
            dateofreturn,
            packagingused,
            supplierid,
            suppliername,
            address,
            origin,
            invoice,
            receipt,
            contactperson,
            contactno,
            telephoneno,
            faxno,
            modeoftransfer,
            typeoftransfer,
            userid, callback) {

            var FarmOutDetails = {};
            FarmOutDetails.ControlNo = controlno;
            FarmOutDetails.Division = division;
            FarmOutDetails.NatureOfItem = natureofitem;
            FarmOutDetails.TransferTo = transferto;
            FarmOutDetails.TypeOfItem = typeofitem;
            FarmOutDetails.ClassificationOfItem = classificationofitem;
            FarmOutDetails.PurposeOfItem = purposeofitem;
            FarmOutDetails.BearerEmployeeNo = beareremployeeno;
            FarmOutDetails.BearerEmployeeName = beareremployeename;
            FarmOutDetails.RequestorEmployeeNo = requestoremployeeno;
            FarmOutDetails.RequestorEmployeeName = requestoremployeename;
            FarmOutDetails.Section = requestorsection;
            FarmOutDetails.LocalNo = localno;
            FarmOutDetails.DateRequested = daterequested;
            FarmOutDetails.ActualDateOfTransfer = dateoftransfer;
            FarmOutDetails.TargetDateOfReturn = dateofreturn;
            FarmOutDetails.PackagingUsed = packagingused;
            FarmOutDetails.SupplierID = supplierid;
            FarmOutDetails.SupplierName = suppliername;
            FarmOutDetails.DestinationAddress = address;
            FarmOutDetails.OriginOfItem = origin;
            FarmOutDetails.InvoiceNo = invoice;
            FarmOutDetails.DeliveryReceiptNo = receipt;
            FarmOutDetails.ContactPerson = contactperson;
            FarmOutDetails.ContactNo = contactno;
            FarmOutDetails.TelephoneNo = telephoneno;
            FarmOutDetails.FaxNo = faxno;
            FarmOutDetails.ModeOfTransfer = modeoftransfer;
            FarmOutDetails.TypeOfTransfer = typeoftransfer;
            $.ajax({
                url: "RequestForm.aspx/SaveFarmOut",
                type: "POST",
                data: JSON.stringify({ fo: FarmOutDetails, UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Data has been saved successfully!');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CancelFarmOut(controlno, comment, userid) {
            var Approval = {};
            Approval.ControlNo = controlno;
            Approval.Comment = comment;
            Approval.UserID = userid;
            $.ajax({
                url: "RequestForm.aspx/CancelRequest",
                type: "POST",
                data: JSON.stringify({ a: Approval }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    alert('Request has been cancelled successfully!');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function SaveItem(
            controlno,
            typeofitem,
            itemcode,
            itemdesc,
            quantity,
            uom,
            amount,
            assetno,
            odno,
            contno,
            pezaseal,
            dsrdrno,
            userid) {

            var Items = {};
            Items.ControlNo = controlno;
            Items.TypeOfItem = typeofitem;
            Items.ItemCode = itemcode;
            Items.ItemDescription = itemdesc;
            Items.Quantity = quantity;
            Items.UnitOfMeasurement = uom;
            Items.Amount = amount;
            Items.AssetNo = assetno;
            Items.ODNo = odno;
            Items.ContainerNo = contno;
            Items.PEZASeal = pezaseal;
            Items.DSRDRNo = dsrdrno;
            $.ajax({
                url: "RequestForm.aspx/SaveItem",
                type: "POST",
                data: JSON.stringify({ i: Items, UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    GetItems();
                    alert('Item has been saved successfully!');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function DeleteItem(id) {
            var Items = {};
            Items.ID = id;
            $.ajax({
                url: "RequestForm.aspx/DeleteItem",
                type: "POST",
                data: JSON.stringify({ i: Items }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    alert('Item has been deleted successfully!');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function UpdateItem(id, controlno, typeofitem, itemcode, itemdesc, quantity, uom, amount, assetno, odno, contno, pezaseal, dsrdrno, userid) {
            var Items = {};
            Items.ID = id;
            Items.ControlNo = controlno;
            Items.TypeOfItem = typeofitem;
            Items.ItemCode = itemcode;
            Items.ItemDescription = itemdesc;
            Items.Quantity = quantity;
            Items.UnitOfMeasurement = uom;
            Items.Amount = amount;
            Items.AssetNo = assetno;
            Items.ODNo = odno;
            Items.ContainerNo = contno;
            Items.PEZASeal = pezaseal;
            Items.DSRDRNo = dsrdrno;
            $.ajax({
                url: "RequestForm.aspx/UpdateItem",
                type: "POST",
                data: JSON.stringify({ i: Items, UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    alert('Item has been updated successfully!');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function UploadFile(formData, controlno, userid) {
            $.ajax({
                type: 'post',
                url: 'hn_FileUpload.ashx?controlno=' + controlno + '&userid=' + userid,
                data: formData,
                cache: false,
                processData: false,
                contentType: false,
                success: function (e) {
                    if (e != 'error') {
                        alert("File uploaded successfully!")
                        GetFiles(controlno, function (d) {
                            $('#tbody').empty();
                            if (d.length === 0) {
                                $('#tbody').append('<tr><td class="row-index text-center"><p>No file(s) uploaded.</p></td></tr>');
                            }
                            else {
                                for (var i in d) {
                                    $('#tbody').append('<tr id="' + d[i]['ID'] + '"><td class="text-center"><button type="button" class="btn btn-info btn-sm btn-view-row"><i class="fas fa-eye"></i>&nbsp;View</button></td><td class="row-index text-center"><p>' + d[i]['FileName'] + '</p></td><td class="text-center"><button type="button" class="btn btn-danger btn-sm btn-remove-row"><i class="fas fa-eraser"></i> Remove</button></td></tr>');
                                };
                            };
                            $('#fileUpload').val('');
                            $('.custom-file-label').text('Choose file...');
                        });
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetFiles(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetFiles",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function DeleteFile(controlno, filename, callback) {
            $.ajax({
                type: 'post',
                url: 'hn_DeleteFile.ashx?controlno=' + controlno + '&filename=' + filename,
                data: '{}',
                cache: false,
                processData: false,
                contentType: false,
                success: function (data, textStatus) {
                    if (textStatus === 'success') {
                        alert("File deleted successfully!")
                        GetFiles(controlno, function (d) {
                            $('#tbody').empty();
                            if (d.length === 0) {
                                $('#tbody').append('<tr><td class="row-index text-center"><p>No file(s) uploaded.</p></td></tr>');
                            }
                            else {
                                for (var i in d) {
                                    $('#tbody').append('<tr id="' + d[i]['ID'] + '"><td class="text-center"><button type="button" class="btn btn-info btn-sm btn-view-row"><i class="fas fa-eye"></i>&nbsp;View</button></td><td class="row-index text-center"><p>' + d[i]['FileName'] + '</p></td><td class="text-center"><button type="button" class="btn btn-danger btn-sm btn-remove-row"><i class="fas fa-eraser"></i> Remove</button></td></tr>');
                                };
                            };
                        });
                    }
                    console.log(data);
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }


        function SaveApproval(controlno, requestedby, checkedby, approvedby, userid, callback) {

            var Approval = {};

            Approval.ControlNo = controlno;
            Approval.Requestedby = requestedby;
            Approval.Checkedby = checkedby;
            Approval.Approvedby = approvedby;
            Approval.UserID = userid;

            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/SaveApproval",
                data: JSON.stringify({ a: Approval }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function UpdateApproval(controlno, approverid, approveruserid, userid, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/UpdateApproval",
                data: JSON.stringify({ ControlNo: controlno, ApproverID: approverid, ApproverUserID: approveruserid, UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Assigned approver successfully updated!')
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetApproval(apoaccount, section) {
            GetRequestedby(section, function (d) {
                for (var i in d) {
                    $('<option/>', {
                        value: d[i]['APOAccount'],
                        text: d[i]['FullName']
                    }).appendTo($("#selectRequestedby"));
                } $('#selectRequestedby').val(apoaccount).trigger('change');
                GetCheckedby(section, function (d) {
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['APOAccount'],
                            text: d[i]['FullName']
                        }).appendTo($("#selectCheckedby"));
                    }
                    GetApprovedby(section, function (d) {
                        for (var i in d) {
                            $('<option/>', {
                                value: d[i]['APOAccount'],
                                text: d[i]['FullName']
                            }).appendTo($("#selectApprovedby"));
                        }
                    });
                });
            });
        }

        function SaveMirrorApproval(controlno, userid, callback) {

            var Approval = {};

            Approval.ControlNo = controlno;
            Approval.UserID = userid;

            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/SaveMirrorApproval",
                data: JSON.stringify({ a: Approval }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function Approve(controlno, workflowid, approverid, comment, userid, callback) {
            var Approval = {};

            Approval.ControlNo = controlno;
            Approval.WorkFlowID = workflowid;
            Approval.ApproverID = approverid;
            Approval.Comment = comment;
            Approval.UserID = userid;

            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/Approve",
                data: JSON.stringify({ a: Approval }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Request successfully approved!')
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function RequestChange(controlno, current_workflowid, current_approverid, comment, current_assigneduserid, callback) {
            var Approval = {};

            Approval.ControlNo = controlno;
            Approval.WorkFlowID = current_workflowid;
            Approval.ApproverID = current_approverid;
            Approval.Comment = comment;
            Approval.UserID = current_assigneduserid;

            console.log(Approval);
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/RequestChange",
                data: JSON.stringify({ a: Approval }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Request successfully send back to requestor for revision!')
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function ReassignTask(controlno, current_workflowid, current_approverid, reassignto, comment, current_assigneduserid, callback) {
            var Approval = {};

            Approval.ControlNo = controlno;
            Approval.WorkFlowID = current_workflowid;
            Approval.ApproverID = current_approverid;
            Approval.Comment = comment;
            Approval.UserID = current_assigneduserid;

            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/ReassignTask",
                data: JSON.stringify({ a: Approval, ReassignTo: reassignto }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Request successfully reassigned!')
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckPurposeOfItemIfWithLOA(controlno, callback) {
            var FarmOutDocumentDetails = {};
            FarmOutDocumentDetails.CONTROLNO = controlno;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckPurposeOfItemIfWithLOA",
                data: JSON.stringify({ fdd: FarmOutDocumentDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetLOADescription(division, supplier, callback) {
            var SupplierDetails = {};
            var LOADetails = {};
            SupplierDetails.ID = supplier;
            LOADetails.DIVISION = division;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/GetLOADescription",
                data: JSON.stringify({ sd: SupplierDetails, ld: LOADetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function FarmOutRequestFormApprovalChecking(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/FarmOutRequestFormApprovalChecking",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckAuthorization(userid, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckAuthorization",
                data: JSON.stringify({ UserID: userid }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckIfBypassAccount(userid, callback) {
            var LoginDetails = {};
            LoginDetails.username = userid;
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckIfBypassAccount",
                data: JSON.stringify({ ld: LoginDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckIfCancelled(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckIfCancelled",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckIfApproveByRequestor(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckIfApproveByRequestor",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function CheckIfFinishedRequestor(controlno, callback) {
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/CheckIfFinishedRequestor",
                data: JSON.stringify({ ControlNo: controlno }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function SendEmail(controlno, emailtype, comment, callback) {
            switch (current_approverid) {
                case 1:
                    var from = requestedby;
                    var to = checkedby;
                    break;
                case 2:
                    switch (emailtype) {
                        case 'Approval':
                            var from = checkedby;
                            var to = approvedby;
                            break;
                        case 'Request Change':
                            var from = checkedby;
                            var to = requestedby;
                            break;
                        case 'Re-assign':
                            var from = checkedby;
                            var to = reassignto;
                    }
                    break;
                case 3:
                    var from = approvedby;
                    var to = 'LCS';
                    switch (emailtype) {
                        case 'Approval':
                            var from = approvedby;
                            var to = 'LCS';
                            break;
                        case 'Request Change':
                            var from = approvedby;
                            var to = requestedby;
                            break;
                        case 'Re-assign':
                            var from = approvedby;
                            var to = reassignto;
                    }
                    break;
            }
            var EmailDetails = {};
            EmailDetails.CONTROLNO = controlno;
            EmailDetails.FROM_EMAIL = from;
            EmailDetails.TO_EMAIL = to;
            EmailDetails.EMAILTYPE = emailtype;
            EmailDetails.COMMENT = comment;
            console.log(EmailDetails);
            $.ajax({
                type: "POST",
                url: "RequestForm.aspx/SendEmail",
                data: JSON.stringify({ ed: EmailDetails }),
                datatype: "json",
                contentType: "application/json;charset=utf-8",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function ClearItems() {
            $('#txtID').val('');
            $('#selectLOADescription').val('');
            $('#txtControlNo').val('');
            $('#txtItemNo').val('');
            $('#txtItemDescription').val('');
            $('#txtQuantity').val('');
            $('#txtUnitofMeasure').val('');
            $('#txtAmount').val('');
            $('#txtAssetNo').val('');
            $('#txtOD').val('');
            $('#txtContainer').val('');
            $('#txtPEZASeal').val('');
            $('#txtDSRDRNo').val('');
        }

        function ClearTableItems() {
            $('#tableItems > thead').remove();
            $('#tableItems > tbody').remove();
        }

        function EnableControl() {
            $('#btnCancel').prop('hidden', false);
            $('#txtControlNo').prop('disabled', false);
            $('#txtRequestorEmployeeNo').prop('disabled', false);
            $('#txtRequestorEmployeeName').prop('disabled', false);
            $('#txtRequestorSection').prop('disabled', false);
        }

        function DisableControl() {
            if ($('#selectNatureofItem').val() === '') {
                $("#selectNatureofItem").empty();
                $('#selectNatureofItem').prop('disabled', true);
            }
            else {
                $('#selectDivision').prop('disabled', true);
            }

            if ($('#selectNatureofItem').val() === '') {
                $("#selectNatureofItem").empty();
                $('#selectNatureofItem').prop('disabled', true);
            }
            else {
                $('#selectNatureofItem').prop('disabled', true);
            }

            if ($('#selectTransferto').val() === '') {
                $("#selectTransferto").empty();
                $('#selectTransferto').prop('disabled', true);
            }
            else {
                $('#selectTransferto').prop('disabled', true);
            }

            if ($('#selectTypeofItem').val() === '') {
                $("#selectTypeofItem").empty();
                $('#selectTypeofItem').prop('disabled', true);
            }
            else {
                $('#selectTypeofItem').prop('disabled', true);
            }

            if ($('#selectClassificationofItem').val() === '') {
                $("#selectClassificationofItem").empty();
                $('#selectClassificationofItem').prop('disabled', true);
            }
            else {
                $('#selectClassificationofItem').prop('disabled', true);
            }

            if ($('#selectPurposeofItem').val() === '') {
                $("#selectPurposeofItem").empty();
                $('#selectPurposeofItem').prop('disabled', true);
            }
            else {
                $('#selectPurposeofItem').prop('disabled', true);
            }

            $('#txtOthers').prop('disabled', true);
            $('#txtBearerEmployeeNo').prop('disabled', true);
            $('#txtBearerName').prop('disabled', true);
            $('#txtRequestorEmployeeNo').prop('disabled', true);
            $('#txtRequestorEmployeeName').prop('disabled', true);
            $('#txtRequestorSection').prop('disabled', true);
            $('#txtLocalNo').prop('disabled', true);
            $('#txtDateRequested').prop('disabled', true);
            $('#txtActualDateofTransfer').prop('disabled', true);
            $('#txtTargetDateofReturn').prop('disabled', true);
            $('#selectPackagingUsed').prop('disabled', true);
            $('#selectSupplierName').prop('disabled', true);
            $('#txtDestinationAddress').prop('disabled', true);
            $('#txtOriginofItem').prop('disabled', true);
            $('#txtInvoiceNo').prop('disabled', true);
            $('#txtDeliveryReceiptNo').prop('disabled', true);
            $('#txtContactPerson').prop('disabled', true);
            $('#txtContactNo').prop('disabled', true);
            $('#txtTelephoneNo').prop('disabled', true);
            $('#txtFaxNo').prop('disabled', true);

            if ($('#selectModeofTransfer').val() === '') {
                $("#selectModeofTransfer").empty();
                $('#selectModeofTransfer').prop('disabled', true);
            }
            else {
                $('#selectModeofTransfer').prop('disabled', true);
            }

            if ($('#selectTypeofTransfer').val() === '') {
                $("#selectTypeofTransfer").empty();
                $('#selectTypeofTransfer').prop('disabled', true);
            }
            else {
                $('#selectTypeofTransfer').prop('disabled', true);
            }

            $('#selectRequestedby').prop('disabled', true);
            $('#selectCheckedby').prop('disabled', true);
            $('#selectApprovedby').prop('disabled', true);
            $('#btnCancel').prop('hidden', true);
            $('#btnPrint').prop('hidden', true);
            $('#btnView').prop('hidden', true);
            $('#btnNew').prop('hidden', true);

            for (i = 1; i <= 2; i++) {
                $('#tableItems tr').find('td:eq(0),th:eq(0)').remove();
            }

            $('#btnUpload').prop('hidden', true);
            $('.custom-file').prop('hidden', true);
            $('.btn-remove-row').attr('hidden', true);
            $('.btn-view-row').attr('hidden', true);
            $('#btnSave').prop('hidden', true);
        }

        $(function () {
            current_url = location.href.replace(location.search, '');
            GetSession(function (d) {
                Session = d;
                userid = Session["UserID"];
                console.log(userid);

                GetDivision(function (d) {
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['Description'],
                            text: d[i]['Description']
                        }).appendTo($("#selectDivision"));
                    }
                    GetNatureOfItem(function (d) {
                        for (var i in d) {
                            $('<option/>', {
                                value: d[i]['Description'],
                                text: d[i]['Description']
                            }).appendTo($("#selectNatureofItem"));
                        }
                        GetTransferTo(function (d) {
                            for (var i in d) {
                                $('<option/>', {
                                    value: d[i]['Description'],
                                    text: d[i]['Description']
                                }).appendTo($("#selectTransferto"));
                            }
                            GetTypeOfItem(function (d) {
                                for (var i in d) {
                                    $('<option/>', {
                                        value: d[i]['Description'],
                                        text: d[i]['Description']
                                    }).appendTo($("#selectTypeofItem"));
                                }
                                GetClassificationOfItem(function (d) {
                                    for (var i in d) {
                                        $('<option/>', {
                                            value: d[i]['Description'],
                                            text: d[i]['Description']
                                        }).appendTo($("#selectClassificationofItem"));
                                    }
                                    GetPurposeOfItem(function (d) {
                                        for (var i in d) {
                                            $('<option/>', {
                                                value: d[i]['Description'],
                                                text: d[i]['Description']
                                            }).appendTo($("#selectPurposeofItem"));
                                        }
                                        GetPackagingUsed(function (d) {
                                            for (var i in d) {
                                                $('<option/>', {
                                                    value: d[i]['Description'],
                                                    text: d[i]['Description']
                                                }).appendTo($("#selectPackagingUsed"));
                                            }
                                            GetSupplierName(function (d) {
                                                for (var i in d) {
                                                    $('<option/>', {
                                                        value: d[i]['SUPPLIERID'],
                                                        text: d[i]['SUPPLIERNAME']
                                                    }).appendTo($("#selectSupplierName"));
                                                }
                                                GetModeOfTransfer(function (d) {
                                                    for (var i in d) {
                                                        $('<option/>', {
                                                            value: d[i]['Description'],
                                                            text: d[i]['Description']
                                                        }).appendTo($("#selectModeofTransfer"));
                                                    }
                                                    GetTypeOfTransfer(function (d) {
                                                        for (var i in d) {
                                                            $('<option/>', {
                                                                value: d[i]['Description'],
                                                                text: d[i]['Description']
                                                            }).appendTo($("#selectTypeofTransfer"));
                                                        }

                                                        var url = location.search;
                                                        var ctrlno = url.split("=");

                                                        if (ctrlno.length > 1) {
                                                            ctrlno = (ctrlno[1].replace('%20', ' '));
                                                        }

                                                        $('#txtControlNo').val(ctrlno);

                                                        controlno = $('#txtControlNo').val();
                                                        if (controlno !== null && controlno !== '') {
                                                            GetUserInformation(userid, function (d) {
                                                                console.log(d);
                                                                user_section = d['Table'][0]['SectionName'];
                                                            });
                                                            $('#divItems').prop('hidden', false);
                                                            $('#divFiles').prop('hidden', false);

                                                            var status_color1;
                                                            var status_color2;
                                                            var status_color3;

                                                            GetFarmOut(controlno, function (d) {
                                                                $('#selectDivision').val(d['Table'][0]['Division']).trigger('change');
                                                                $('#selectNatureofItem').val(d['Table'][0]['NatureOfItem']).trigger('change');
                                                                $('#selectTransferto').val(d['Table'][0]['TransferTo']).trigger('change');

                                                                var typeofitem = d['Table'][0]['TypeOfItem'].replace(' | ', ',').split(',');
                                                                $('#selectTypeofItem').val(typeofitem).trigger('change');

                                                                var classificationofitem = d['Table'][0]['ClassificationOfItem'].replace(' | ', ',').split(',');
                                                                $('#selectClassificationofItem').val(classificationofitem).trigger('change');

                                                                var exists = 0 != $('#selectPurposeofItem option[value="' + d['Table'][0]['PurposeOfItem'] + '"]').length;
                                                                if (exists === true) {
                                                                    $('#selectPurposeofItem').val(d['Table'][0]['PurposeOfItem']).trigger('change');
                                                                }
                                                                else {
                                                                    $('#selectPurposeofItem').val('Others').trigger('change');
                                                                    $('#divOthers').prop('hidden', false);
                                                                    $('#txtOthers').val(d['Table'][0]['PurposeOfItem']);
                                                                    //$('#selectPurposeofItem').val('Return to Supplier').trigger('change');
                                                                }

                                                                $('#txtBearerEmployeeNo').val(d['Table'][0]['BearerEmployeeNo']);
                                                                $('#txtBearerName').val(d['Table'][0]['BearerEmployeeName']);
                                                                $('#txtRequestorEmployeeNo').val(d['Table'][0]['RequestorEmployeeNo']);
                                                                $('#txtRequestorEmployeeName').val(d['Table'][0]['RequestorEmployeeName']);
                                                                $('#txtRequestorSection').val(d['Table'][0]['Section']);
                                                                $('#txtLocalNo').val(d['Table'][0]['LocalNo']);

                                                                if (d['Table'][0]['DateRequested'] !== null && d['Table'][0]['DateRequested'] !== '') {
                                                                    $('#txtDateRequested').val(moment(d['Table'][0]['DateRequested']).format("L"));
                                                                }
                                                                else {
                                                                    $('#txtDateRequested').val('');
                                                                }

                                                                if (d['Table'][0]['ActualDateOfTransfer'] !== null && d['Table'][0]['ActualDateOfTransfer'] !== '') {
                                                                    $('#txtActualDateofTransfer').val(moment(d['Table'][0]['ActualDateOfTransfer']).format("L"));
                                                                }
                                                                else {
                                                                    $('#txtActualDateofTransfer').val('');
                                                                }

                                                                if (d['Table'][0]['TargetDateOfReturn'] !== null && d['Table'][0]['TargetDateOfReturn'] !== '') {
                                                                    $('#txtTargetDateofReturn').val(moment(d['Table'][0]['TargetDateOfReturn']).format("L"));
                                                                }
                                                                else {
                                                                    $('#txtTargetDateofReturn').val('');
                                                                }

                                                                $('#selectPackagingUsed').val(d['Table'][0]['PackagingUsed']).trigger('change');
                                                                $('#selectSupplierName').val(d['Table'][0]['SupplierID']).trigger('change');
                                                                $('#txtDestinationAddress').val(d['Table'][0]['DestinationAddress']);
                                                                $('#txtOriginofItem').val(d['Table'][0]['OriginOfItem']);
                                                                $('#txtInvoiceNo').val(d['Table'][0]['InvoiceNo']);
                                                                $('#txtDeliveryReceiptNo').val(d['Table'][0]['DeliveryReceiptNo']);
                                                                $('#txtContactPerson').val(d['Table'][0]['ContactPerson']);
                                                                $('#txtContactNo').val(d['Table'][0]['ContactNo']);
                                                                $('#txtTelephoneNo').val(d['Table'][0]['TelephoneNo']);
                                                                $('#txtFaxNo').val(d['Table'][0]['FaxNo']);
                                                                $('#selectModeofTransfer').val(d['Table'][0]['ModeOfTransfer']).trigger('change');
                                                                $('#selectTypeofTransfer').val(d['Table'][0]['TypeOfTransfer']).trigger('change');

                                                                section = d['Table'][0]['Section'];
                                                                requestedby = d['Table'][0]['ASSIGNEDUSERID'];
                                                                checkedby = d['Table'][1]['ASSIGNEDUSERID'];
                                                                approvedby = d['Table'][2]['ASSIGNEDUSERID'];
                                                                current_approverid = d['Table'][0]['APPROVERID_CURRENT'];
                                                                current_assigneduserid = d['Table'][0]['ASSIGNEDUSERID_CURRENT'];
                                                                current_workflowid = d['Table'][0]['WORKFLOWID_CURRENT'];
                                                                statusid1 = d['Table'][0]['CURRENTSTATUSID'];
                                                                statusid2 = d['Table'][1]['CURRENTSTATUSID'];
                                                                statusid3 = d['Table'][2]['CURRENTSTATUSID'];

                                                                switch (statusid1) {
                                                                    case 0:
                                                                        status_color1 = 'bg-secondary';
                                                                        break;
                                                                    case 1:
                                                                    case 3:
                                                                    case 5:
                                                                    case 7:
                                                                        status_color1 = 'bg-warning';
                                                                        break;
                                                                    case 2:
                                                                    case 4:
                                                                    case 6:
                                                                    case 8:
                                                                        status_color1 = 'bg-success';
                                                                        break;
                                                                }

                                                                switch (statusid2) {
                                                                    case 0:
                                                                        status_color2 = 'bg-secondary';
                                                                        break;
                                                                    case 1:
                                                                    case 3:
                                                                    case 5:
                                                                    case 7:
                                                                        status_color2 = 'bg-warning';
                                                                        break;
                                                                    case 2:
                                                                    case 4:
                                                                    case 6:
                                                                    case 8:
                                                                        status_color2 = 'bg-success';
                                                                        break;
                                                                }

                                                                switch (statusid3) {
                                                                    case 0:
                                                                        status_color3 = 'bg-secondary';
                                                                        break;
                                                                    case 1:
                                                                    case 3:
                                                                    case 5:
                                                                    case 7:
                                                                        status_color3 = 'bg-warning';
                                                                        break;
                                                                    case 2:
                                                                    case 4:
                                                                    case 6:
                                                                    case 8:
                                                                        status_color3 = 'bg-success';
                                                                        break;
                                                                }

                                                                status1 = d['Table'][0]['CURRENTSTATUS'] || ' ';
                                                                comment1 = d['Table'][0]['COMMENT'] || ' ';
                                                                date1 = d['Table'][0]['ACTIONDATE'] || ' ';
                                                                if (date1 !== ' ') {
                                                                    date1 = moment(d['Table'][0]['ACTIONDATE']).format("L" + " " + "LTS");
                                                                }

                                                                status2 = d['Table'][1]['CURRENTSTATUS'];
                                                                comment2 = d['Table'][1]['COMMENT'] || ' ';
                                                                if (d['Table'][1]['ACTIONDATE'] !== null) {
                                                                    date2 = moment(d['Table'][1]['ACTIONDATE']).format("L" + " " + "LTS")
                                                                }
                                                                else {
                                                                    date2 = ' ';
                                                                }

                                                                status3 = d['Table'][2]['CURRENTSTATUS'] || ' ';
                                                                comment3 = d['Table'][2]['COMMENT'] || ' ';
                                                                if (d['Table'][2]['ACTIONDATE'] !== null) {
                                                                    date3 = moment(d['Table'][2]['ACTIONDATE']).format("L" + " " + "LTS")
                                                                }
                                                                else {
                                                                    date3 = ' ';
                                                                }

                                                                GetRequestedby(section, function (d) {
                                                                    console.log(d);
                                                                    for (var i in d) {
                                                                        $('<option/>', {
                                                                            value: d[i]['APOAccount'],
                                                                            text: d[i]['FullName']
                                                                        }).appendTo($("#selectRequestedby"));
                                                                    }
                                                                    $('#selectRequestedby').val(requestedby).trigger('change');
                                                                    $('#lblStatus1').append('<span class="badge ' + status_color1 + '">' + status1 + '</span>');
                                                                    $('#lblComment1').append('<span class="badge bg-info">' + comment1 + '</span>');
                                                                    $('#lblDate1').append('<span class="badge bg-info">' + date1 + '</span>');
                                                                    GetCheckedby(section, function (d) {
                                                                        for (var i in d) {
                                                                            $('<option/>', {
                                                                                value: d[i]['APOAccount'],
                                                                                text: d[i]['FullName']
                                                                            }).appendTo($("#selectCheckedby"));
                                                                            //$('<option/>', {
                                                                            //    value: d[i]['APOAccount'],
                                                                            //    text: d[i]['FullName']
                                                                            //}).appendTo($("#selectReassign"));
                                                                            //$('#selectReassign option[value="' + current_assigneduserid + '"]').remove();
                                                                        }
                                                                        $('#selectCheckedby').val(checkedby).trigger('change');
                                                                        $('#lblStatus2').append('<span class="badge ' + status_color2 + '">' + status2 + '</span>');
                                                                        $('#lblComment2').append('<span class="badge bg-info">' + comment2 + '</span>');
                                                                        $('#lblDate2').append('<span class="badge bg-info">' + date2 + '</span>');
                                                                        GetApprovedby(section, function (d) {
                                                                            for (var i in d) {
                                                                                $('<option/>', {
                                                                                    value: d[i]['APOAccount'],
                                                                                    text: d[i]['FullName']
                                                                                }).appendTo($("#selectApprovedby"));
                                                                            }
                                                                            $('#selectApprovedby').val(approvedby).trigger('change');
                                                                            $('#lblStatus3').append('<span class="badge ' + status_color3 + '">' + status3 + '</span>');
                                                                            $('#lblComment3').append('<span class="badge bg-info">' + comment3 + '</span>');
                                                                            $('#lblDate3').append('<span class="badge bg-info">' + date3 + '</span>');

                                                                            GetItems(controlno, function (d) {
                                                                                GetFiles(controlno, function (d) {
                                                                                    if (d.length === 0) {
                                                                                        $('#tbody').append('<tr><td class="row-index text-center"><p>No file(s) uploaded.</p></td></tr>');
                                                                                    }
                                                                                    else {
                                                                                        for (var i in d) {
                                                                                            $('#tbody').append('<tr id="' + d[i]['ID'] + '"><td class="text-center"><button type="button" class="btn btn-info btn-sm btn-view-row"><i class="fas fa-eye"></i>&nbsp;View</button></td><td class="row-index text-center"><p>' + d[i]['FileName'] + '</p></td><td class="text-center"><button type="button" class="btn btn-danger btn-sm btn-remove-row"><i class="fas fa-eraser"></i> Remove</button></td></tr>');
                                                                                        };
                                                                                    };
                                                                                    CheckIfBypassAccount(userid, function (d) {
                                                                                        isByPassAccount = d;
                                                                                        if (isByPassAccount === true) {
                                                                                            EnableControl();
                                                                                            switch (current_approverid) {
                                                                                                case 1:
                                                                                                    $('#btnConfirm1').prop('hidden', false);
                                                                                                    break;
                                                                                                case 2:
                                                                                                    $('#btnConfirm2').prop('hidden', false);
                                                                                                    break;
                                                                                                case 3:
                                                                                                    $('#btnConfirm3').prop('hidden', false);
                                                                                                    break;
                                                                                            }
                                                                                        }
                                                                                        else {
                                                                                            switch (current_approverid) {
                                                                                                case 1:
                                                                                                    if (userid !== $('#selectRequestedby').val() && userid !== current_assigneduserid) {
                                                                                                        DisableControl();
                                                                                                    }
                                                                                                    else {
                                                                                                        $('#btnConfirm1').prop('hidden', false);
                                                                                                    }
                                                                                                    break;
                                                                                                case 2:
                                                                                                    GetCheckedby(section, function (d) {
                                                                                                        for (var i in d) {
                                                                                                            $('<option/>', {
                                                                                                                value: d[i]['APOAccount'],
                                                                                                                text: d[i]['FullName']
                                                                                                            }).appendTo($("#selectReassign"));
                                                                                                            $('#selectReassign option[value="' + current_assigneduserid + '"]').remove();
                                                                                                        }
                                                                                                    });
                                                                                                    if (userid !== $('#selectCheckedby').val() && userid !== current_assigneduserid) {
                                                                                                        DisableControl();
                                                                                                    }
                                                                                                    else {
                                                                                                        DisableControl();
                                                                                                        $('#btnConfirm2').prop('hidden', false);
                                                                                                    }
                                                                                                    break;
                                                                                                case 3:
                                                                                                    GetApprovedby(section, function (d) {
                                                                                                        for (var i in d) {
                                                                                                            $('<option/>', {
                                                                                                                value: d[i]['APOAccount'],
                                                                                                                text: d[i]['FullName']
                                                                                                            }).appendTo($("#selectReassign"));
                                                                                                            $('#selectReassign option[value="' + current_assigneduserid + '"]').remove();
                                                                                                        }
                                                                                                    });
                                                                                                    if (userid !== $('#selectApprovedby').val() && userid !== current_assigneduserid) {
                                                                                                        DisableControl();
                                                                                                    }
                                                                                                    else {
                                                                                                        DisableControl();
                                                                                                        $('#btnConfirm3').prop('hidden', false);
                                                                                                    }
                                                                                                    break;
                                                                                                case null:
                                                                                                    DisableControl();
                                                                                                    break;
                                                                                            }
                                                                                        }
                                                                                        CheckIfApproveByRequestor(controlno, function (d) {
                                                                                            isApprovedbyRequestor = d;
                                                                                            CheckAuthorization(userid, function (d) {
                                                                                                isAuthorized = d;
                                                                                                CheckIfCancelled(controlno, function (d) {
                                                                                                    isCancelled = d;
                                                                                                    CheckIfFinishedRequestor(controlno, function (d) {
                                                                                                        isFinishedRequestor = d;
                                                                                                        if (isFinishedRequestor === true && isAuthorized === true) {
                                                                                                            $('#btnPrint').prop('hidden', false);
                                                                                                            $('#btnView').prop('hidden', false);
                                                                                                        }
                                                                                                        if (userid === requestedby && isCancelled === false && isFinishedRequestor === false) {
                                                                                                            console.log(userid, isCancelled, isFinishedRequestor);
                                                                                                            $('#btnCancel').prop('hidden', false);
                                                                                                            if (statusid1 !== 5 && statusid1 !== 7 && statusid2 !== 2) {
                                                                                                                $('#btnEditCheckedby').prop('hidden', false);
                                                                                                            }
                                                                                                            if (statusid1 !== 5 && statusid1 !== 7 && statusid3 !== 2) {
                                                                                                                $('#btnEditApprovedby').prop('hidden', false);
                                                                                                            }
                                                                                                        }
                                                                                                        if (user_section === section) {
                                                                                                            $('.btn-view-row').prop('hidden', false);
                                                                                                        }
                                                                                                    });
                                                                                                });
                                                                                            });
                                                                                        });
                                                                                    });
                                                                                });
                                                                            });
                                                                        });
                                                                    });
                                                                });
                                                            });
                                                        }
                                                        else {
                                                            GetUserInformation(userid, function (d) {
                                                                $('#txtRequestorSection').val(d['Table'][0]['SectionName']);
                                                                $('#txtRequestorEmployeeNo').val(d['Table'][0]['EmployeeNo']);
                                                                $('#txtRequestorEmployeeName').val(d['Table'][0]['FirstName'] + ' ' + d['Table'][0]['LastName']);

                                                                //var apoaccount = d['Table'][0]['APOAccount'];
                                                                var section = $('#txtRequestorSection').val();
                                                                //console.log(apoaccount);

                                                                GetRequestedby(section, function (d) {
                                                                    for (var i in d) {
                                                                        $('<option/>', {
                                                                            value: d[i]['APOAccount'],
                                                                            text: d[i]['FullName']
                                                                        }).appendTo($("#selectRequestedby"));
                                                                    } $('#selectRequestedby').val(userid).trigger('change');
                                                                    GetCheckedby(section, function (d) {
                                                                        for (var i in d) {
                                                                            $('<option/>', {
                                                                                value: d[i]['APOAccount'],
                                                                                text: d[i]['FullName']
                                                                            }).appendTo($("#selectCheckedby"));
                                                                        }
                                                                        GetApprovedby(section, function (d) {
                                                                            for (var i in d) {
                                                                                $('<option/>', {
                                                                                    value: d[i]['APOAccount'],
                                                                                    text: d[i]['FullName']
                                                                                }).appendTo($("#selectApprovedby"));
                                                                            }
                                                                        });
                                                                    });
                                                                });
                                                            });
                                                            $('#btnCancel').prop('hidden', true);
                                                            $('#btnPrint').prop('hidden', true);
                                                            $('#btnView').prop('hidden', true);
                                                            tableItems = $('#tableItems').DataTable({
                                                                paging: false,
                                                                filtering: false,
                                                                info: false,
                                                                searching: false,
                                                                columnDefs: [
                                                                    { className: "dt-head-nowrap", targets: "_all" }
                                                                ]
                                                            });
                                                        };
                                                    });
                                                });
                                            });
                                        });
                                    });
                                });
                            });
                        });
                    });
                });


                $('#selectPurposeofItem').on('change', function () {
                    var selected = $(this).val();
                    if (selected === 'Others') {
                        $('#divOthers').prop('hidden', false);
                    }
                    else {
                        $('#divOthers').prop('hidden', true);
                    }
                });

                $('#txtBearerEmployeeNo').change(function () {
                    var empno = $(this).val();
                    if (empno !== '') {
                        GetBearerEmployeeName(empno, function (d) {
                            var empname = d[0]['FullName'];
                            $('#txtBearerName').val(empname);
                        });
                    }
                });

                $.validator.addMethod("unselected", function (value, element, arg) {
                    return arg !== value;
                });
                $('#form1').validate({
                    onfocusout: false,
                    invalidHandler: function (form, validator) {
                        var errors = validator.numberOfInvalids();
                        if (errors) {
                            validator.errorList[0].element.focus();
                        }
                    },
                    rules: {
                        //for request form
                        Division: {
                            unselected: ""
                        },
                        TypeofItem: {
                            unselected: ""
                        },
                        ClassificationofItem: {
                            unselected: ""
                        },
                        PurposeofItem: {
                            unselected: ""
                        },
                        Others: {
                            required: true
                        },
                        BearerEmployeeName: {
                            required: true
                        },
                        DateRequested: {
                            required: true
                        },
                        ActualDateofTransfer: {
                            required: true
                        },
                        SupplierName: {
                            unselected: ""
                        },
                        Requestedby: {
                            unselected: ""
                        },
                        Checkedby: {
                            unselected: ""
                        },
                        Approvedby: {
                            unselected: ""
                        },

                        //for items form
                        loadesc: {
                            unselected: ""
                        },
                        itemdesc: {
                            required: true
                        },
                        qty: {
                            required: true,
                            number: true
                        },
                        uom: {
                            required: true,
                            lettersonly: true
                        },
                        amt: {
                            required: true,
                            number: true
                        },


                    },
                    messages: {
                        Division: {
                            unselected: "Please select division."
                        },
                        TypeofItem: {
                            unselected: "Please select type of item."
                        },
                        ClassificationofItem: {
                            unselected: "Please select classification of item."
                        },
                        PurposeofItem: {
                            unselected: "Please select purpose of item."
                        },
                        Others: {
                            required: "Please provide other purpose of item."
                        },
                        DateRequested: {
                            required: "Please provide a date."
                        },
                        ActualDateofTransfer: {
                            required: "Please provide a date."
                        },
                        SupplierName: {
                            unselected: "Please select a supplier."
                        },
                        Requestedby: {
                            unselected: "Please select requested by."
                        },
                        Checkedby: {
                            unselected: "Please select checked by."
                        },
                        Approvedby: {
                            unselected: "Please select approved by."
                        },

                        //for items form
                        loadesc: {
                            unselected: "Please select loa description."
                        },
                    },
                    errorElement: 'span',
                    errorPlacement: function (error, element) {
                        error.addClass('invalid-feedback');
                        element.closest('.form-group').append(error);
                    },
                    highlight: function (element, errorClass, validClass) {
                        $(element).addClass('is-invalid');
                    },
                    unhighlight: function (element, errorClass, validClass) {
                        $(element).removeClass('is-invalid');
                    }
                });

                //$('#selectTypeofItem').on('change', function () {
                //    var selected = $.map($("#selectTypeofItem option:selected"), function (e) {
                //        return $(e).text();
                //    });
                //});

                $('#btnSave').on('click', function () {
                    if ($("#form1").valid()) {
                        var controlno = $('#txtControlNo').val();
                        if (controlno === '') {
                            controlno = '[AUTOMATIC]'
                        }
                        var division = $('#selectDivision').val();
                        var natureofitem = $('#selectNatureofItem').val();
                        var transferto = $('#selectTransferto').val();

                        var typeofitem = $.map($("#selectTypeofItem option:selected"), function (e) {
                            return $(e).text();
                        });
                        typeofitem = typeofitem.toString().replace(',', ' | ');

                        var classificationofitem = $.map($("#selectClassificationofItem option:selected"), function (e) {
                            return $(e).text();
                        });
                        classificationofitem = classificationofitem.toString().replace(',', ' | ');

                        if ($('#selectPurposeofItem').val() !== 'Others') {
                            var purposeofitem = $('#selectPurposeofItem').val();
                        }
                        else {
                            var purposeofitem = $('#txtOthers').val();
                        }

                        var beareremployeeno = $('#txtBearerEmployeeNo').val();
                        var beareremployeename = $('#txtBearerName').val();
                        var requestoremployeeno = $('#txtRequestorEmployeeNo').val();
                        var requestoremployeename = $('#txtRequestorEmployeeName').val();
                        var requestorsection = $('#txtRequestorSection').val();
                        var localno = $('#txtLocalNo').val();
                        var daterequested = $('#txtDateRequested').val();
                        var dateoftransfer = $('#txtActualDateofTransfer').val();
                        var dateofreturn = $('#txtTargetDateofReturn').val();
                        var packagingused = $('#selectPackagingUsed').val();
                        var supplierid = $('#selectSupplierName').val()
                        var suppliername = $('#selectSupplierName option:selected').text();
                        var address = $('#txtDestinationAddress').val();
                        var origin = $('#txtOriginofItem').val();
                        var invoice = $('#txtInvoiceNo').val();
                        var receipt = $('#txtDeliveryReceiptNo').val();
                        var contactperson = $('#txtContactPerson').val();
                        var contactno = $('#txtContactNo').val();
                        var telephoneno = $('#txtTelephoneNo').val();
                        var faxno = $('#txtFaxNo').val();
                        var modeoftransfer = $('#selectModeofTransfer').val();
                        var typeoftransfer = $('#selectTypeofTransfer').val();
                        var requestedby = $('#selectRequestedby').val();
                        var checkedby = $('#selectCheckedby').val();
                        var approvedby = $('#selectApprovedby').val();

                        SaveFarmOut(
                            controlno, division, natureofitem, transferto,
                            typeofitem, classificationofitem, purposeofitem, beareremployeeno,
                            beareremployeename, requestoremployeeno, requestoremployeename,
                            requestorsection, localno, daterequested, dateoftransfer, dateofreturn,
                            packagingused, supplierid, suppliername, address, origin, invoice, receipt,
                            contactperson, contactno, telephoneno, faxno, modeoftransfer, typeoftransfer,
                            userid, function (d) {
                                console.log(d);
                                controlno = d['Table'][0]['CONTROLNO'];
                                $('#txtControlNo').val(controlno);
                                SaveApproval(controlno, requestedby, checkedby, approvedby, userid);
                                SaveMirrorApproval(controlno, userid);
                                location.replace(current_url + '?controlno=' + controlno);
                            });
                    };
                });

                $('#btnNew').click(function () {
                    var controlno = $('#txtControlNo').val()
                    CheckPurposeOfItemIfWithLOA(controlno, function (d) {
                        console.log(d);
                        if (d === true) {
                            $('#selectLOADescription').empty();
                            $('<option/>', {
                                value: 'N/A',
                                text: 'N/A'
                            }).appendTo($("#selectLOADescription"));
                        }
                        else {
                            $('#selectLOADescription').empty();
                            var division = $('#selectDivision').val();
                            var supplier = $('#selectSupplierName').val();
                            GetLOADescription(division, supplier, function (d) {
                                if (d.length > 0) {
                                    $('<option/>', {
                                        value: '',
                                        text: 'Choose...'
                                    }).appendTo($("#selectLOADescription"));

                                    for (var i in d) {
                                        $('<option/>', {
                                            value: d[i]['DESCRIPTION'],
                                            text: d[i]['DESCRIPTION']
                                        }).appendTo($("#selectLOADescription"));
                                    }
                                }
                                else {
                                    $('#selectLOADescription').empty();
                                    $('<option/>', {
                                        value: 'N/A',
                                        text: 'N/A'
                                    }).appendTo($("#selectLOADescription"));
                                }
                            });
                        }
                    });
                });

                $('#btnSaveItem').click(function () {
                    if ($("#form1").valid()) {
                        var id = $('#txtID').val();
                        var typeofitem = $('#selectLOADescription').val();
                        var controlno = $('#txtControlNo').val();
                        var itemcode = $('#txtItemNo').val();
                        var itemdesc = $('#txtItemDescription').val();
                        var quantity = $('#txtQuantity').val();
                        var uom = $('#txtUnitofMeasure').val();
                        var amount = $('#txtAmount').val();
                        var assetno = $('#txtAssetNo').val();
                        var odno = $('#txtOD').val();
                        var contno = $('#txtContainer').val();
                        var pezaseal = $('#txtPEZASeal').val();
                        var dsrdrno = $('#txtDSRDRNo').val();

                        if (id === null || id === '') {
                            SaveItem(controlno, typeofitem, itemcode, itemdesc, quantity, uom, amount, assetno, odno, contno, pezaseal, dsrdrno, userid, function () {
                                ClearItems();
                            });
                            location.reload();
                        }
                        else {
                            UpdateItem(id, controlno, typeofitem, itemcode, itemdesc, quantity, uom, amount, assetno, odno, contno, pezaseal, dsrdrno, userid, function () {
                                ClearItems();
                            });
                            location.reload();
                        }
                    }
                });

                $('#btnApprove').click(function () {
                    var comment = $('#txtApproveComment').val();
                    var emailtype = 'Approval';
                    Approve(controlno, current_workflowid, current_approverid, comment, current_assigneduserid, function () {
                        SendEmail(controlno, emailtype, comment);
                        location.reload();
                    });
                });

                $('#btnSaveRequestChange').click(function () {
                    var comment = $('#txtRequestChangeComment').val();
                    var emailtype = 'Request Change';
                    RequestChange(controlno, current_workflowid, current_approverid, comment, current_assigneduserid, function () {
                        SendEmail(controlno, emailtype, comment);
                    });
                    location.reload();
                });

                $('#btnSaveReassign').click(function () {
                    var comment = $('#txtReassignComment').val();
                    var emailtype = 'Re-assign';
                    reassignto = $('#selectReassign').val();
                    ReassignTask(controlno, current_workflowid, current_approverid, reassignto, comment, current_assigneduserid, function () {
                        SendEmail(controlno, emailtype, comment);
                    });
                    location.reload();
                });
                $('#btnCancelRequest').click(function () {
                    var comment = $('#txtReason').val();
                    CancelFarmOut(controlno, comment, userid);
                    location.replace('RequestForm.aspx');
                });
                $(document).on('click', 'button', function (e) {
                    var elem = $(this);
                    tableItems = $("#tableItems").DataTable();
                    if (elem.hasClass('btn-delete-row')) {
                        var controlno = $('txtControlNo').val();
                        var data = tableItems.row(elem.parents('tr')).data();
                        var id = data[Object.keys(data)[0]];
                        if (confirm("Are you sure you want to delete this item?")) {
                            tableItems.row(elem.parents('tr')).remove().draw();
                            DeleteItem(id);
                        }
                    }
                    if (elem.hasClass('btn-update-row')) {
                        var data = tableItems.row(elem.parents('tr')).data();

                        var id = data[Object.keys(data)[0]];
                        var controlno = data[Object.keys(data)[1]];
                        var typeofitem = data[Object.keys(data)[2]];
                        var itemcode = data[Object.keys(data)[3]];
                        var itemdesc = data[Object.keys(data)[4]];
                        var quantity = data[Object.keys(data)[5]];
                        var uom = data[Object.keys(data)[6]];
                        var amount = data[Object.keys(data)[7]];
                        var assetno = data[Object.keys(data)[8]];
                        var odno = data[Object.keys(data)[9]];
                        var contno = data[Object.keys(data)[10]];
                        var pezaseal = data[Object.keys(data)[11]];
                        var dsrdrno = data[Object.keys(data)[12]];

                        CheckPurposeOfItemIfWithLOA(controlno, function (d) {
                            if (d === true) {
                                $('#selectLOADescription').empty();
                                $('<option/>', {
                                    value: 'N/A',
                                    text: 'N/A'
                                }).appendTo($("#selectLOADescription"));
                            }
                            else {
                                $('#selectLOADescription').empty();
                                var division = $('#selectDivision').val();
                                var supplier = $('#selectSupplierName').val();
                                GetLOADescription(division, supplier, function (d) {
                                    $('<option/>', {
                                        value: '',
                                        text: 'Choose...'
                                    }).appendTo($("#selectLOADescription"));

                                    for (var i in d) {
                                        $('<option/>', {
                                            value: d[i]['DESCRIPTION'],
                                            text: d[i]['DESCRIPTION']
                                        }).appendTo($("#selectLOADescription"));
                                    }
                                    $('#selectLOADescription').val(typeofitem).trigger('change');
                                });
                            }
                        });
                        $('#txtID').val(id);
                        $('#txtControlNo').val(controlno);
                        $('#txtItemNo').val(itemcode);
                        $('#txtItemDescription').val(itemdesc);
                        $('#txtQuantity').val(quantity);
                        $('#txtUnitofMeasure').val(uom);
                        $('#txtAmount').val(amount);
                        $('#txtAssetNo').val(assetno);
                        $('#txtOD').val(odno);
                        $('#txtContainer').val(contno);
                        $('#txtPEZASeal').val(pezaseal);
                        $('#txtDSRDRNo').val(dsrdrno);
                    }
                    if (elem.hasClass('btn-remove-row')) {
                        var controlno = $('#txtControlNo').val();
                        var filename = $(this).closest('tr').find('.row-index').text();
                        DeleteFile(controlno, filename, function (textStatus) {
                        });
                    }
                    if (elem.hasClass('btn-view-row')) {
                        var controlno = $('#txtControlNo').val();
                        var filename = $(this).closest('tr').find('.row-index').text();
                        e.preventDefault();
                        window.open('/RelatedDocu/' + controlno + '/' + filename + '', '_blank');
                    }
                });

                $('#selectSupplierName').change(function () {
                    supplier = $(this).val();
                    GetSupplierAddress(supplier, function (d) {
                        $('#txtDestinationAddress').val(d[0]['SupplierAddress']);
                    });
                });

                $("#fileUpload").on('change', function () {
                    console.log(this.files[0]);
                    console.log(this.files[0]['type']);
                    if (this.files[0]['type'] !== 'application/pdf') {
                        alert('Only pdf file can be uploaded!')
                        $('#fileUpload').val('');
                        $('.custom-file-label').text('Choose file...');
                    }
                    if (this.files[0]['size'] > 5000000) {
                        alert('5mb is the maximum file size that can be uploaded!')
                        $('#fileUpload').val('');
                        $('.custom-file-label').text('Choose file...');
                    }

                });

                $('#btnUpload').click(function () {
                    if ($("#fileUpload").val() !== '') {
                        var controlno = $('#txtControlNo').val();
                        var formData = new FormData();
                        formData.append("file", $("#fileUpload")[0].files[0]);
                        console.log(formData);
                        UploadFile(formData, controlno, userid);
                    }
                    else {
                        alert('Please choose file to upload!');
                    }
                });
                $('#btnConfirm1').click(function () {
                    var table = $('#tableItems').DataTable();
                    var info = table.page.info();

                    if (info.recordsDisplay > 0) {
                        $('#btnChange').prop('hidden', true);
                        $('#btnReassign').prop('hidden', true);
                        $('#modalConfirm').modal('show');
                    }
                    else {
                        alert('No items added!');
                        $('#btnNew').focus();
                    }

                });
                $('#btnConfirm2').click(function () {
                    $('#btnChange').prop('hidden', false);
                    $('#btnReassign').prop('hidden', false);
                });
                $('#btnConfirm3').click(function () {
                    $('#btnChange').prop('hidden', false);
                    $('#btnReassign').prop('hidden', false);
                });
                $('#btnChange').click(function () {
                    $('#txtAssignedto').val($('#selectRequestedby option:selected').text());
                    $('#modalConfirm').modal('hide');
                    $('#modalRequestChange').modal('toggle');
                });
                $('#btnReassign').click(function () {
                    $('#modalConfirm').modal('hide');
                    $('#modalReassignTask').modal('toggle');
                });
                $('#btnCancelChange').click(function () {
                    $('#modalRequestChange').modal('hide');
                    $('#modalConfirm').modal('toggle');
                });
                $('#btnCancelReassign').click(function () {
                    $('#modalReassignTask').modal('hide');
                    $('#modalConfirm').modal('toggle');
                });
                $('#btnPrint').click(function () {
                    location.replace('RequestFormPrint.aspx?controlno=' + controlno);
                });
                $('#btnView').click(function () {
                    location.replace('FarmOutDocuments.aspx?controlno=' + controlno);
                });

                //Editing Checkedby
                $('#btnEditCheckedby').click(function () {
                    $(this).prop('hidden', true);
                    $('#selectCheckedby').prop('disabled', false);
                    $('#btnCancelEditCheckedby').prop('hidden', false);
                });
                $('#selectCheckedby').change(function (d) {
                    if (isApprovedbyRequestor == true) {
                        if ($(this).val() !== checkedby) {
                            $('#btnSaveCheckedby').prop('hidden', false);
                        }
                        else {
                            $('#btnSaveCheckedby').prop('hidden', true);
                        }
                    }
                });
                $('#btnCancelEditCheckedby').click(function () {
                    $('#selectCheckedby').val(checkedby).trigger('change');
                    $(this).prop('hidden', true);
                    $('#btnSaveCheckedby').prop('hidden', true);
                    $('#selectCheckedby').prop('disabled', true);
                    $('#btnEditCheckedby').prop('hidden', false);
                });
                $('#btnSaveCheckedby').click(function () {
                    var approverid = 2;
                    var approveruserid = $('#selectCheckedby').val();
                    UpdateApproval(controlno, approverid, approveruserid, userid, function () {
                        $('#btnCancelEditCheckedby').prop('hidden', true);
                        $('#btnSaveCheckedby').prop('hidden', true);
                        $('#selectCheckedby').prop('disabled', true);
                        $('#btnEditCheckedby').prop('hidden', false);
                        GetFarmOut(controlno, function (d) {
                            requestedby = d['Table'][0]['ASSIGNEDUSERID'];
                            checkedby = d['Table'][1]['ASSIGNEDUSERID'];
                            approvedby = d['Table'][2]['ASSIGNEDUSERID'];
                            current_approverid = d['Table'][0]['APPROVERID_CURRENT'];
                            current_assigneduserid = d['Table'][0]['ASSIGNEDUSERID_CURRENT'];
                            current_workflowid = d['Table'][0]['WORKFLOWID_CURRENT'];

                            statusid1 = d['Table'][0]['CURRENTSTATUSID'];
                            statusid2 = d['Table'][1]['CURRENTSTATUSID'];
                            statusid3 = d['Table'][2]['CURRENTSTATUSID'];
                        });
                    });
                });
                //Editing Approvedby
                $('#btnEditApprovedby').click(function () {
                    $(this).prop('hidden', true);
                    $('#selectApprovedby').prop('disabled', false);
                    $('#btnCancelEditApprovedby').prop('hidden', false);
                });
                $('#selectApprovedby').change(function (d) {
                    if (isApprovedbyRequestor == true) {
                        if ($(this).val() !== approvedby) {
                            $('#btnSaveApprovedby').prop('hidden', false);
                        }
                        else {
                            $('#btnSaveApprovedby').prop('hidden', true);
                        }
                    }
                });
                $('#btnCancelEditApprovedby').click(function () {
                    console.log(approvedby);
                    $('#selectApprovedby').val(approvedby).trigger('change');
                    $(this).prop('hidden', true);
                    $('#btnSaveApprovedby').prop('hidden', true);
                    $('#selectApprovedby').prop('disabled', true);
                    $('#btnEditApprovedby').prop('hidden', false);
                });
                $('#btnSaveApprovedby').click(function () {
                    var approverid = 3;
                    var approveruserid = $('#selectApprovedby').val();
                    console.log(controlno, approverid, approveruserid, userid);
                    UpdateApproval(controlno, approverid, approveruserid, userid, function () {
                        $('#btnCancelEditApprovedby').prop('hidden', true);
                        $('#btnSaveApprovedby').prop('hidden', true);
                        $('#selectApprovedby').prop('disabled', true);
                        $('#btnEditApprovedby').prop('hidden', false);
                        GetFarmOut(controlno, function (d) {
                            requestedby = d['Table'][0]['ASSIGNEDUSERID'];
                            checkedby = d['Table'][1]['ASSIGNEDUSERID'];
                            approvedby = d['Table'][2]['ASSIGNEDUSERID'];
                            current_approverid = d['Table'][0]['APPROVERID_CURRENT'];
                            current_assigneduserid = d['Table'][0]['ASSIGNEDUSERID_CURRENT'];
                            current_workflowid = d['Table'][0]['WORKFLOWID_CURRENT'];

                            statusid1 = d['Table'][0]['CURRENTSTATUSID'];
                            statusid2 = d['Table'][1]['CURRENTSTATUSID'];
                            statusid3 = d['Table'][2]['CURRENTSTATUSID'];
                        });
                    });
                });
            });
        });
    </script>
</asp:Content>

