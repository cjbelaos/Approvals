<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FinishedTasks.aspx.cs" Inherits="FinishedTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Tasks</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Finished Tasks</li>
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
                    <h3 class="card-title">Finished Tasks</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <div class="row">
                        <div class="col-md-3">
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Control No.</label>
                                <input type="text" id="txtControlNo" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>

                    <table id="tableFinishedTasks" class="table table-bordered table-striped table-sm" style="white-space: nowrap; font-size: 13px; width: 1020px;">
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
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var MainTable;
        $(document).ready(function () {
            GetSession(function (e) {
                Session = e;
                var user_id = Session["UserID"];
                console.log(user_id);
                CheckAuthorization(user_id, function (e) {
                    isAuthorized = e;
                    console.log(isAuthorized);
                    if (isAuthorized == false) {
                        GetFinishedTasksPerSection(user_id);
                    }
                    else {
                        GetFinishedTasks();
                    }
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
                        //console.log(Session);
                        if (callback !== undefined) {
                            callback(d);
                        }
                    },
                    failure: function (err) {
                        ShowError(err);
                    },
                    error: function (error) {
                        ShowError(error);
                    }
                });
            }
            function CheckAuthorization(user_id, callback) {
                $.ajax({
                    type: "POST",
                    url: "FinishedTasks.aspx/CheckAuthorization",
                    data: JSON.stringify({ UserID: user_id }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (e) {
                        var d = JSON.parse(e.d);
                        console.log(d);
                        if (callback !== undefined) {
                            callback(d);
                        }
                    },
                    failure: function (err) {
                        ShowError(err);
                    },
                    error: function (error) {
                        ShowError(error);
                    }
                });
            }
            function GetFinishedTasks(callback) {
                $.ajax({
                    url: "FinishedTasks.aspx/GetFinishedTasks",
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
                        MainTable = $("#tableFinishedTasks").DataTable({
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
            function GetFinishedTasksPerSection(user_id, callback) {
                $.ajax({
                    url: "FinishedTasks.aspx/GetFinishedTasksPerSection",
                    type: "POST",
                    data: JSON.stringify({ UserID: user_id }),
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
                        MainTable = $("#tableFinishedTasks").DataTable({
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
        });
    </script>
</asp:Content>

