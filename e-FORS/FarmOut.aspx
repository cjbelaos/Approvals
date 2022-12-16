<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FarmOut.aspx.cs" Inherits="FarmOut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
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
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <div class="overlay"></div>

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Reports</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Farm Out</li>
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
                    <h3 class="card-title">LOA</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Section</label>
                                <select id="selectSection" class="form-control select2">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Supplier</label>
                                <select id="selectSupplier" class="form-control select2">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date From</label>
                                <div class="input-group date" id="DateFrom" data-target-input="nearest">
                                    <input type="text" id="txtDateFrom" class="form-control datetimepicker-input" data-target="#DateFrom" />
                                    <div class="input-group-append" data-target="#DateFrom" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Date To</label>
                                <div class="input-group date" id="DateTo" data-target-input="nearest">
                                    <input type="text" id="txtDateTo" class="form-control datetimepicker-input" data-target="#DateTo" />
                                    <div class="input-group-append" data-target="#DateTo" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-12">
                            <button type="button" id="btnFilter" class="btn btn-primary">Filter</button>
                            <button type="button" id="btnClear" class="btn btn-warning">Clear</button>
                        </div>
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->
                <div class="card-body">
                    <table id="table" class="table table-bordered table-hover table-sm">
                    </table>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                </div>

            </div>
            <!-- /.card -->
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        var table;
        //Initialize Select2 Elements
        $('.select2').select2()

        //Date picker
        $('#DateFrom').datetimepicker({
            format: 'L',
        });
        $('#DateTo').datetimepicker({
            format: 'L'
        });

        $(document).ready(function () {

            function ResetDataTables() {
                $('#table').empty();
                var table = $('#table').DataTable();
                table.clear().destroy();
                $('#table > thead').remove();
                $('#table > tbody').remove();
            }

            function GetFarmOut(section, supplier, datefrom, dateto, callback) {
                var ReportDetails = {};
                ReportDetails.Section = section;
                ReportDetails.Supplier = supplier;
                ReportDetails.DateFrom = datefrom;
                ReportDetails.DateTo = dateto;
                $.ajax({
                    url: "FarmOut.aspx/GetFarmOut",
                    type: "POST",
                    data: JSON.stringify({ rd: ReportDetails }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    beforeSend: function () {
                        $('.overlay').show();
                    },
                    complete: function () {
                        $('.overlay').hide();
                    },
                    success: function (e) {
                        var data = JSON.parse(e.d);
                        if (callback !== undefined) {
                            callback(data);
                        }
                        if (table !== undefined && table !== null) {
                            table.clear().destroy();
                        }
                        table = $('#table').DataTable({
                            paging: true,
                            filtering: true,
                            info: true,
                            searching: true,
                            data: data['Table'],
                            columns: [
                                { data: 'SECTION', title: 'Section', visible: false, searchable: true },
                                { data: 'SUPPLIERID', title: 'SupplierId', visible: false, searchable: true },
                                { data: 'CONTROLNO', title: 'Control No.' },
                                { data: 'REQUESTOR', title: 'Requestor' },
                                { data: 'BEARER', title: 'Bearer' },
                                { data: 'SUPPLIER', title: 'Supplier' },
                                { data: 'DESTINATION', title: 'Destination' },
                                { data: 'DESCRIPTION', title: 'Description' },
                                { data: 'QUANTITY', title: 'Qty.' },
                                { data: 'UM', title: 'U/M' },
                                { data: 'AMOUNT', title: 'Value' },
                                { data: 'PURPOSE', title: 'Purpose' },
                                {
                                    data: 'DATEREQUESTED', title: 'Date Requested', render: function (e) {
                                        if (e === null) {
                                            return '';
                                        } else {
                                            return moment(e).format("L");
                                        }
                                    }
                                },
                                {
                                    data: 'ACTUALDATEOFTRANSFER', title: 'Actual Date of Transfer', render: function (e) {
                                        if (e === null) {
                                            return '';
                                        } else {
                                            return moment(e).format("L");
                                        }
                                    }
                                },
                                {
                                    data: 'TARGETDATEOFRETURN', title: 'Target Date of Return', render: function (e) {
                                        if (e === null) {
                                            return '';
                                        } else {
                                            return moment(e).format("L");
                                        }
                                    }
                                },
                                { data: 'DOCUMENTFORMAT', title: 'DOCS Prepared' },
                                { data: 'PEZADOCUMENTNO', title: 'PEZA Document No.' },
                                { data: 'PEZAPERMITNO', title: 'PEZA Permit No.' },
                                { data: 'GATEPASSNO', title: 'Gatepass No.' },
                            ],
                            columnDefs: [
                                { className: "dt-nowrap", targets: "_all" }
                            ],
                            scrollY: "300px",
                            scrollX: true,
                            scrollCollapse: true,
                            order: [[2, 'asc']],
                            dom: 'Blfrtip',
                            buttons: [{
                                extend: 'excelHtml5',
                                title: '',
                                exportOptions: {
                                    columns: ':visible'
                                },
                            }],
                        });
                        if (data['Table1'].length > 0) {
                            for (var i in data['Table1']) {
                                $('<option/>', {
                                    value: data['Table1'][i]['SECTION'],
                                    text: data['Table1'][i]['SECTION']
                                }).appendTo($("#selectSection"));
                            }
                        }
                        if (data['Table2'].length > 0) {
                            for (var i in data['Table2']) {
                                $('<option/>', {
                                    value: data['Table2'][i]['ID'],
                                    text: data['Table2'][i]['ID'] + ' | ' + data['Table2'][i]['SUPPLIER']
                                }).appendTo($("#selectSupplier"));
                            }
                        }
                    },
                    error: function (err) {
                        console.log(err);
                    }
                })
            }

            GetFarmOut($('#selectSection').val(), $('#selectSupplier').val(), $('#txtDateFrom').val(), $('#txtDateTo').val());

            $('#btnFilter').click(function () {
                GetFarmOut($('#selectSection').val(), $('#selectSupplier').val(), $('#txtDateFrom').val(), $('#txtDateTo').val());
            });

            $('#btnClear').click(function () {
                $('#selectSection').val('').trigger('change');
                $('#selectSupplier').val('').trigger('change');
                $('#DateFrom').datetimepicker('clear');
                $('#DateTo').datetimepicker('clear');
                
            });
        });
    </script>
</asp:Content>

