<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EPPIAuthorizedSignatory.aspx.cs" Inherits="EPPIAuthorizedSignatory" %>


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

