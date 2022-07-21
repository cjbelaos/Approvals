<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LOAs.aspx.cs" Inherits="LOAs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
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
                        <div class="col-md-3">
                            <div class="form-group">
                                <label>Division</label>
                                <select name="DIVISION" id="selectDivision" class="form-control select2">
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

                <div class="card-body">
                    <table id="tableLOA" class="table table-bordered table-striped" style="width: 100%">
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
                    <table id="tableInventory" class="table table-bordered table-striped" style="width: 100%">
                    </table>
                </div>
                <div class="card-footer">
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        $('.select2').select2();

        var LOATable;
        var InventoryTable;
        let BtnClear = $('#btnClear');
        $(document).ready(function () {
            GetLOA();
            GetDivision();

            BtnClear.on('click', function () {
                ClearFields();
            })

            $('#LOAExpiryDate').datetimepicker({
                format: 'L'
            });
            $('#SBExpiryDate').datetimepicker({
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
                    DIVISION: {
                        required: true,
                    },
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
                    DIVISION: {
                        required: "Please select DIVISION.",
                    },
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
                var data = LOATable.row(elem.parents('tr')).data();
                console.log(data);
                var ID = data[Object.keys(data)[0]];
                var DIVISION = data[Object.keys(data)[1]];
                if (DIVISION == '') {
                    DIVISION = '0'
                }
                var LOANO = data[Object.keys(data)[2]];
                var LOAEXP = data[Object.keys(data)[3]];
                var SBNO = data[Object.keys(data)[4]];
                var SBEXP = data[Object.keys(data)[5]];
                var DESC = data[Object.keys(data)[6]];
                var QTYLIMIT = data[Object.keys(data)[7]];
                var UM = data[Object.keys(data)[10]];
                var AMTLIMIT = data[Object.keys(data)[11]];

                $('#txtID').val(ID);
                $('#selectDivision').val(DIVISION).trigger('change');
                $('#txtLOANo').val(LOANO);
                $('#txtLOAExpiryDate').val(LOAEXP);
                $('#txtSuretyBondNo').val(SBNO);
                $('#txtSBExpiryDate').val(SBEXP);
                $('#txtDescription').val(DESC);
                $('#txtQtyLIMIT').val(QTYLIMIT);
                $('#txtUM').val(UM);
                $('#txtAmtLimit').val(AMTLIMIT);
            }
            if (elem.hasClass('btn-delete-row')) {
                var data = MainTable.row(elem.parents('tr')).data();
                var ID = data[Object.keys(data)[0]];
                console.log(ID);
                if (confirm("Are you sure you want to delete this data?")) {
                    MainTable.row(elem.parents('tr')).remove().draw();
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
                            { data: "LOAID", title: 'ID', visible: false, searchable: false },
                            { data: "DIVISION", title: 'Division' },
                            { data: "LOANO", title: 'LOA' },
                            { data: "LOAEXP", title: 'Expiry Date' },
                            { data: "SBNO", title: 'Surety Bond' },
                            { data: "SBEXP", title: 'Expiry Date' },
                            { data: "DESCRIPTION", title: 'Description' },
                            { data: "QTYLIMIT", title: 'Qty Limit' },
                            { data: "UM", title: 'Unit of Measurement' },
                            { data: "AMTLIMIT", title: 'Amount Limit' },
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
                        ]
                    });
                    InventoryTable = $("#tableInventory").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        responsive: false,
                        data: d,
                        columns: [
                            { data: "DIVISION", title: 'Division' },
                            { data: "LOANO", title: 'LOA' },
                            { data: "QTYLIMIT", title: 'Qty Limit' },
                            { data: "QTYUSED", title: 'Qty Used' },
                            { data: "QTYLEFT", title: 'Qty Left' },
                            { data: "AMTLIMIT", title: 'Amount Limit' },
                            { data: "AMTUSED", title: 'Amount Used' },
                            { data: "AMTLEFT", title: 'Amount Left' },
                        ]
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function AddLOA(callback) {
            var LOADetails = {};
            if ($('#selectDivision').val() == '0') {
                LOADetails.DIVISION = ''
            }
            else {
                LOADetails.DIVISION = $('#selectDivision').val();
            }
            LOADetails.LOANO = $('#txtLOANo').val();
            LOADetails.LOAEXP = $('#txtLOAExpiryDate').val();
            LOADetails.SBNO = $('#txtSuretyBondNo').val();
            LOADetails.SBEXP = $('#txtSBExpiryDate').val();
            LOADetails.DESCRIPTION = $('#txtDescription').val();
            LOADetails.QTYLIMIT = accounting.unformat($('#txtQtyLIMIT').val());
            LOADetails.UM = $('#txtUM').val();
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
            LOADetails.LOAID = $('#txtID').val();
            if ($('#selectDivision').val() == '0') {
                LOADetails.DIVISION = ''
            }
            else {
                LOADetails.DIVISION = $('#selectDivision').val();
            }
            LOADetails.LOANO = $('#txtLOANo').val();
            LOADetails.LOAEXP = $('#txtLOAExpiryDate').val();
            LOADetails.SBNO = $('#txtSuretyBondNo').val();
            LOADetails.SBEXP = $('#txtSBExpiryDate').val();
            LOADetails.DESCRIPTION = $('#txtDescription').val();
            LOADetails.QTYLIMIT = accounting.unformat($('#txtQtyLIMIT').val());
            LOADetails.UM = $('#txtUM').val();
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

        function GetDivision(callback) {
            $.ajax({
                type: "POST",
                url: "LOAs.aspx/GetDivision",
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

        function ClearFields() {
            $('#txtID').val('');
            $('#selectDivision').val(0).trigger('change');
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

