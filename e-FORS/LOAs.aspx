<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="LOAs.aspx.cs" Inherits="LOAs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
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
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">LOA Types</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>LOA Type</label>
                                        <input type="text" name="APO" id="txtLOAType" class="form-control">
                                    </div>
                                    <button type="button" id="btnAddLOAType" class="btn btn-primary">Add</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="tableLOAType" class="table table-bordered table-striped">
                            </table>
                        </div>
                        <div class="card-footer">
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">LOA No</h3>
                            <div class="card-tools">
                                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-minus"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>LOA No.</label>
                                        <input type="text" name="APO" id="txtLOANo." class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Expiry Date</label>
                                        <div class="input-group date" id="LOAExpiryDate" data-target-input="nearest">
                                            <input type="text" id="txtLOAExpiryDate" class="form-control datetimepicker-input" data-target="#LOAExpiryDate" />
                                            <div class="input-group-append" data-target="#LOAExpiryDate" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                                
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Surety Bond No.</label>
                                        <input type="text" name="Name" id="txtSuretyBondNo" class="form-control">
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Expiry Date</label>
                                        <div class="input-group date" id="SBExpiryDate" data-target-input="nearest">
                                            <input type="text" id="txtSBExpiryDate" class="form-control datetimepicker-input" data-target="#SBExpiryDate" />
                                            <div class="input-group-append" data-target="#SBExpiryDate" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <button type="button" id="btnAddLOANo" class="btn btn-primary">Add</button>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="tableLOANo" class="table table-bordered table-striped">
                            </table>
                        </div>
                        <div class="card-footer">
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#LOAExpiryDate').datetimepicker({
                format: 'L'
            });
            $('#SBExpiryDate').datetimepicker({
                format: 'L'
            });

            $.validator.setDefaults({
                submitHandler: function () {
                    var LOAType = $('#txtAPO').val();
                    var UserID = <%= Session["UserID"].ToString().ToLower() %>;
                    $.ajax({
                        url: "LOAs.aspx/SaveEPPIAuthorizedSignatory",
                        method: "POST",
                        data: JSON.stringify({ LOAType: LOAType, UserID: UserID }),
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
            GetLOAType();
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

        //$(document).on('click', 'button', function (e) {
        //    var elem = $(this);
        //    Table = $("#tableName").DataTable();
        //    if (elem.hasClass('btn-delete-row')) {
        //        var data = Table.row(elem.parents('tr')).data();
        //        var APO = data[Object.keys(data)[0]];
        //        console.log(APO);
        //        if (confirm("Are you sure you want to delete this data?")) {
        //            Table.row(elem.parents('tr')).remove().draw();
        //            //DeleteEPPIAuthorizedSignatory(ID);
        //            $.ajax({
        //                url: "EPPIAuthorizedSignatory.aspx/DeleteEPPIAuthorizedSignatory",
        //                type: "POST",
        //                data: JSON.stringify({ APO: APO }),
        //                contentType: "application/json;charset=utf-8",
        //                dataType: "json",
        //                success: function (e) {
        //                    var d = JSON.parse(e.d);
        //                    if (callback !== undefined) {
        //                        callback(d);
        //                    }
        //                    alert('Data Successfully Deleted!');
        //                },
        //                error: function (errormessage) {
        //                    alert(errormessage.responseText);
        //                }
        //            });
        //        }
        //    }
        //});

        function GetLOAType() {
            $.ajax({
                url: "LOAs.aspx/GetLOAType",
                type: "POST",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    var btnEdit = '<button type="button" class="btn btn-sm btn-primary btn-update-row" title="Update"><i class="fas fa-edit"></i></button>';
                    var btnDelete = '<button type="button" class="btn btn-sm btn-danger btn-delete-row" title="Delete"><i class="fas fa-trash"></i></button>';
                    var Table = $("#tableLOAType").DataTable({
                        paging: true,
                        lengthChange: false,
                        ordering: true,
                        info: true,
                        autoWidth: false,
                        responsive: true,
                        buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                        data: d,
                        columns: [
                            { data: "ID", title: 'ID' },
                            { data: "LOAType", title: 'LOA Type' },
                            {
                                data: 'ID', title: 'Edit', render: function (e) {
                                    return btnEdit;
                                }
                            },
                            {
                                data: 'ID', title: 'Delete', render: function (e) {
                                    return btnDelete;
                                }
                            },
                        ]
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
    </script>
</asp:Content>

