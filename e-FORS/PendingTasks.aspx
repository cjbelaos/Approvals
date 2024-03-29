﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PendingTasks.aspx.cs" Inherits="PendingTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Tasks</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Pending Tasks</li>
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
                    <h3 class="card-title">Pending Tasks</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tablePendingTasks" class="table table-bordered table-striped table-sm">
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
        var MainTable;
        $(document).ready(function () {
            GetSession(function (e) {
                Session = e;
                var user_id = Session["UserID"];
                console.log(user_id);
                GetPendingTasks(user_id);
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
                        console.log(Session);
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
            function GetPendingTasks(user_id, callback) {
                $.ajax({
                    url: "PendingTasks.aspx/GetPendingTasks",
                    type: "POST",
                    data: JSON.stringify ({ user: user_id }),
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
                        MainTable = $("#tablePendingTasks").DataTable({
                            paging: true,
                            lengthChange: true,
                            ordering: true,
                            info: true,
                            autoWidth: true,
                            responsive: true,
                            buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                            data: d,
                            columns: [
                                { data: "CONTROLNO", title: 'Control No.' },
                                { data: "SUPPLIER", title: 'Supplier' },
                                { data: "ADDRESS", title: 'Address' },
                                { data: "PURPOSE", title: 'Purpose' },
                                { data: "DIVISION", title: 'Division' },
                                { data: "PROCESSNAME", title: 'Task' },
                                { data: "ASSIGNEDUSERNAME", title: 'Assigned' },
                                {
                                    data: "ASSIGNEDDATE", title: 'Assigned Date', render: function (e) {
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

