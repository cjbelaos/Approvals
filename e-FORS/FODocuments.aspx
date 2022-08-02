<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FODocuments.aspx.cs" Inherits="FODocuments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Forms</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Farm-out Documents</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Farm-out Documents</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Farm-out Control No.</label>
                                <div class="input-group">
                                    <input type="text" id="txtControlNo" class="form-control" disabled />
                                    <div class="input-group-append">
                                        <button type="button" id="btnView" class="btn btn-sm btn-primary"><i class="fas fa-eye"></i></button>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Document Format</label>
                                <span style="color: #ff0000; font-weight: bold">*</span>
                                <select id="selectDocumentFormat" class="form-control select2" style="width: 100%;">
                                    <option selected value="0">&nbsp;</option>
                                </select>
                                <small id="DocFormatHelpBlock" class="form-text text-danger" hidden>Required</small>
                                <div class="card">
                                    <div class="card-body p-0">
                                        <table id="tablePrint" class="table table-sm table-bordered table-striped" hidden>
                                            <thead>
                                                <tr>
                                                    <th class="text-center">Print</th>
                                                    <th class="text-center">Task</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tbody">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>PEZA Document No.</label>
                                <input type="text" id="txtPEZADOCNo" class="form-control" />
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Gatepass No.</label>
                                <input type="text" id="txtGPNo" class="form-control" />
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group LOA" hidden>
                                <label>LOA No.</label>
                                <input type="text" id="txtLOANo" class="form-control" disabled />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group LOA" hidden>
                                <label>Surety Bond No.</label>
                                <input type="text" id="txtSBNo" class="form-control" disabled />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Container No.</label>
                                <input type="text" id="txtCONTNo" class="form-control" />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Plate No.</label>
                                <input type="text" id="txtPlateNo" class="form-control" />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>8105 Control No.</label>
                                <input type="text" id="txt8105" class="form-control" />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>EPPI Authorized Signatory</label>
                                <span style="color: #ff0000; font-weight: bold">*</span>
                                <select id="selectEPPIAS" class="form-control select2" style="width: 100%">
                                    <option selected value="0"></option>
                                </select>
                                <small id="EPPIASHelpBlock" class="form-text text-danger" hidden>Required</small>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>PEZA Examiner Signatory</label>
                                <input type="text" id="txtPEZAES" class="form-control" disabled />
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>PEZA OIC Signatory</label>
                                <input type="text" id="txtPEZAOIC" class="form-control" disabled />
                            </div>
                            <!-- /.form-group -->

                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group LOA" hidden>
                                <label>Expiry Date</label>
                                <div class="input-group date" data-target-input="nearest">
                                    <input type="text" id="txtLOAEXP" class="form-control datetimepicker-input" data-target="#LOAEXP" disabled />
                                    <div class="input-group-append" data-target="#LOAEXP" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group LOA" hidden>
                                <label>Expiry Date</label>
                                <div class="input-group date" data-target-input="nearest">
                                    <input type="text" id="txtSBEXP" class="form-control datetimepicker-input" data-target="#SBEXP" disabled />
                                    <div class="input-group-append" data-target="#SBEXP" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="inputPEZASeal">PEZA Seal</label>
                                <input type="text" id="txtPEZASeal" class="form-control" />
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
                                <label>Prepared by</label>
                                <span style="color: #ff0000; font-weight: bold">*</span>
                                <div class="input-group">
                                    <select id="selectPreparedby" class="form-control select2">
                                        <option selected value="0"></option>
                                    </select>
                                    <div class="input-group-append">
                                        <button type="button" id="btnConfirm1" class="btn btn-sm btn-success" data-toggle="modal" data-target="#modal_confirm"><i class="fas fa-check"></i></button>
                                    </div>
                                </div>
                                <small id="PreparedHelpBlock" class="form-text text-danger" hidden>Required</small>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <div class="col-md-2" style="text-align: center">
                            <div class="form-group-row">
                                <label>Status</label>
                                <label id="lblStatus1" class="form-control-plaintext"></label>
                            </div>
                        </div>
                        <div class="col-md-2" style="text-align: center">
                            <div class="form-group-row">
                                <label>Comment</label>
                                <label id="lblComment1" class="form-control-plaintext"></label>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <div class="col-md-2" style="text-align: center">
                            <div class="form-group-row">
                                <label>Date</label>
                                <label id="lblDate1" class="form-control-plaintext"></label>
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Approved by</label>
                                <span style="color: #ff0000; font-weight: bold">*</span>
                                <div class="input-group">
                                    <select id="selectApprovedby" class="form-control select2">
                                        <option selected value="0"></option>
                                    </select>
                                    <div class="input-group-append">
                                        <button type="button" id="btnConfirm2" class="btn btn-sm btn-success" data-toggle="modal" data-target="#modal_confirm"><i class="fas fa-check"></i></button>
                                    </div>
                                </div>
                                <small id="ApprovedHelpBlock" class="form-text text-danger text-bold" hidden>Required</small>
                            </div>
                        </div>
                        <div class="col-md-2" style="text-align: center">
                            <div class="form-group-row">
                                <label>&nbsp; </label>
                                <label id="lblStatus2" class="form-control-plaintext"></label>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-2" style="text-align: center">
                            <div class="form-group-row">
                                <label>&nbsp; </label>
                                <label id="lblComment2" class="form-control-plaintext"></label>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-2" style="text-align: center">
                            <!-- /.form-group -->
                            <div class="form-group-row">
                                <label>&nbsp; </label>
                                <label id="lblDate2" class="form-control-plaintext"></label>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                    </div>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                    <button type="button" id="btnSave" class="btn btn-primary"><i class="fas fa-save"></i></button>
                </div>
            </div>
            <!-- /.card -->

        </div>
    </section>

    <!-- Modal -->
    <div class="modal fade" id="modal_confirm" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <textarea id="txtComment" class="form-control" rows="3" placeholder="Comment"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 50px"><i class="fas fa-window-close"></i></button>
                    <button type="button" id="btnApprove" class="btn btn-success btn-sm" style="width: 50px"><i class="fas fa-thumbs-up"></i></button>
                    <button type="button" id="btnRequestChange" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal_requestchange" style="width: 50px"><i class="fas fa-redo"></i></button>
                    <button type="button" id="btnReassignTask" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal_reassigntask" style="width: 50px"><i class="fas fa-user-edit"></i></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->


    <!-- Modal -->
    <div class="modal fade" id="modal_requestchange" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Request Change</h5>
                </div>
                <div class="modal-body">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-3">
                                    <label class="col-form-label-sm">Assigned</label>
                                </div>
                                <div class="col-sm-9">
                                    <input type="text" id="txtAssign" class="form-control-sm" disabled />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <textarea id="txtRequestComment" class="form-control" rows="3" placeholder="Comment"></textarea>
                                </div>
                            </div>
                        </div>
                        <!-- /.form-group -->
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 50px"><i class="fas fa-window-close"></i></button>
                    <button type="button" id="btnSaveRequest" class="btn btn-primary btn-sm" style="width: 50px"><i class="fas fa-save"></i></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- Modal -->
    <div class="modal fade" id="modal_reassigntask" data-backdrop="static">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Re-assign Task</h5>
                </div>
                <div class="modal-body">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <div class="row mb-1">
                                <div class="col-sm-1">
                                    <label class="col-form-label-sm">To</label>
                                </div>
                                <div class="col-sm-11">
                                    <select id="selectReassign" class="form-control-sm select2">
                                        <option selected value="0"></option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <textarea id="txtReassignComment" class="form-control" rows="3" placeholder="Comment"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 50px"><i class="fas fa-window-close"></i></button>
                    <button type="button" id="btnSaveReassign" class="btn btn-primary btn-sm" style="width: 50px"><i class="fas fa-save"></i></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <div class="modal fade" id="modalPrint">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <asp:Label ID="lblPrintTitle" runat="server"></asp:Label></h5>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Date</label>
                            <div class="input-group date" id="Date" data-target-input="nearest">
                                <asp:TextBox runat="server" ID="txtDate" CssClass="form-control datetimepicker-input" data-target="#Date"></asp:TextBox>
                                <div class="input-group-append" data-target="#Date" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                        <!-- /.form-group -->
                        <div id="divControlNo" class="form-group">
                            <label runat="server" id="lblControlNo">ControlNo.</label>
                            <asp:DropDownList runat="server" ID="ddlControlNo" multiple="multiple" data-placeholder="" CssClass="form-control select2" Width="100%" name="typeofitem"></asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hfControlNo" />
                        </div>
                        <!-- /.form-group -->
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 70px">Close</button>
                    <asp:Button runat="server" ID="BtnDone" CssClass="btn btn-primary btn-sm" Text="Done" Width="70px" />
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">

        $('.select2').select2();

        $('#LOAEXP').datetimepicker({
            format: 'L'
        });
        $('#SBEXP').datetimepicker({
            format: 'L'
        });

        var TABLEPRINT;
        var workflow_id = '';
        var approver_id = '';
        var currentLocation = window.location.href;
        var Session;

        let TABLE = $('#tablePrint');
        let CONTROLNO = $('#txtControlNo');
        let DOCUMENTFORMAT = $('#selectDocumentFormat');
        let PEZADOCNO = $('#txtPEZADOCNo');
        let GPNO = $('#txtGPNo');
        let LOANO = $('#txtLOANo');
        let LOAEXP = $('#txtLOAEXP');
        let SBNO = $('#txtSBNo');
        let SBEXP = $('#txtSBEXP');
        let CONTNO = $('#txtCONTNo');
        let PEZASEAL = $('#txtPEZASeal');
        let PLATENO = $('#txtPlateNo');
        let CN8105 = $('#txt8105');
        let EPPIAS = $('#selectEPPIAS');
        let PEZAES = $('#txtPEZAES');
        let PEZAOIC = $('#txtPEZAOIC');
        let PREPARED = $('#selectPreparedby');
        let APPROVED = $('#selectApprovedby');
        let STATUS1 = $('#lblStatus1');
        let COMMENT1 = $('#lblComment1');
        let DATE1 = $('#lblDate1');
        let STATUS2 = $('#lblStatus2');
        let COMMENT2 = $('#lblComment2');
        let DATE2 = $('#lblDate2');
        let COMMENT = $('#txtComment');
        let REASSIGNED = $('#selectReassign');
        let VIEW = $('#btnView');
        let CONFIRM1 = $('#btnConfirm1');
        let CONFIRM2 = $('#btnConfirm2');
        let SAVE = $('#btnSave');
        let APPROVE = $('#btnApprove');
        let CHANGE = $('#btnRequestChange');
        let REASSIGN = $('#btnReassignTask');
        let SMALLDOCFORMAT = $('#DocFormatHelpBlock');
        let SMALLEPPIAS = $('#EPPIASHelpBlock');
        let SMALLPREPARED = $('#PreparedHelpBlock');
        let SMALLAPPROVED = $('#ApprovedHelpBlock');
        let LOA = $('.LOA');

        $(document).ready(function () {
            var url = location.search;
            var ctrlno = url.split("=");
            CONTROLNO.val(ctrlno[1]);

            GetDocumentFormat(function (e) {
                for (var i in e) {
                    $('<option/>', {
                        value: e[i]['Task'],
                        text: e[i]['Task']
                    }).appendTo(DOCUMENTFORMAT);
                }

                GetEPPIAuthorizedSignatory(function (e) {
                    for (var i in e) {
                        $('<option/>', {
                            value: e[i]['APOACCOUNT'],
                            text: e[i]['EMPLOYEENAME']
                        }).appendTo(EPPIAS);
                        $('<option/>', {
                            value: e[i]['APOACCOUNT'],
                            text: e[i]['EMPLOYEENAME']
                        }).appendTo(APPROVED);
                        $('<option/>', {
                            value: e[i]['APOACCOUNT'],
                            text: e[i]['EMPLOYEENAME']
                        }).appendTo(REASSIGNED);
                    }

                    GetPEZASignatory(function (e) {
                        PEZAES.html('');
                        PEZAES.val(e.Table[0]['NAME']);
                        PEZAOIC.html('');
                        PEZAOIC.val(e.Table1[0]['NAME']);
                        GetPreparedby(function (e) {
                            for (var i in e) {
                                $('<option/>', {
                                    value: e[i]['APOAccount'],
                                    text: e[i]['Name']
                                }).appendTo(PREPARED);
                            }
                        });

                        if (CONTROLNO.val() != '') {
                            FarmOutDocumentsControlNoChecking(function (d) {
                                var exist = d;
                                if (exist == true) {
                                    GetFarmOutDocument(function (d) {
                                        var _DOCUMENTFORMAT = d[1]['DOCUMENTFORMAT'];
                                        var _PEZADOCNO = d[1]['PEZADOCUMENTNO'];
                                        var _GPNO = d[1]['GATEPASSNO'];
                                        var _LOANO = d[1]['LOANO'];
                                        var _LOAEXP;
                                        if (d[1]['LOAEXPIRYDATE'] == null) {
                                            _LOAEXP = '';
                                        }
                                        else {
                                            _LOAEXP = moment(d[1]['LOAEXPIRYDATE']).format("L");
                                        }
                                        var _SBNO = d[1]['SURETYBONDNO'];
                                        var _SBEXP;
                                        if (d[1]['LOAEXPIRYDATE'] == null) {
                                            _SBEXP = '';
                                        }
                                        else {
                                            _SBEXP = moment(d[1]['SURETYEXPIRYDATE']).format("L");
                                        }
                                        var _CONTNO = d[1]['CONTAINERNO'];
                                        var _PEZASEAL = d[1]['PEZASEAL'];
                                        var _PLATENO = d[1]['PLATENO'];
                                        var _CN8105 = d[1]['CONTROLNO8105'];
                                        var _EPPIAS = d[1]['EPPIAUTHORIZEDSIGNATORY'];
                                        var _PEZAES = d[1]['PEZAEXAMINERSIGNATORY'];
                                        var _PEZAOIC = d[1]['PEZAOICSIGNATORY'];
                                        var _PREPARED = d[0]['ASSIGNEDUSERID'];
                                        var _APPROVED = d[1]['ASSIGNEDUSERID'];
                                        var _STATUS1 = d[0]['CURRENTSTATUS'];
                                        var _COMMENT1 = d[0]['COMMENT'];
                                        var _DATE1;
                                        if (d[0]['ACTIONDATE'] == null) {
                                            _DATE1 = '';
                                        }
                                        else {
                                            _DATE1 = moment(d[0]['ACTIONDATE']).format("L");
                                        }
                                        var _STATUS2 = d[1]['CURRENTSTATUS'];
                                        var _COMMENT2 = d[1]['COMMENT'];
                                        var _DATE2;
                                        if (d[1]['ACTIONDATE'] == null) {
                                            _DATE2 = '';
                                        }
                                        else {
                                            _DATE2 = moment(d[1]['ACTIONDATE']).format("L");
                                        }
                                        var _CHECKPREPARED = d[0]['ASSIGNEDUSERID_CURRENT']
                                        var _CHECKAPPROVED = d[1]['ASSIGNEDUSERID_CURRENT']

                                        DOCUMENTFORMAT.val(_DOCUMENTFORMAT).trigger('change');
                                        PEZADOCNO.val(_PEZADOCNO);
                                        GPNO.val(_GPNO);
                                        LOANO.val(_LOANO);
                                        LOAEXP.val(_LOAEXP);
                                        SBNO.val(_SBNO);
                                        SBEXP.val(_SBEXP);
                                        CONTNO.val(_CONTNO);
                                        PEZASEAL.val(_PEZASEAL);
                                        PLATENO.val(_PLATENO);
                                        CN8105.val(_CN8105);
                                        EPPIAS.val(_EPPIAS).trigger('change');
                                        PEZAES.val(_PEZAES);
                                        PEZAOIC.val(_PEZAOIC);
                                        PREPARED.val(_PREPARED).trigger('change');
                                        APPROVED.val(_APPROVED).trigger('change');
                                        STATUS1.text(_STATUS1).trigger('change');
                                        COMMENT1.text(_COMMENT1).trigger('change');
                                        DATE1.text(_DATE1).trigger('change');
                                        STATUS2.text(_STATUS2).trigger('change');
                                        COMMENT2.text(_COMMENT2).trigger('change');
                                        DATE2.text(_DATE2).trigger('change');

                                        if (PREPARED.val() != _CHECKPREPARED) {
                                            DisableForm();
                                        }
                                        if (APPROVED.val() == _CHECKAPPROVED) {
                                            DisableForm();
                                            CONFIRM2.prop('disabled', false)
                                        }
                                        else {
                                            CONFIRM2.prop('disabled', true)
                                        }
                                    });
                                }
                                else {
                                    PREPARED.val(user_id).trigger('change');
                                }
                            });
                        }
                    });
                });
            });

            SAVE.on('click', function () {
                ShowHelpBlocks();
                if (DOCUMENTFORMAT.val() == '0' || EPPIAS.val() == '0' || PREPARED.val() == '0' || APPROVED.val() == '0') {
                    event.preventDefault();
                    alert('NO');
                }
                else {
                    SaveFarmOutDetails();
                }

                DOCUMENTFORMAT.on('change', function () {
                    if (DOCUMENTFORMAT.val() != '0') {
                        SMALLDOCFORMAT.prop('hidden', true);
                    }
                    else {
                        SMALLDOCFORMAT.prop('hidden', false);
                    }
                });

                EPPIAS.on('change', function () {
                    if (EPPIAS.val() != '0') {
                        SMALLEPPIAS.prop('hidden', true);
                    }
                    else {
                        SMALLEPPIAS.prop('hidden', false);
                    }
                });

                PREPARED.on('change', function () {
                    if (PREPARED.val() != '0') {
                        SMALLPREPARED.prop('hidden', true);
                    }
                    else {
                        SMALLPREPARED.prop('hidden', false);
                    }
                });

                APPROVED.on('change', function () {
                    if (APPROVED.val() != '0') {
                        SMALLAPPROVED.prop('hidden', true);
                    }
                    else {
                        SMALLAPPROVED.prop('hidden', false);
                    }
                });
            });

            CONFIRM1.on('click', function () {
                CHANGE.prop('hidden', true);
                REASSIGN.prop('hidden', true);
                APPROVE.on('click', function () {
                    var workflow_id = '1';
                    var approver_id = '1';
                    Approve(workflow_id, approver_id);
                });
            });

            VIEW.on('click', function () {
                var controlno = CONTROLNO.val();
                window.location.replace('FarmOutRequestForm.aspx?controlno=' + controlno);
            });

            DOCUMENTFORMAT.on('change', function () {
                var task = $(this).val();
                var id;

                if (task == 'PEZA FORM 8106') {
                    id = '8106';
                    LOA.removeAttr('hidden');
                }
                else if (task == 'PEZA FORM 8112') {
                    id = '8112';
                    LOA.removeAttr('hidden');
                }
                else if (task == 'PEZA FORM 8110') {
                    id = '8110';
                    LOA.prop('hidden', true);
                }
                else if (task == 'GATEPASS') {
                    id = 'GP';
                    LOA.prop('hidden', true);
                }
                else {
                    id = '0';
                    LOA.prop('hidden', true);
                }

                if (task != '0') {
                    TABLE.removeAttr('hidden');
                    if (task != '0' && task != 'GATEPASS') {
                        $("#tbody").empty();
                        $('#tbody').append(
                            '<tr id="' + task + '"><td class="text-center"><button type="button" id="btnPrint' + id + '" class="btn btn-sm btn-info btn-print-row" title="Print"><i class="fas fa-print"></i></button></td><td class="text-center">' + task + '</td></tr><tr id="GATEPASS"><td class="text-center"><button type="button" id="btnPrintGP" class="btn btn-sm btn-info btn-print-row" title="Print"><i class="fas fa-print"></i></button></td ><td class="text-center">GATEPASS</td></tr>'
                        );
                    }
                    else if (task == 'GATEPASS') {
                        $("#tbody").empty();
                        $('#tbody').append(
                            '<tr id="' + task + '"><td class="text-center"><button type="button" id="btnPrint' + id + '" class="btn btn-sm btn-info btn-print-row" title="Print"><i class="fas fa-print"></i></button></td ><td class="text-center">' + task + '</td></tr>'
                        );
                    }
                }
                else {
                    TABLE.prop('hidden', true);
                }

                let PRINT8106 = $('#btnPrint8106');
                let PRINT8112 = $('#btnPrint8112');
                let PRINT8110 = $('#btnPrint8110');
                let PRINTGP = $('#btnPrintGP');

                PRINT8106.on('click', function () {
                    alert('YES');
                });

                PRINT8112.on('click', function () {
                    alert('YES');
                });

                PRINT8110.on('click', function () {
                    alert('YES');
                });

                PRINTGP.on('click', function () {
                    alert('YES');
                });
            });

            GetSession(function (e) {
                Session = e;
                var user_id = Session["UserID"];

                function SaveFarmOutDetails(callback) {
                    var FarmOutDocumentDetails = {};
                    FarmOutDocumentDetails.USERID = user_id;
                    FarmOutDocumentDetails.CONTROLNO = CONTROLNO.val();
                    FarmOutDocumentDetails.DOCFORMAT = DOCUMENTFORMAT.val();
                    FarmOutDocumentDetails.PEZADOCNO = PEZADOCNO.val().toUpperCase();
                    FarmOutDocumentDetails.GPNO = GPNO.val().toUpperCase();
                    FarmOutDocumentDetails.LOANO = LOANO.val().toUpperCase();
                    FarmOutDocumentDetails.LOAEXP = LOAEXP.val();
                    FarmOutDocumentDetails.SBNO = SBNO.val();
                    FarmOutDocumentDetails.SBEXP = SBEXP.val();
                    FarmOutDocumentDetails.CONTNO = CONTNO.val().toUpperCase();
                    FarmOutDocumentDetails.PEZASEAL = PEZASEAL.val().toUpperCase();
                    FarmOutDocumentDetails.PLATENO = PLATENO.val().toUpperCase();
                    FarmOutDocumentDetails.CN8105 = CN8105.val().toUpperCase();
                    FarmOutDocumentDetails.EPPIAS = EPPIAS.val();
                    FarmOutDocumentDetails.PEZAES = PEZAES.val();
                    FarmOutDocumentDetails.PEZAOIC = PEZAOIC.val();
                    FarmOutDocumentDetails.PREPARED = PREPARED.val();
                    FarmOutDocumentDetails.APPROVED = APPROVED.val();
                    $.ajax({
                        url: "FODocuments.aspx/SaveFarmOutDocuments",
                        method: "POST",
                        data: JSON.stringify({ fdd: FarmOutDocumentDetails }),
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                            SaveFarmOutDetailsSuccessAlert2();
                            GetLOA();
                            ClearFields();
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                    $.ajax({
                        url: "FODocuments.aspx/SaveFarmOutDocumentsApproval",
                        method: "POST",
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

                function GetFarmOutDocument(callback) {
                    var FarmOutDetails = {};
                    FarmOutDetails.ControlNo = CONTROLNO.val();
                    $.ajax({
                        url: 'FODocuments.aspx/GetFarmOutDocument',
                        method: 'post',
                        data: JSON.stringify({ fd: FarmOutDetails }),
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function Approve(user_id, workflow_id, approver_id, callback) {
                    var Approval = {};
                    Approval.UserID = user_id;
                    Approval.WorkFlowID = workflow_id;
                    Approval.ApproverID = approver_id;
                    Approval.ControlNo = CONTROLNO.val();
                    Approval.Comment = COMMENT.val();
                    $.ajax({
                        url: 'FODocuments.aspx/Approve',
                        method: 'post',
                        data: JSON.stringify({ a: Approval }),
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function FarmOutDocumentsControlNoChecking(callback) {
                    var FarmOutDocumentDetails = {};
                    FarmOutDocumentDetails.CONTROLNO = CONTROLNO.val();
                    $.ajax({
                        url: 'FODocuments.aspx/FarmOutDocumentsControlNoChecking',
                        method: 'post',
                        data: JSON.stringify({ fdd: FarmOutDocumentDetails }),
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function GetDocumentFormat(callback) {
                    $.ajax({
                        url: 'FODocuments.aspx/GetDocumentFormat',
                        method: 'post',
                        data: {},
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function GetEPPIAuthorizedSignatory(callback) {
                    $.ajax({
                        url: 'FODocuments.aspx/GetEPPIAuthorizedSignatory',
                        method: 'post',
                        data: {},
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function GetPEZASignatory(callback) {
                    $.ajax({
                        url: 'FODocuments.aspx/GetPEZASignatory',
                        method: 'post',
                        data: {},
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function GetPreparedby(callback) {
                    $.ajax({
                        url: 'FODocuments.aspx/GetPreparedby',
                        method: 'post',
                        data: {},
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        }
                    });
                }

                function GetSession(callback) {
                    $.ajax({
                        type: "POST",
                        url: "SharedService.asmx/GetSession",
                        data: '{}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            var d = JSON.parse(r.d);
                            Session = d;
                            if (callback !== undefined) {
                                callback(d);
                            }
                        },
                        failure: function (r) {
                            ShowError(r);
                        },
                        error: function (r) {
                            ShowError(r);
                        }
                    });
                }
                function SaveFarmOutDetailsSuccessAlert() {
                    var Toast = Swal.mixin({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 3000
                    });
                    Toast.fire({
                        icon: 'success',
                        title: 'Data has been saved successfully.'
                    })
                }

                function SaveFarmOutDetailsSuccessAlert2() {
                    toastr.success('Data has been saved successfully.')
                }

                function DisableForm() {
                    let PRINT = $('.btn-print-row');

                    TABLE.prop('disabled', true);
                    CONTROLNO.prop('disabled', true);
                    DOCUMENTFORMAT.prop('disabled', true);
                    PEZADOCNO.prop('disabled', true);
                    GPNO.prop('disabled', true);
                    LOANO.prop('disabled', true);
                    LOAEXP.prop('disabled', true);
                    SBNO.prop('disabled', true);
                    SBEXP.prop('disabled', true);
                    CONTNO.prop('disabled', true);
                    PEZASEAL.prop('disabled', true);
                    PLATENO.prop('disabled', true);
                    CN8105.prop('disabled', true);
                    EPPIAS.prop('disabled', true);
                    PEZAES.prop('disabled', true);
                    PEZAOIC.prop('disabled', true);
                    PREPARED.prop('disabled', true);
                    APPROVED.prop('disabled', true);
                    STATUS1.prop('disabled', true);
                    COMMENT1.prop('disabled', true);
                    DATE1.prop('disabled', true);
                    STATUS2.prop('disabled', true);
                    COMMENT2.prop('disabled', true);
                    DATE2.prop('disabled', true);
                    VIEW.prop('disabled', true);
                    CONFIRM1.prop('disabled', true);
                    CONFIRM2.prop('disabled', true);
                    SAVE.prop('disabled', true);
                    PRINT.prop('disabled', true);
                }

                function ShowHelpBlocks() {
                    if (DOCUMENTFORMAT.val() == '0') {
                        SMALLDOCFORMAT.removeAttr('hidden');
                    }
                    else {
                        SMALLDOCFORMAT.prop('hidden', true);
                    }

                    if (EPPIAS.val() == '0') {
                        SMALLEPPIAS.removeAttr('hidden');
                    }
                    else {
                        SMALLEPPIAS.prop('hidden', true);
                    }

                    if (PREPARED.val() == '0') {
                        SMALLPREPARED.removeAttr('hidden');
                    }
                    else {
                        SMALLPREPARED.prop('hidden', true);
                    }

                    if (APPROVED.val() == '0') {
                        SMALLAPPROVED.removeAttr('hidden');
                    }
                    else {
                        SMALLAPPROVED.prop('hidden', true);
                    }
                }

                function ShowError(e) {
                    var d = e.responseJSON;
                    if (d === undefined) {
                        d = {
                            ExceptionType: e.statusText,
                            Message: $(e.responseText)[1],
                            StackTrace: e.responseText
                        }
                    }
                    var modal = $('<div/>', {
                        class: 'modal fade',
                        role: 'dialog'
                    }).appendTo('body');
                    var modalDialog = $('<div>', {
                        class: 'modal-dialog',
                        role: 'document'
                    }).appendTo(modal);
                    var modalContent = $('<div/>', {
                        class: 'modal-content'
                    }).appendTo(modalDialog);
                    var modalHeader = $('<div/>', {
                        class: 'modal-header'
                    }).appendTo(modalContent);
                    $('<button/>', {
                        type: 'button', class: 'close',
                        'data-dismiss': 'modal',
                        'aria-label': 'Close',
                        html: '<span aria-hidden="true">&times;</span>'
                    }).appendTo(modalHeader);
                    $('<h4/>', {
                        text: d.ExceptionType
                    }).appendTo(modalHeader);
                    var modalBody = $('<div/>', {
                        class: 'modal-body'
                    }).appendTo(modalContent);
                    $('<p/>', {
                        html: d.Message
                    }).appendTo(modalBody);
                    $('<pre/>', {
                        css: {
                            'max-width': '100%',
                            'max-height': '300px',
                            'overflow': 'auto'
                        },
                        html: d.StackTrace
                    }).appendTo(modalBody);
                    var modalFooter = $('<div/>', {
                        class: 'modal-footer'
                    }).appendTo(modalContent);
                    $('<button/>', {
                        class: 'btn btn-danger',
                        type: 'button',
                        text: 'Close',
                        'data-dismiss': 'modal'
                    }).appendTo(modalFooter);
                    modal.modal({
                        backdrop: 'static',
                        keyboard: false,
                        'hide.bs.modal': function () {
                            modal.remove();
                        }
                    });
                }
            });
        });
    </script>
</asp:Content>

