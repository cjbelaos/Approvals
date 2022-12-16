<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Testing.aspx.cs" Inherits="Testing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Reports</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">LOA</li>
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
                            <div runat="server" id="divLOA" class="form-group">
                                <label>LOA No.</label>
                                <select id="selectLOA" class="form-control select2">
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
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->
                <div class="card-body">
                    <table id="table_LOA" class="table table-bordered table-hover table-sm">
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
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">

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
            function GetLOA(callback) {
                $.ajax({
                    url: "Testing.aspx/GetLOA",
                    type: "POST",
                    data: "{}",
                    dataType: "json",
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
                })
            }

            //function ExportToExcel(columns, data, simulation) {
            //    //file initialization
            //    var workbook = new ExcelJS.Workbook();
            //    workbook.creator = 'ISD';
            //    workbook.lastModifiedBy = 'ISD';
            //    workbook.created = new Date();
            //    workbook.company = "EPPI";
            //    workbook.modified = new Date();
            //    workbook.lastPrinted = new Date();
            //    workbook.properties.date1904 = true;
            //    // Force workbook calculation on load
            //    workbook.calcProperties.fullCalcOnLoad = true;
            //    workbook.views = [
            //        {
            //            x: 0, y: 0, width: 10000, height: 20000,
            //            firstSheet: 0, activeTab: 1, visibility: 'visible'
            //        }
            //    ]
            //    var worksheet = workbook.addWorksheet('Parts Simulation');
            //    //index for row and column of ExcelJS starts with 1
            //    var rowIndex = 1;
            //    var row = worksheet.getRow(rowIndex);
            //    var row2, row3, colTotalStock, strFormula = "";
            //    //initialize the table header
            //    for (var i in columns) {
            //        row.getCell(parseInt(i) + 1).value = columns[i];
            //    }
            //    var ranges = selectRange(worksheet, 1, 1, 1, columns.length);
            //    ranges.forEach(function (range) {
            //        range.style = {
            //            font: { bold: true }
            //        };
            //        range.alignment = { vertical: 'middlen', horizontal: 'center' };
            //    });
            //    //loop the data
            //    rowIndex = 0;
            //    for (var i in data) {
            //        if (rowIndex == 0) {
            //            rowIndex = 2;
            //        } else {
            //            rowIndex += 3;
            //        }
            //        row = worksheet.getRow(rowIndex);
            //        row2 = worksheet.getRow(rowIndex + 1);
            //        row3 = worksheet.getRow(rowIndex + 2);
            //        var ctr = 0;
            //        var MaterialNumber = data[i]['MaterialNumber'];
            //        for (var j in data[i]) {
            //            row.getCell(ctr + 1).value = data[i][j];
            //            if (j != "Past" && !IsDate(j.replace(/_/g, '/').substr(1))) {
            //                row2.getCell(ctr + 1).value = data[i][j];
            //                row3.getCell(ctr + 1).value = data[i][j];
            //            }
            //            if (j == "PlanLogical") {
            //                row.getCell(ctr + 1).value = "EPPI PLAN";
            //                row2.getCell(ctr + 1).value = "SUPPLIER PLAN/DELIVERY";
            //                row3.getCell(ctr + 1).value = "END STOCKS";
            //            }
            //            if (simulation.hasOwnProperty(MaterialNumber)) {
            //                if (simulation[MaterialNumber].hasOwnProperty(j)) {
            //                    row2.getCell(ctr + 1).value = simulation[MaterialNumber][j];
            //                }
            //            } else {
            //                if (j == "Past" || IsDate(j.replace(/_/g, '/').substr(1))) {
            //                    row2.getCell(ctr + 1).value = 0;
            //                }
            //            }
            //            if (j == "TotalSTCK") {
            //                colTotalStock = ctr;
            //            }
            //            if (j == "Past") {
            //                strFormula = String.format("{0}{1}+{2}{3}-{4}{5}", ExcelColumn(colTotalStock), rowIndex + 1, ExcelColumn(ctr), rowIndex + 1, ExcelColumn(ctr), rowIndex);
            //                row3.getCell(ctr + 1).value = { formula: strFormula };
            //            }
            //            if (IsDate(j.replace(/_/g, '/').substr(1))) {
            //                strFormula = String.format("{0}{1}+{2}{3}-{4}{5}", ExcelColumn(ctr - 1), rowIndex + 2, ExcelColumn(ctr), rowIndex + 1, ExcelColumn(ctr), rowIndex);
            //                row3.getCell(ctr + 1).value = { formula: strFormula };
            //            }
            //            ctr++;
            //        }
            //    }
            //    //for downloading the file
            //    workbook.xlsx.writeBuffer().then(data => {
            //        const blob = new Blob([data], { type: this.blobType });
            //        saveAs(blob, "PartsSimulation.xlsx");
            //    });
            //}

            GetLOA(function (data) {
                if (data.length > 0) {
                    table = $('#table_LOA').DataTable({
                        paging: true,
                        filtering: true,
                        info: true,
                        searching: true,
                        data: data,
                        columns: [
                            { data: 'Section', title: 'Section', visible: false, searchable: true },
                            { data: 'LOANO', title: 'LOA No.', visible: false, searchable: true },
                            { data: 'TypeOfItem', title: 'Type of Item', visible: false, searchable: true },
                            {
                                data: 'ActualDateOfTransfer', title: 'Date', render: function (e) {
                                    return moment(e).format("L");
                                }
                            },
                            { data: 'SupplierName', title: 'Supplier', },
                            { data: 'ItemDescription', title: 'Description', },
                            { data: 'ItemCode', title: 'Item', },
                            { data: 'Quantity', title: 'Quantity', },
                            { data: 'Amount', title: 'Invoice Val.', },
                            { data: 'InvoiceNo', title: 'Invoice No.', },
                            { data: 'OriginOfItem', title: 'Origin', },
                            { data: 'PEZADOCUMENTNO', title: 'PEZA Doc. No.', },
                            { data: 'PEZAPERMITNO', title: 'PEZA Permit No.', },
                            { data: 'GATEPASSNO', title: 'Gatepass No.', },
                            { data: 'CONTROLNO', title: 'Control No.', },
                        ],
                        columnDefs: [
                            { className: "dt-nowrap", targets: "_all" }
                        ],
                        scrollY: "300px",
                        scrollX: true,
                        scrollCollapse: true,
                        order: [[2, 'asc']],
                        dom: 'Blfrtip',
                        //buttons: [{
                        //    extend: 'excelHtml5',
                        //    title: '',
                        //    exportOptions: {
                        //        columns: ':visible'
                        //    },
                        //    customize: function (xlsx, button, dt) {
                        //        console.log(dt.table);
                        //    },
                        //}],
                        buttons: [
                            {
                                text: 'Export',
                                action: function (e, dt, node, config) {
                                    console.log(table.data());
                                }
                            }
                        ],
                        initComplete: function () {
                            var table = this.api();
                            table.column(0).data().unique().sort().each(function (e) {
                                var section = table.column(0);
                                $('<option/>', {
                                    value: e,
                                    text: e
                                }).appendTo($("#selectSection")
                                    .on('change', function () {
                                        var val = $.fn.dataTable.util.escapeRegex(
                                            $(this).val()
                                        );

                                        section
                                            .search(val ? '^' + val + '$' : '', true, false)
                                            .draw();
                                    }));
                            });
                            table.column(1).data().unique().sort().each(function (e) {
                                var loa = table.column(1);
                                $('<option/>', {
                                    value: e,
                                    text: e
                                }).appendTo($("#selectLOA")
                                    .on('change', function () {
                                        var val = $.fn.dataTable.util.escapeRegex(
                                            $(this).val()
                                        );

                                        loa
                                            .search(val ? '^' + val + '$' : '', true, false)
                                            .draw();
                                    }));
                            });
                            table.column(4).data().unique().sort().each(function (e) {
                                var supplier = table.column(4);
                                $('<option/>', {
                                    value: e,
                                    text: e
                                }).appendTo($("#selectSupplier")
                                    .on('change', function () {
                                        var val = $.fn.dataTable.util.escapeRegex(
                                            $(this).val()
                                        );

                                        supplier
                                            .search(val ? '^' + val + '$' : '', true, false)
                                            .draw();
                                    }));
                            });
                        },
                    });
                }
            })

            // Custom filtering function which will search data in column four between two values
            $.fn.dataTable.ext.search.push(
                function (settings, data, dataIndex) {
                    var from = $('#txtDateFrom').val();
                    var to = $('#txtDateTo').val();
                    var date = data[3];
                    if ((from === '' && to === '') ||
                        (from === '' && date <= to) ||
                        (from <= date && to === '') ||
                        (from <= date && date <= to)
                    ) {
                        return true;
                    }
                    return false;
                }
            );

            $('#DateFrom, #DateTo').on("change.datetimepicker", function (e) {
                table.draw();
            });
        });
    </script>
</asp:Content>
