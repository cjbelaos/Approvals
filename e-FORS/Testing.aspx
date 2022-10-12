<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Testing.aspx.cs" Inherits="Testing" %>

<asp:Content ID="style" ContentPlaceHolderID="style" runat="server">
    <style type="text/css">
        .printed {
            color: #fff;
            background-color: #17a2b8 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Tasks</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Finished 8112 Tasks</li>
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
                    <h3 class="card-title">Finished 8112 Tasks</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="selectLOANo">LOA No.</label>
                                <select id="selectLOANo" class="form-control select2" name="loano">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="selectSupplier">Supplier</label>
                                <select id="selectSupplier" class="form-control select2" name="supplier">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="selectPurpose">Purpose</label>
                                <select id="selectPurpose" class="form-control select2" name="purpose">
                                    <option selected value="">Choose...</option>
                                </select>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <button type="button" id="btnFilter" class="btn btn-primary"><i class="fas fa-filter"></i>&nbsp;Filter</button>
                    </div>
                </div>
                <div class="card-body" style="width: 100%; overflow: scroll">
                    <div class="row mb-4">
                        <button type="button" id="btnPrint" class="btn btn-primary"><i class="fas fa-print"></i>&nbsp;Print</button>
                    </div>
                    <div class="row">
                        <table id="tableFinished8112Tasks" class="table table-bordered table-striped table-sm">
                        </table>
                    </div>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                </div>

            </div>
            <!-- /.card -->
        </div>
    </section>

    <div class="modal fade" id="modalPrint">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title">Print PEZA Form 8112</h3>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <input type="text" id="txtControlNos" class="form-control" hidden />
                        <div class="form-group">
                            <label>Date</label>
                            <div class="input-group date" id="Date" data-target-input="nearest">
                                <input type="text" id="txtDate" class="form-control datetimepicker-input" data-target="#Date" />
                                <div class="input-group-append" data-target="#Date" data-toggle="datetimepicker">
                                    <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                </div>
                            </div>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="selectControlNo">Control No.</label>
                            <select id="selectControlNo" class="form-control select2" name="controlno" multiple="multiple" disabled>
                            </select>
                        </div>
                        <!-- /.form-group -->
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 70px">Close</button>
                    <button id="btnProceed" type="button" class="btn btn-success btn-sm" style="width: 70px">Proceed</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        //Date picker
        $('#Date').datetimepicker({
            format: 'L'
        });

        //Initialize Select2 Elements
        $('.select2').select2()

        var MainTable;
        $(document).ready(function () {

            GetSession(function (e) {
                Session = e;
                var userid = Session["UserID"];
                console.log(userid);

                $(document).on('click', 'button', function (e) {
                    var elem = $(this);

                    if (elem.hasClass('btn-check-row')) {
                        elem.parents('tr').addClass('printed');
                        var data = MainTable.row(elem.parents('tr')).data();
                        var ControlNo = data[Object.keys(data)[0]];
                        MarkAsPrinted(ControlNo, userid);
                    }
                    if (elem.hasClass('btn-cross-row')) {
                        elem.parents('tr').removeClass('printed');
                        var data = MainTable.row(elem.parents('tr')).data();
                        console.log(data);
                        var ControlNo = data[Object.keys(data)[0]];
                        RemoveMarkAsPrinted(ControlNo, userid);
                    }
                    function MarkAsPrinted(controlno, userid, callback) {
                        $.ajax({
                            url: "Testing.aspx/MarkAsPrinted",
                            type: "POST",
                            data: JSON.stringify({ ControlNo: controlno, UserId: userid }),
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

                    function RemoveMarkAsPrinted(controlno, userid, callback) {
                        $.ajax({
                            url: "Testing.aspx/RemoveMarkAsPrinted",
                            type: "POST",
                            data: JSON.stringify({ ControlNo: controlno, UserId: userid }),
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
                });
            });
            GetFinished8112Tasks();
            GetFinished8112LOANOs();
            GetFinished8112Purpose();
            GetFinished8112Suppliers();

            //$('#selectLOANo').on('change', function () {
            //    GetFinished8112Tasks();
            //});

            //$('#selectSupplier').on('change', function () {
            //    GetFinished8112Tasks();
            //});

            //$('#selectPurpose').on('change', function () {
            //    GetFinished8112Tasks();
            //});
            $('#btnFilter').on('click', function () {
                GetFinished8112Tasks();
            });

            $('#btnPrint').on('click', function () {
                if ($("#txtControlNos").val() === '') {

                    var Toast = Swal.mixin({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 3000
                    });
                    Toast.fire({
                        icon: 'warning',
                        title: 'No control number selected. Please select control number(s) to proceed.'
                    })

                }
                else {
                    $('#modalPrint').modal('show');
                    $("#selectControlNo").empty();


                    var controlnos = $("#txtControlNos").val();
                    if (controlnos !== '') {
                        var ctrlno = controlnos.split(',');
                        console.log(ctrlno);
                        for (var i in ctrlno) {
                            console.log(ctrlno[i]);
                            $('<option/>', {
                                value: ctrlno[i],
                                text: ctrlno[i]
                            }).appendTo($("#selectControlNo"));
                        };
                        $("#selectControlNo").val(ctrlno).trigger('change');
                    }
                }
            });
            $('#btnProceed').on('click', function () {
                var controlnos = $('#txtControlNos').val();
                var loano = $('#selectLOANo').val();
                var supplier = $('#selectSupplier').val();
                var purpose = $('#selectPurpose').val();
                var date = $('#txtDate').val();

                console.log(controlnos);
                Print(controlnos, loano, supplier, purpose, date);
                window.location.replace('PEZA8112Print.aspx?controlno=' + controlnos);
            });
        });



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

        function Print(controlnos, loano, supplier, purpose, date, callback) {
            console.log(controlnos, loano, supplier, purpose, date);
            $.ajax({
                type: "POST",
                url: "8112.asmx/Print",
                data: JSON.stringify({ ControlNos: controlnos, LOANo: loano, Supplier: supplier, Purpose: purpose, Date: date }),
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

        function GetFinished8112Tasks(callback) {
            var loano = $('#selectLOANo').val();
            var supplier = $('#selectSupplier').val();
            var purpose = $('#selectPurpose').val();

            $.ajax({
                url: "Testing.aspx/GetFinished8112Tasks",
                type: "POST",
                data: JSON.stringify({ LOANO: loano, SUPPLIER: supplier, PURPOSE: purpose }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }

                    if (MainTable !== undefined && MainTable !== null) {
                        MainTable.clear().destroy();
                    }
                    var check = '<button type="button" class="btn btn-sm btn-success btn-check-row" title="Check"><i class="fas fa-check"></i></button>';
                    var cross = '<button type="button" class="btn btn-sm btn-danger btn-cross-row" title="Cross"><i class="fas fa-times"></i></button>';
                    MainTable = $("#tableFinished8112Tasks").DataTable({
                        //dom: 'Bfrtip',
                        select: {
                            style: 'multi',
                            selector: 'td:not(:nth-child(11), :nth-child(12))'
                        },
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: true,
                        //buttons: [
                        //    {
                        //        text: 'Print',
                        //        action: function () {
                        //            let rows = MainTable.rows({ selected: true }).indexes();
                        //            var x = MainTable.cells(rows, 0).data().toArray().toString();
                        //            console.log(x);
                        //            $('#modalPrint').modal('show');
                        //        }
                        //    }
                        //],
                        data: d,
                        columns: [
                            { data: "CONTROLNO", title: 'Control No.' },
                            { data: "DIVISION", title: 'Division' },
                            { data: "LOANO", title: 'LOA No.' },
                            { data: "SUPPLIER", title: 'Supplier' },
                            { data: "DESTINATION", title: 'Address' },
                            { data: "PURPOSE", title: 'Purpose' },
                            { data: "DOCUMENTFORMAT", title: 'Format' },
                            {
                                data: "APPROVEDDATE", title: 'Approved Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                            { data: "UPDATEDBY", title: 'Updated by' },
                            {
                                data: "UPDATEDDATE", title: 'Updated Date', render: function (e) {
                                    if (e === null || e === '') {
                                        return '';
                                    }
                                    else {
                                        return moment(e).format("L");
                                    }

                                },
                            },
                            {
                                data: "CONTROLNO", title: '', render: function (e) {
                                    return check;
                                }
                            },
                            {
                                data: "CONTROLNO", title: '', render: function (e) {
                                    return cross;
                                }
                            },
                            { data: "isPRINTED", title: 'isPrinted', visible: false, searchable: false },
                        ],
                        createdRow: function (row, data) {
                            if (data['isPRINTED'] === true) {
                                $(row).addClass('printed');
                            }

                        },
                    });
                    MainTable.on('select', function () {

                        $("#txtControlNos").empty();

                        let rows = MainTable.rows({ selected: true }).indexes();
                        var controlno = MainTable.cells(rows, 0).data().toArray().toString();
                        var loano = MainTable.cells(rows, 2).data().toArray().toString();
                        var supplier = MainTable.cells(rows, 3).data().toArray().toString();
                        var purpose = MainTable.cells(rows, 5).data().toArray().toString();

                        $("#selectLOANo").val(loano).trigger('change');
                        $("#selectSupplier").val(supplier).trigger('change');
                        $("#selectPurpose").val(purpose).trigger('change');

                        $("#txtControlNos").val(controlno);
                    });
                    MainTable.on('deselect', function () {

                        let rows = MainTable.rows({ selected: true }).indexes();
                        var controlno = MainTable.cells(rows, 0).data().toArray().toString();
                        var loano = MainTable.cells(rows, 2).data().toArray().toString();
                        var supplier = MainTable.cells(rows, 3).data().toArray().toString();
                        var purpose = MainTable.cells(rows, 5).data().toArray().toString();

                        $("#selectLOANo").val(loano).trigger('change');
                        $("#selectSupplier").val(supplier).trigger('change');
                        $("#selectPurpose").val(purpose).trigger('change');

                        $("#txtControlNos").val(controlno);
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetFinished8112LOANOs(callback) {
            $.ajax({
                type: "POST",
                url: "Testing.aspx/GetFinished8112LOANOs",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['LOANO'],
                            text: d[i]['LOANO']
                        }).appendTo($("#selectLOANo"));
                    };
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetFinished8112Purpose(callback) {
            $.ajax({
                type: "POST",
                url: "Testing.aspx/GetFinished8112Purpose",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['PURPOSE'],
                            text: d[i]['PURPOSE']
                        }).appendTo($("#selectPurpose"));
                    };
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function GetFinished8112Suppliers(callback) {
            $.ajax({
                type: "POST",
                url: "Testing.aspx/GetFinished8112Suppliers",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    for (var i in d) {
                        $('<option/>', {
                            value: d[i]['SUPPLIER'],
                            text: d[i]['SUPPLIER']
                        }).appendTo($("#selectSupplier"));
                    };
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
    </script>
</asp:Content>
