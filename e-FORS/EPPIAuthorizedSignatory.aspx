<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EPPIAuthorizedSignatory.aspx.cs" Inherits="EPPIAuthorizedSignatory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="sidebar" runat="server">
    <div class="sidebar">
        <!-- Sidebar user (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="image">
                <%--<img src="AdminLTE-3.2.0/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">--%>
            </div>
            <div class="info">
                <a href="#" class="d-block">
                    <asp:Label runat="server" ID="lblUserName"></asp:Label></a>

            </div>
        </div>

        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-edit"></i>
                        <p>
                            Forms
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="FarmOutRequestForm.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Farm-out Request Form</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="FarmOutDocuments.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Farm-out Documents</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-tasks"></i>
                        <p>
                            Tasks
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="MyTasks.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>My Tasks</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="FarmOutDocuments.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>All Tasks</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-alt"></i>
                        <p>
                            Reports
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Gatepass.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Gatepass</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="FarmOut.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Farm-Out</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="LOA.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>LOA</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-tools"></i>
                        <p>
                            Maintenance
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Supplier.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Supplier</p>
                            </a>
                        </li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="EPPIAuthorizedSignatory.aspx" class="nav-link active">
                                <i class="far fa-circle nav-icon"></i>
                                <p>EPPI Authorized Signatory</p>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
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

            <div class="card card-success">
                <div class="card-header">
                    <h3 class="card-title">EPPI Authorized Signatory</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>APO Account</label>
                                <input type="text" name="APO" id="txtAPO" class="form-control">
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Employee Name</label>
                                <input type="text" name="Name" id="txtName" class="form-control" disabled>
                            </div>
                            <!-- /.form-group -->
                        </div>
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-md-2">
                            <button type="submit" id="btnSave" class="btn btn-primary">Save</button>
                        </div>
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.card-body -->

                <div class="card-body">
                    <table id="tableName" class="table table-bordered table-striped">
                    </table>
                </div>
                <div class="card-footer">
                </div>
            </div>
            <!-- /.card -->

        </div>
    </section>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $.validator.setDefaults({
                submitHandler: function () {
                    var APO = $('#txtAPO').val();
                    var Name = $('#txtName').val();
                    var UserName = "CJ Belaos";
                    $.ajax({
                        url: "EPPIAuthorizedSignatory.aspx/SaveEPPIAuthorizedSignatory",
                        method: "POST",
                        data: JSON.stringify({ APO: APO, Name: Name, UserName: UserName }),
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        success: function (e) {
                            location.reload();
                        },
                        error: function (err) {
                            console.log(err);
                        }
                    });
                }
            });
            $('#form1').validate({
                rules: {
                    Name: {
                        required: true,
                    },
                },
                messages: {
                    Name: {
                        required: "Please provide a Name.",
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

            $('#txtAPO').on('input', function () {
                var APO = $('#txtAPO').val();
                $.ajax({
                    url: "EPPIAuthorizedSignatory.aspx/GetEmployeeName",
                    type: "POST",
                    data: JSON.stringify({ APO: APO }),
                    contentType: "application/json;charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var d = JSON.parse(data.d);
                        if (d.length > 0) {
                            $('#txtName').val(d[0]['FullName']);
                        }
                        else
                            $('#txtName').val('');
                    },
                    error: function (err) {
                        console.err.responseText();
                    }
                })
            });

            GetEPPIAuthorizedSignatory();
        });


        //function DeleteEPPIAuthorizedSignatory(APO, callback) {
        //    var APO = APO;
        //    $.ajax({
        //        url: "EPPIAuthorizedSignatory.aspx/DeleteEPPIAuthorizedSignatory",
        //        type: "POST",
        //        data: JSON.stringify({ APO: APO }),
        //        contentType: "application/json;charset=utf-8",
        //        dataType: "json",
        //        success: function (e) {
        //            var d = JSON.parse(e.d);
        //            if (callback !== undefined) {
        //                callback(d);
        //            }
        //            alert('Data Successfully Deleted!');
        //        },
        //        error: function (errormessage) {
        //            alert(errormessage.responseText);
        //        }
        //    });
        //};

        //function UpdateEPPIAuthorizedSignatory(ID, Name, UserName, callback) {
        //    var ID = ID, Name = Name, UserName = UserName;
        //    $.ajax({
        //        url: "EPPIAuthorizedSignatory.aspx/UpdateEPPIAuthorizedSignatory",
        //        type: "POST",
        //        data: JSON.stringify({ ID: ID, Name: Name, UserName: UserName }),
        //        contentType: "application/json;charset=utf-8",
        //        dataType: "json",
        //        success: function (e) {
        //            var d = JSON.parse(e.d);
        //            if (callback !== undefined) {
        //                callback(d);
        //            }
        //            alert('Data Successfully Updated!');
        //            location.reload();
        //        },
        //        error: function (errormessage) {
        //            alert(errormessage.responseText);
        //        }
        //    });
        //};

        $(document).on('click', 'button', function (e) {
            var elem = $(this);
            Table = $("#tableName").DataTable();
            if (elem.hasClass('btn-delete-row')) {
                var data = Table.row(elem.parents('tr')).data();
                var APO = data[Object.keys(data)[0]];
                console.log(APO);
                if (confirm("Are you sure you want to delete this data?")) {
                    Table.row(elem.parents('tr')).remove().draw();
                    //DeleteEPPIAuthorizedSignatory(ID);
                    $.ajax({
                        url: "EPPIAuthorizedSignatory.aspx/DeleteEPPIAuthorizedSignatory",
                        type: "POST",
                        data: JSON.stringify({ APO: APO }),
                        contentType: "application/json;charset=utf-8",
                        dataType: "json",
                        success: function (e) {
                            var d = JSON.parse(e.d);
                            if (callback !== undefined) {
                                callback(d);
                            }
                            alert('Data Successfully Deleted!');
                        },
                        error: function (errormessage) {
                            alert(errormessage.responseText);
                        }
                    });
                }
            }
        });

        function GetEPPIAuthorizedSignatory() {
            $.ajax({
                url: "EPPIAuthorizedSignatory.aspx/GetEPPIAuthorizedSignatory",
                type: "POST",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    //var btnEdit = '<button type="button" class="btn btn-sm btn-primary btn-update-row" title="Update"><i class="fas fa-edit"></i></button>';
                    var btnDelete = '<button type="button" class="btn btn-sm btn-danger btn-delete-row" title="Delete"><i class="fas fa-trash"></i></button>';
                    var Table = $("#tableName").DataTable({
                        paging: true,
                        lengthChange: false,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        responsive: true,
                        buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                        data: d,
                        columns: [
                            { data: "APOACCOUNT", title: 'APO Account' },
                            { data: "EMPLOYEENAME", title: 'Employee Name' },
                            { data: "CREATEDBY", title: 'Created by' },
                            { data: "CREATEDDATE", title: 'Created Date' },
                            //{ data: "UPDATEDBY", title: 'Updated by' },
                            //{ data: "UPDATEDDATE", title: 'Updated Date' },
                            //{
                            //    data: 'APOACCOUNT', title: 'Edit', render: function (e) {
                            //        return btnEdit;
                            //    }
                            //},
                            {
                                data: 'APOACCOUNT', title: 'Delete', render: function (e) {
                                    return btnDelete;
                                }
                            },
                        ]
                    }).buttons().container().appendTo('#tableName_wrapper .col-md-6:eq(0)');
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

    </script>
</asp:Content>

