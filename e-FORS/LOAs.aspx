<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LOAs.aspx.cs" Inherits="LOAs" %>

<asp:Content ID="Content3" ContentPlaceHolderID="style" runat="Server">
    <style type="text/css">
        .hidden-label {
            color: transparent;
            text-shadow: none;
            background-color: transparent;
            border: 0;
        }

        .overlay {
            display: none;
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 999;
            background: rgba(255,255,255,0.8) url("Images/Spinner.gif") center no-repeat;
        }
        /* Turn off scrollbar when body element has the loading class */
        body.loading {
            overflow: hidden;
        }
            /* Make spinner image visible when body element has the loading class */
            body.loading .overlay {
                display: block;
            }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <div class="overlay"></div>
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Maintenance</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Maintenance</li>
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
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                    <input type="text" name="ID" id="txtID" class="form-control" hidden>
                    <!--- ID -->
                    <h3 class="card-title">LOA</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Supplier</label>
                                <select name="Supplier" id="selectSupplier" class="form-control select2" style="width: 100%">
                                    <option selected value="0">Choose...</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Division</label>
                                <select name="DIVISION" id="selectDivision" class="form-control select2" style="width: 100%">
                                    <option selected value="0">Choose...</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>LOA No.</label>
                                <input type="text" name="LOANO" id="txtLOANo" class="form-control text-uppercase">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Expiry Date</label>
                                <div class="input-group date" id="LOAExpiryDate" data-target-input="nearest">
                                    <input type="text" name="LOAEXP" id="txtLOAExpiryDate" class="form-control datetimepicker-input" data-target="#LOAExpiryDate" />
                                    <div class="input-group-append" data-target="#LOAExpiryDate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Surety Bond No.</label>
                                <input type="text" name="SBNO" id="txtSuretyBondNo" class="form-control text-uppercase">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Expiry Date</label>
                                <div class="input-group date" id="SBExpiryDate" data-target-input="nearest">
                                    <input type="text" name="SBEXP" id="txtSBExpiryDate" class="form-control datetimepicker-input" data-target="#SBExpiryDate" />
                                    <div class="input-group-append" data-target="#SBExpiryDate" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Description</label>
                                <input type="text" name="DESC" id="txtDescription" class="form-control text-uppercase">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Quantity Limit</label>
                                <input type="text" name="QTY" id="txtQtyLIMIT" class="form-control text-uppercase">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Unit of Measurement</label>
                                <input type="text" name="UM" id="txtUM" class="form-control text-uppercase">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Amount Limit</label>
                                <input type="text" name="AMT" id="txtAmtLimit" class="form-control text-uppercase">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <button type="submit" id="btnSave" class="btn btn-primary">Save</button>
                            <button type="button" id="btnClear" class="btn btn-danger">Clear</button>
                        </div>
                    </div>
                </div>

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tableLOA" class="table table-bordered table-condensed table-hover table-sm" style="width: 100%; white-space: pre-wrap">
                    </table>
                </div>

                <div class="card-footer">
                </div>
            </div>

            <div class="card card-primary">
                <div class="card-header">
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                            <i class="fas fa-minus"></i>
                        </button>
                    </div>
                    <h3 class="card-title">Inventory</h3>
                </div>
                <div class="card-body">
                    <table id="tableInventory" class="table table-bordered table-condensed table-hover table-sm" style="width: 100%">
                    </table>
                </div>
                <div class="card-footer">
                </div>
            </div>
        </div>
    </section>

    <div class="modal fade" id="modalInventoryDetails">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Date From</label>
                                    <div class="input-group date" id="DateFrom" data-target-input="nearest">
                                        <input type="text" name="DateFrom" id="selectDateFrom" class="form-control datetimepicker-input" data-target="#DateFrom" />
                                        <div class="input-group-append" data-target="#DateFrom" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 offset-md-4">
                                <div class="form-group">
                                    <label>Date To</label>
                                    <div class="input-group date" id="DateTo" data-target-input="nearest">
                                        <input type="text" name="DateFrom" id="selectDateTo" class="form-control datetimepicker-input" data-target="#DateTo" />
                                        <div class="input-group-append" data-target="#DateTo" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body" style="width: 100%">
                        <table id="tableInventoryDetails" class="table table-bordered table-condensed table-hover table-sm" style="white-space: nowrap;">
                        </table>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button id="btnClose" type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        $('.select2').select2();

        var LOATable;
        var InventoryTable;
        var SubTable;
        let BtnClear = $('#btnClear');
        let BtnClose = $('#btnClose');

        var loaid;
        var supplierid;
        var division;
        var loano;
        var datefrom;
        var dateto;

        $(document).ready(function () {
            GetLOA();
            GetLOAInventory();
            GetDivisionList();
            GetSupplierList();

            BtnClear.on('click', function () {
                ClearFields();
            })

            BtnClose.on('click', function () {
                $('#selectDateFrom, #selectDateTo').val('').trigger('change');
            })

            $('#DateFrom, #DateTo').on('change.datetimepicker', function () {
                datefrom = $('#selectDateFrom').val();
                dateto = $('#selectDateTo').val();
                GetLOAInventoryDetails(loaid, supplierid, division, loano, datefrom, dateto);
            });

            $('#LOAExpiryDate').datetimepicker({
                format: 'L'
            });
            $('#SBExpiryDate').datetimepicker({
                format: 'L'
            });
            $('#DateFrom').datetimepicker({
                format: 'L'
            });
            $('#DateTo').datetimepicker({
                format: 'L'
            });

            $.validator.setDefaults({
                submitHandler: function () {
                    if ($('#txtID').val() == '') {
                        AddLOA();
                    }
                    else {
                        UpdateLOA();
                    }
                }
            });
            $('#form1').validate({
                rules: {
                    LOANO: {
                        required: true,
                    },
                    LOAEXP: {
                        required: true,
                    },
                    DESC: {
                        required: true,
                    },
                    QTY: {
                        required: true,
                    },
                    UM: {
                        required: true,
                    },
                    AMT: {
                        required: true,
                    },
                },
                messages: {
                    LOANO: {
                        required: "Please enter LOA.",
                    },
                    LOAEXP: {
                        required: "Please enter LOA Expiry Date.",
                    },
                    DESC: {
                        required: "Please enter LOA Description.",
                    },
                    QTY: {
                        required: "Please enter LOA Quantity Limit.",
                    },
                    UM: {
                        required: "Please enter LOA Unit of Measurement.",
                    },
                    AMT: {
                        required: "Please enter LOA Amount Limit",
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
        });

        $(document).on('click', 'button', function (e) {
            var elem = $(this);
            if (elem.hasClass('btn-update-row')) {
                $('#selectSupplier').focus();
                var data = LOATable.row(elem.parents('tr')).data();
                var ID = data[Object.keys(data)[0]];
                var SUPPLIER = data[Object.keys(data)[1]];
                if (SUPPLIER == '') {
                    SUPPLIER = '0'
                }
                var DIVISION = data[Object.keys(data)[3]];
                if (DIVISION == '') {
                    DIVISION = '0'
                }
                var LOANO = data[Object.keys(data)[4]];
                var LOAEXP = data[Object.keys(data)[5]];
                var SBNO = data[Object.keys(data)[6]];
                var SBEXP = data[Object.keys(data)[7]];
                var DESC = data[Object.keys(data)[8]];
                var QTYLIMIT = data[Object.keys(data)[9]];
                var UM = data[Object.keys(data)[10]];
                var AMTLIMIT = data[Object.keys(data)[11]];

                $('#txtID').val(ID);
                $('#selectSupplier').val(SUPPLIER).trigger('change');
                $('#selectDivision').val(DIVISION).trigger('change');
                $('#txtLOANo').val(LOANO);
                $('#txtLOAExpiryDate').val(moment(LOAEXP).format('L'));
                $('#txtSuretyBondNo').val(SBNO);
                $('#txtSBExpiryDate').val(moment(SBEXP).format('L'));
                $('#txtDescription').val(DESC);
                $('#txtQtyLIMIT').val(QTYLIMIT);
                $('#txtUM').val(UM);
                $('#txtAmtLimit').val(AMTLIMIT);
            }
            if (elem.hasClass('btn-delete-row')) {
                var data = LOATable.row(elem.parents('tr')).data();
                var ID = data[Object.keys(data)[0]];
                if (confirm("Are you sure you want to delete this data?")) {
                    LOATable.row(elem.parents('tr')).remove().draw();
                    DeleteLOA(ID);
                }
            }
        });

        function GetLOA() {
            $.ajax({
                url: "LOAs.aspx/GetLOA",
                type: "POST",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('.overlay').show();
                },
                complete: function () {
                    $('.overlay').hide();
                },
                success: function (e) {
                    var d = JSON.parse(e.d);
                    var btnEdit = '<button type="button" class="btn btn-sm btn-primary btn-update-row" title="Update"><i class="fas fa-edit"></i></button>';
                    var btnDelete = '<button type="button" class="btn btn-sm btn-danger btn-delete-row" title="Delete"><i class="fas fa-trash"></i></button>';
                    if (LOATable !== undefined && LOATable !== null) {
                        LOATable.clear().destroy();
                    }
                    LOATable = $("#tableLOA").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        responsive: false,
                        data: d,
                        columns: [
                            {
                                data: 'LOAID', title: 'Edit', render: function (e) {
                                    return btnEdit;
                                }
                            },
                            {
                                data: 'LOAID', title: 'Delete', render: function (e) {
                                    return btnDelete;
                                }
                            },
                            { data: "LOAID", title: 'ID', visible: false, searchable: false },
                            { data: "SUPPLIERID", title: 'Supplier ID', visible: false, searchable: false },
                            { data: "SUPPLIERNAME", title: 'Supplier' },
                            { data: "DIVISION", title: 'Division' },
                            { data: "LOANO", title: 'LOA' },
                            {
                                data: "LOAEXP", title: 'Expiry Date', render: function (e) {
                                    return moment(e).format('L');
                                }
                            },
                            { data: "SBNO", title: 'Surety Bond' },
                            {
                                data: "SBEXP", title: 'Expiry Date', render: function (e) {
                                    return moment(e).format('L');
                                }
                            },
                            { data: "DESCRIPTION", title: 'Description' },
                            { data: "QTYLIMIT", title: 'Qty Limit' },
                            { data: "UM", title: 'Unit of Measurement' },
                            { data: "AMTLIMIT", title: 'Amount Limit' },
                        ],
                        columnDefs: [
                            { className: "dt-nowrap", targets: "_all" }
                        ],
                        scrollY: "300px",
                        scrollX: true,
                        scrollCollapse: true,
                        order: [[4, 'asc']]
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetLOAInventory() {
            $.ajax({
                url: "LOAs.aspx/GetLOAInventory",
                type: "POST",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('.overlay').show();
                },
                complete: function () {
                    $('.overlay').hide();
                },
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (InventoryTable !== undefined && InventoryTable !== null) {
                        InventoryTable.clear().destroy();
                    }
                    InventoryTable = $("#tableInventory").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        responsive: false,
                        data: d,
                        select: { items: 'row', style: 'single' },
                        columns: [
                            { data: "LOAID", title: 'LOAID', visible: false, searchable: false },
                            { data: "SUPPLIERID", title: 'SUPPLIERID', visible: false, searchable: false },
                            { data: "SUPPLIERNAME", title: 'Supplier', visible: false, searchable: false },
                            { data: "DIVISION", title: 'Division', visible: false, searchable: false },
                            { data: "LOANO", title: 'LOA' },
                            { data: "DESCRIPTION", title: 'Description' },
                            { data: "QTYLIMIT", title: 'Qty Limit' },
                            { data: "QTYUSED", title: 'Qty Used' },
                            { data: "QTYLEFT", title: 'Qty Left' },
                            { data: "AMTLIMIT", title: 'Amount Limit' },
                            { data: "AMTUSED", title: 'Amount Used' },
                            { data: "AMTLEFT", title: 'Amount Left' },
                        ],
                        columnDefs: [
                            { className: "dt-nowrap", targets: "_all" },
                            {
                                title: "DESCRIPTION",
                                width: "20%",
                                data: null,
                                targets: 5,
                                render: function (data) {
                                    return data.substr(0, 30);
                                }
                            },
                        ],
                        scrollY: "300px",
                        scrollX: true,
                        scrollCollapse: true,
                        order: [[0, 'asc']]
                    });
                    InventoryTable.on('select', function () {
                        loaid = InventoryTable.rows({ selected: true }).data()[0]['LOAID'];
                        supplierid = InventoryTable.rows({ selected: true }).data()[0]['SUPPLIERID'];
                        division = InventoryTable.rows({ selected: true }).data()[0]['DIVISION'];
                        loano = InventoryTable.rows({ selected: true }).data()[0]['LOANO'];
                        datefrom = $('#selectDateFrom').val();
                        dateto = $('#selectDateTo').val();

                        GetLOAInventoryDetails(loaid, supplierid, division, loano, datefrom, dateto);
                        $('#modalInventoryDetails').modal('show');
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function AddLOA(callback) {
            var LOADetails = {};
            if ($('#selectSupplier').val() == '0') {
                LOADetails.SUPPLIERID = ''
            }
            else {
                LOADetails.SUPPLIERID = $('#selectSupplier').val();
            }
            if ($('#selectDivision').val() == '0') {
                LOADetails.DIVISION = ''
            }
            else {
                LOADetails.DIVISION = $('#selectDivision').val();
            }
            LOADetails.LOANO = $('#txtLOANo').val().toUpperCase();
            LOADetails.LOAEXP = $('#txtLOAExpiryDate').val();
            LOADetails.SBNO = $('#txtSuretyBondNo').val().toUpperCase();
            LOADetails.SBEXP = $('#txtSBExpiryDate').val();
            LOADetails.DESCRIPTION = $('#txtDescription').val().toUpperCase();
            LOADetails.QTYLIMIT = accounting.unformat($('#txtQtyLIMIT').val());
            LOADetails.UM = $('#txtUM').val().toUpperCase();
            LOADetails.AMTLIMIT = accounting.unformat($('#txtAmtLimit').val());
            $.ajax({
                url: "LOAs.aspx/AddLOA",
                method: "POST",
                data: JSON.stringify({ ld: LOADetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Item has been added successfully!');
                    GetLOA();
                    ClearFields();
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function UpdateLOA(callback) {
            var LOADetails = {};
            if ($('#selectSupplier').val() == '0') {
                LOADetails.SUPPLIERID = ''
            }
            else {
                LOADetails.SUPPLIERID = $('#selectSupplier').val();
            }
            LOADetails.LOAID = $('#txtID').val();
            if ($('#selectDivision').val() == '0') {
                LOADetails.DIVISION = ''
            }
            else {
                LOADetails.DIVISION = $('#selectDivision').val();
            }
            LOADetails.LOANO = $('#txtLOANo').val().toUpperCase();
            LOADetails.LOAEXP = $('#txtLOAExpiryDate').val();
            LOADetails.SBNO = $('#txtSuretyBondNo').val().toUpperCase();
            LOADetails.SBEXP = $('#txtSBExpiryDate').val();
            LOADetails.DESCRIPTION = $('#txtDescription').val().toUpperCase();
            LOADetails.QTYLIMIT = accounting.unformat($('#txtQtyLIMIT').val());
            LOADetails.UM = $('#txtUM').val().toUpperCase();
            LOADetails.AMTLIMIT = accounting.unformat($('#txtAmtLimit').val());
            $.ajax({
                url: "LOAs.aspx/UpdateLOA",
                method: "POST",
                data: JSON.stringify({ ld: LOADetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Item has been updated successfully!');
                    GetLOA();
                    ClearFields();
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function DeleteLOA(ID, callback) {
            var LOADetails = {};
            LOADetails.LOAID = ID;
            $.ajax({
                url: "LOAs.aspx/DeleteLOA",
                type: "POST",
                data: JSON.stringify({ ld: LOADetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Data Successfully Deleted!');
                    ClearFields();
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function GetDivisionList(callback) {
            $.ajax({
                type: "POST",
                url: "LOAs.aspx/GetDivisionList",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['Description'],
                            text: d[i]['Description']
                        }).appendTo($("#selectDivision"));
                    };
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function GetSupplierList(callback) {
            $.ajax({
                type: "POST",
                url: "LOAs.aspx/GetSupplierList",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['SUPPLIERID'],
                            text: d[i]['SUPPLIERNAME']
                        }).appendTo($("#selectSupplier"));
                    };
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function GetLOAInventoryDetails(loaid, supplierid, division, loano, datefrom, dateto, callback) {
            var LOAInventoryDetails = {};
            LOAInventoryDetails.LOAID = loaid;
            LOAInventoryDetails.SUPPLIERID = supplierid;
            LOAInventoryDetails.DIVISION = division;
            LOAInventoryDetails.LOANO = loano;
            LOAInventoryDetails.DATEFROM = datefrom;
            LOAInventoryDetails.DATETO = dateto;
            $.ajax({
                type: "POST",
                url: "LOAs.aspx/GetLOAInventoryDetails",
                data: JSON.stringify({ lid: LOAInventoryDetails }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('.overlay').show();
                },
                complete: function () {
                    $('.overlay').hide();
                },
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    if (SubTable !== undefined && SubTable !== null) {
                        SubTable.clear().destroy();
                    }
                    SubTable = $("#tableInventoryDetails").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: false,
                        buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                        data: d,
                        columns: [
                            { data: "LOAID", title: 'LOAID', visible: false, searchable: false },
                            { data: "DESCRIPTION", title: 'DESCRIPTION', visible: false, searchable: false },
                            { data: "SUPPLIERID", title: 'SUPPLIERID', visible: false, searchable: false },
                            { data: "SUPPLIERNAME", title: 'SUPPLIERNAME', visible: false, searchable: false },
                            { data: "DIVISION", title: 'DIVISION', visible: false, searchable: false },
                            { data: "LOANO", title: 'LOANO', visible: false, searchable: false },
                            { data: "CONTROLNO", title: 'CONTROL NO.' },
                            { data: "ITEMDESCRIPTION", title: 'ITEM DESCRIPTION' },
                            { data: "UNITOFMEASUREMENT", title: 'UOM' },
                            { data: "QTYUSED", title: 'QTY. USED' },
                            { data: "AMTUSED", title: 'AMT. USED' },
                            {
                                data: "DATEOFTRANSFER", title: 'DATE OF TRANSFER', render: function (data) {
                                    return moment(data).format('L');
                                }
                            },
                        ],
                        dom: 'Bfrtip',
                        buttons: [
                            {
                                extend: 'excelHtml5',
                                filename: loano + " (" + (moment().format("YYYYMMDDhhmmss")) + ")",
                                title: '',
                                exportOptions: {
                                    columns: ':visible'
                                }
                            }
                        ],
                        order: [[6, 'asc']],
                        columnDefs: [
                            { className: "dt-nowrap", targets: "_all" },
                            {
                                targets: 6,
                                render: function (data, type, row, meta) {
                                    return '<a href="FarmOutRequestForm.aspx?controlno=' + data + '" style="font-weight: bold; color: #cc0000">' + data + '</a>';
                                },
                            },
                        ],
                    });
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }

        function ClearFields() {
            $('#txtID').val('');
            $('#selectSupplier').val('0').trigger('change');
            $('#selectDivision').val('0').trigger('change');
            $('#txtLOANo').val('');
            $('#txtLOAExpiryDate').val('');
            $('#txtSuretyBondNo').val('');
            $('#txtSBExpiryDate').val('');
            $('#txtDescription').val('');
            $('#txtQtyLIMIT').val('');
            $('#txtUM').val('');
            $('#txtAmtLimit').val('');
        }
    </script>
</asp:Content>

