<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Testing.aspx.cs" Inherits="Testing" %>

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
                        <li class="breadcrumb-item active">All Tasks</li>
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
                    <h3 class="card-title">All Tasks</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body">
                    <table id="tableAllTasks" class="table table-bordered table-striped">
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
            GetAllTasks();
        });
        function GetAllTasks(callback) {
            $.ajax({
                url: "Testing.aspx/GetAllTasks",
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
                    MainTable = $("#tableAllTasks").DataTable({
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
                            { data: "DIVISION", title: 'Division' },
                            { data: "PROCESSNAME", title: 'Task' },
                            { data: "ASSIGNEDUSERNAME", title: 'Assigned' },
                            { data: "ASSIGNEDDATE", title: 'Assigned Date', render: function (e) {
                                    return moment(e).format("L");
                                }, },
                            { data: "PAGEID", title: 'Page', visible: false, searchable: false },
                        ],
                        order: [[1, 'asc']],
                        columnDefs: [
                            {
                                targets: 0,
                                render: function (data, type, row, meta) {
                                    //return '<a href="' + row.PAGEID + '?controlno=' + data + '">' + data + '</a>';
                                    return '<a href="FODocuments.aspx?controlno=' + data + '">' + data + '</a>';
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

