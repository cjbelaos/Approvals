<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LOA.aspx.cs" Inherits="LOA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
    <link href="AdminLTE-3.2.0/plugins/fonts/Poppins.css" rel="stylesheet" />
    <link href="AdminLTE-3.2.0/plugins/handsontable/css/handsontable.full.min.css" rel="stylesheet" />
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

        .custom-table thead th {
            background-color: #d7f1e1;
            font-weight: bold;
            font-family: 'Poppins', sans-serif;
            align-content: flex-start;
        }

        .custom-table tbody tr {
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
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
                                <label for="tbSection">Section</label>
                                <select id="selectSection" class="form-control select2" style="width: 100%">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Supplier</label>
                                <select id="selectSupplier" class="form-control select2" style="width: 100%">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>LOA No.</label>
                                <select id="selectLOA" class="form-control select2" style="width: 100%">
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

                    <div class="row">
                        <div class="col">
                            <button type="button" id="btnSearch" class="btn btn-primary"><i class="fas fa-search"></i>&nbsp;Search</button>
                            <button type="button" id="btnClear" class="btn btn-warning"><i class="fas fa-ban"></i>&nbsp;Clear</button>

                        </div>
                    </div>
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <button type="button" id="btnExport" class="btn btn-success btn-sm mb-2"><i class="fas fa-file-export"></i>&nbsp;Export</button>
                    <div id="MyTable"></div>
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

    <script src="AdminLTE-3.2.0/plugins/handsontable/js/handsontable.full.min.js"></script>
    <script src="AdminLTE-3.2.0/plugins/exceljs/js/exceljs.min.js"></script>
    <script src="AdminLTE-3.2.0/plugins/xlsx/xlsx.full.min.js"></script>
    <script type="text/javascript">

        var DTForExport = null;

        //Initialize Select2 Elements
        $('.select2').select2()

        //Date picker
        $('#DateFrom').datetimepicker({
            format: 'L',
        });
        $('#DateTo').datetimepicker({
            format: 'L'
        });

        function GetLOAReport(callback) {
            var ReportDetails = {};
            ReportDetails.Supplier = $('#selectSupplier').val();
            ReportDetails.Section = $('#selectSection').val();
            ReportDetails.DateFrom = $('#txtDateFrom').val();
            ReportDetails.DateTo = $('#txtDateTo').val();
            ReportDetails.LOANo = $('#selectLOA').val();
            $.ajax({
                url: 'LOA.aspx/GetLOAReport',
                type: 'post',
                data: JSON.stringify({ rd: ReportDetails }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
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
                },
                error: function (err) {
                    var d = err.responseJSON;
                    MessageBox(d.ExceptionType, '<p>' + d.Message + '</p><pre style="max-width: 100%;max-height: 300px;overflow:auto;">' + d.StackTrace + '</pre>');
                }
            });
        }

        function DrawTable(data) {
            if (data.length > 0) {
                $("#btnExport").prop("hidden", false);
                columnNames = Object.keys(data[0]);
                var columns = [];

                for (var i in columnNames) {
                    columns.push(columnNames[i]);
                }

                let d = [data.length];
                let xColWidth = [columns.length];
                let colType = [columns.length];
                for (var i in data) {
                    let e = [columns.length];
                    for (var j in columns) {
                        var colName = columns[j];
                        xColWidth[j] = 100;
                        e[j] = data[i][colName];
                        colType[j] = { type: 'text', readOnly: true, wordWrap: false };
                        if (['CONTROLNO'].includes(colName)) {
                            colType[j] = { renderer: 'html', wordWrap: false };
                        }
                    }
                    d[i] = e;
                }
                var config = {
                    data: d,
                    colHeaders: columns,
                    columns: colType,
                    csvHeaders: true,
                    tableOverflow: true,
                    height: '300px',
                    width: '100%',
                    dropdownMenu: true,
                    stretchH: 'all',
                    className: 'custom-table',
                    filters: true,
                    filteringCaseSensitive: true,
                    licenseKey: 'non-commercial-and-evaluation'
                };
                MyTable = new Handsontable(document.getElementById("MyTable"), config);
            }
            else {
                alert("No data has been found!");
                $("#btnExport").prop("hidden", true);
                if (MyTable !== null) {
                    MyTable.destroy();
                    var config = {
                        data: [],
                        licenseKey: 'non-commercial-and-evaluation'
                    };
                    MyTable = new Handsontable(document.getElementById("MyTable"), config);
                }
            }
        }

        function GetLOA(dtLOA) {
            for (var i in dtLOA) {
                $('<option/>', {
                    value: dtLOA[i]['LOANO'],
                    text: dtLOA[i]['LOANO']
                }).appendTo($("#selectLOA"));
            }
        }

        function Export(callback) {
            var loano = $('#selectLOA').val();
            var currentDate = new Date();
            var filename = loano + '(' + moment(currentDate).format('YYYYMMDDhhmmss') + ').xlsx';

            var data = DTForExport;
            for (var i = 0; i < data.length; i++) {
                data[i]['DATEOFTRANSFER'] = moment(data[i]['DATEOFTRANSFER']).format("MM/DD/YYYY");
            }

            var result = data.reduce((acc, obj) => {
                acc[obj.TYPEOFITEM] = acc[obj.TYPEOFITEM] || [];
                acc[obj.TYPEOFITEM].push(obj);
                return acc;
            }, {});
            var columns = [];

            var headers = MyTable.getColHeader();

            for (var i in headers) {
                columns[columns.length] = {
                    field: headers[i],
                    title: headers[i]
                };
            }

            //Create workbook and worksheet
            var workbook = new ExcelJS.Workbook();
            workbook.creator = 'ISD';
            workbook.lastModifiedBy = 'ISD';
            workbook.created = new Date();
            workbook.company = "EPPI";
            workbook.title = "LOA Report";
            workbook.modified = new Date();
            workbook.lastPrinted = new Date();
            workbook.properties.date1904 = true;
            // Force workbook calculation on load
            workbook.calcProperties.fullCalcOnLoad = true;
            workbook.views = [
                {
                    x: 0, y: 0, width: 10000, height: 20000,
                    firstSheet: 0, activeTab: 1, visibility: 'visible'
                }
            ]

            for (var i in result) {
                var data = result[i];
                i = i.replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '-');
                var worksheet = workbook.addWorksheet(i);
                //index for row and column of ExcelJS starts with 1
                var rowIndex = 1;
                var row = worksheet.getRow(rowIndex);
                //initialize the table header
                for (var i in columns) {
                    row.getCell(parseInt(i) + 1).value = columns[i].title;
                }

                var ranges = selectRange(worksheet, 1, 1, 1, columns.length);
                ranges.forEach(function (range) {
                    range.style = {
                        font: { bold: true }
                    };
                    range.alignment = { vertical: 'middle', horizontal: 'left' };
                });
                //loop the data
                rowIndex = 0;
                var lastCell = null;
                for (var i in data) {
                    if (rowIndex == 0) {
                        rowIndex = 2;
                    } else {
                        rowIndex++;
                    }
                    row = worksheet.getRow(rowIndex);

                    //var ctr = 0;
                    for (var j in columns) {
                        //var NumericColumns = ['EPPISTCK', 'EPPIDOS', 'DOSLEVEL', 'SUPPLIERSTCK', 'DOSOVERALL', 'TOTALSTCK'];
                        //var Title = columns[j].title;
                        var val = data[i][columns[j].field];
                        lastCell = row.getCell(parseInt(j) + 1);
                        //if (NumericColumns.includes(Title)) {
                        //    lastCell.numFmt = NumberFormatString;
                        //}
                        lastCell.value = val;
                    }
                }
            }
            const buffer = workbook.xlsx.writeBuffer();
            //for downloading the file
            workbook.xlsx.writeBuffer().then(result => {
                const blob = new Blob([result], { type: this.blobType });
                saveAs(blob, filename);
                if (callback !== undefined) {
                    callback();
                }
            });
        }

        function selectRange(sheet, startRow, startColumn, endRow = -1, endColumn = -1) {
            endRow = endRow == -1 ? startRow : endRow;
            endColumn = endColumn == -1 ? startColumn : endColumn;
            const cells = [];
            for (let y = startRow; y <= endRow; y++) {
                const row = sheet.getRow(y);

                for (let x = startColumn; x <= endColumn; x++) {
                    cells.push(row.getCell(x));
                }
            }

            return cells;
        };

        function Clear() {
            $('#selectSection').val('').trigger('change');
            $('#selectSupplier').val('').trigger('change');
            $('#selectLOA').val('').trigger('change');
            $('#txtDateFrom').val('');
            $('#txtDateTo').val('');
        }

        function MessageBox(title, message) {
            var modal = $('<div/>', {
                id: 'MessageBox', class: "modal"
            }).appendTo('body');
            $('<h3/>', { text: title }).appendTo(modal);
            $('<div/>', {
                html: message
            }).appendTo(modal);
            modal.modal({
                escapeClose: false,
                clickClose: false,
                show: true
            });
            modal.on('hidden.bs.modal', function () {
                modal.remove();
            });
        }

        //window.onerror = function myErrorHandler(d, url, lineNumber) {
        //    console.log(d);
        //    //MessageBox(d.ExceptionType, '<p>' + d.Message + '</p><pre style="max-width: 100%;max-height: 300px;overflow:auto;">' + d.StackTrace + '</pre>');
        //    alert("Error occured: " + d);//or any message
        //    return false;
        //}

        window.onerror = function myErrorHandler(errorMsg, url, lineNumber) {
            Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: errorMsg,
            })
            return false;
        }



        $(function () {

            GetLOAReport(function (e) {
                data = e['Table'];
                forExport = e['Table'];
                for (var i = 0; i < data.length; i++) {
                    data[i]['DATEOFTRANSFER'] = moment(data[i]['DATEOFTRANSFER']).format("MM/DD/YYYY");
                    data[i]['CONTROLNO'] = '<a href="FarmOutDocuments.aspx?controlno=' + data[i]["CONTROLNO"] + '" style="font-weight: bold; color: #0d6efd">' + data[i]["CONTROLNO"] + '</a>';
                }
                DrawTable(data);

                var dtLOA = e['Table1'];
                var dtSupplier = e['Table2'];
                var dtSection = e['Table3'];

                DTForExport = e['Table4'];

                for (var i in dtLOA) {
                    $('<option/>', {
                        value: dtLOA[i]['LOANO'],
                        text: dtLOA[i]['LOANO'],
                    }).appendTo($('#selectLOA'));
                }

                for (var i in dtSupplier) {
                    $('<option/>', {
                        value: dtSupplier[i]['SUPPLIERID'],
                        text: dtSupplier[i]['SUPPLIER'],
                    }).appendTo($('#selectSupplier'));
                }

                for (var i in dtSection) {
                    $('<option/>', {
                        value: dtSection[i]['SECTION'],
                        text: dtSection[i]['SECTION'],
                    }).appendTo($('#selectSection'));
                }

                //arrLOA = [];
                //for (var i in data) {
                //    arrLOA.push(data[i]['LOANO']);
                //}
                //var dtLOA = arrLOA.filter(function (itm, i, a) {
                //    return i == a.indexOf(itm);
                //});
                //for (var i = 0; i < dtLOA.length; i++) {
                //    $('<option/>').val(dtLOA[i]).html(dtLOA[i]).appendTo('#selectLOA');
                //}

                //arrSupplier = [];
                //for (var i in data) {
                //    arrSupplier.push(data[i]['SUPPLIER']);
                //}
                //var dtSupplier = arrSupplier.filter(function (itm, i, a) {
                //    return i == a.indexOf(itm);
                //});
                //console.log(dtSupplier);
                //for (var i = 0; i < dtSupplier.length; i++) {
                //    $('<option/>').val(dtSupplier[i]).html(dtSupplier[i]).appendTo('#selectSupplier');
                //}

            })



            $('#btnSearch').click(function () {
                GetLOAReport(function (e) {
                    data = e['Table'];
                    DTForExport = e['Table4'];
                    for (var i = 0; i < data.length; i++) {
                        data[i]['DATEOFTRANSFER'] = moment(data[i]['DATEOFTRANSFER']).format("MM/DD/YYYY");
                        data[i]['CONTROLNO'] = '<a href="FarmOutDocuments.aspx?controlno=' + data[i]["CONTROLNO"] + '" style="font-weight: bold; color: #0d6efd">' + data[i]["CONTROLNO"] + '</a>';
                    }
                    DrawTable(data);
                })
            });

            $('#btnExport').click(function () {
                Export();
            });

            $('#btnClear').click(function () {
                Clear();
            });


        });

    </script>
</asp:Content>

