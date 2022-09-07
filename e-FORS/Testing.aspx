<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Testing.aspx.cs" Inherits="Testing" %>

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

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tableFinished8112Tasks" class="table table-bordered table-striped table-sm">
                    </table>
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
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 70px">Close</button>
                    <button type="button" class="btn btn-success btn-sm" style="width: 70px">Proceed</button>
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
        var MainTable;
        $(document).ready(function () {
            GetFinished8112Tasks();
        });

        function GetFinished8112Tasks(callback) {
            $.ajax({
                url: "Testing.aspx/GetFinished8112Tasks",
                type: "POST",
                data: "{}",
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
                    MainTable = $("#tableFinished8112Tasks").DataTable({
                        dom: 'Bfrtip',
                        select: {
                            style: 'multi'
                        },
                        paging: false,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: true,
                        buttons: [
                            {
                                text: 'Print',
                                action: function () {
                                    let rows = MainTable.rows({ selected: true }).indexes();
                                    var x = MainTable.cells(rows, 0).data().toArray().toString();
                                    console.log(x);
                                    $('#modalPrint').modal('show');
                                }
                            }
                        ],
                        data: d,
                        columns: [
                            { data: "CONTROLNO", title: 'Control No.' },
                            { data: "Division", title: 'Division' },
                            { data: "LOANO", title: 'LOA No.' },
                            { data: "SupplierName", title: 'Supplier' },
                            { data: "DestinationAddress", title: 'Address' },
                            { data: "PurposeOfItem", title: 'Purpose' },
                            { data: "DOCUMENTFORMAT", title: 'Format' },
                            {
                                data: "UPDATEDDATE", title: 'Approved Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                        ],
                    });
                    MainTable.on('select', function () {
                        //let controlno = MainTable.rows({ selected: true }).data()[0]['CONTROLNO'];
                        //// now do what you need to do wht the row data
                        //console.log(controlno);
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

    </script>
</asp:Content>
