<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CancelledTasks.aspx.cs" Inherits="CancelledTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" Runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Tasks</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Cancelled Tasks</li>
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
                    <h3 class="card-title">Cancelled Tasks</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tableCancelledTasks" class="table table-bordered table-striped table-sm" style="white-space: nowrap; font-size: 13px; width: 1020px;">
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
<asp:Content ID="Content3" ContentPlaceHolderID="script" Runat="Server">
    <script type="text/javascript">
        var MainTable;
        $(document).ready(function () {
            GetCancelledTasks();
        });

        function GetCancelledTasks(callback) {
            $.ajax({
                url: "CancelledTasks.aspx/GetCancelledTasks",
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
                    MainTable = $("#tableCancelledTasks").DataTable({
                        fixedHeader: true,
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: false,
                        data: d,
                        columns: [
                            { data: "CONTROLNO", title: 'Control No.' },
                            { data: "SupplierName", title: 'Supplier' },
                            { data: "DestinationAddress", title: 'Address' },
                            { data: "PurposeOfItem", title: 'Purpose' },
                            { data: "DOCUMENTFORMAT", title: 'Format' },
                            { data: "APPROVEDBY", title: 'Approver' },
                            {
                                data: "APPROVEDDATE", title: 'Approved Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                            { data: "CREATEDBY", title: 'Creator' },
                            {
                                data: "CREATEDDATE", title: 'Created Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                            { data: "PAGEID", title: 'Page', visible: false, searchable: false },
                        ],
                        order: [[8, 'desc']],
                        columnDefs: [
                            {
                                targets: 0,
                                render: function (data, type, row, meta) {
                                    return '<a href="' + row["PAGEID"] + '?controlno=' + data + '" style="font-weight: bold; color: #cc0000">' + data + '</a>';
                                },
                            },
                        ],
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

    </script>
</asp:Content>

