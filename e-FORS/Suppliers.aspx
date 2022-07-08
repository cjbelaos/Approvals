<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Suppliers.aspx.cs" Inherits="Suppliers" %>

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
                        <li class="breadcrumb-item active">Suppliers</li>
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
                    <h3 class="card-title">Supplier</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Supplier</label>
                                <input type="text" name="Supplier" id="txtSupplierCode" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Supplier</label>
                                <input type="text" name="Supplier" id="txtSupplier" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" name="Address" id="txtAddress" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Address</label>
                                <input type="text" name="Address" id="txtActive" class="form-control">
                            </div>
                        </div>
                    </div>
                    <button type="submit" id="btnSave" class="btn btn-primary">Save</button>
                </div>
            <!-- /.card-body -->

            <div class="card-body">
                <table id="tableSupplier" class="table table-bordered table-striped">
                </table>
            </div>

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
            $.validator.setDefaults({
                submitHandler: function () {
                    if ($('#txtID').val() == '') {
                        AddSupplier();
                    }
                    else {
                        UpdateSupplier();
                    }
                }
            });
            $('#form1').validate({
                rules: {
                    Supplier: {
                        required: true,
                    },
                    Address: {
                        required: true,
                    },
                },
                messages: {
                    Supplier: {
                        required: "Please enter Supplier Name.",
                    },
                    Address: {
                        required: "Please enter Supplier Address.",
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
            GetSuppliers();
        })

        $(document).on('click', 'button', function (e) {
            var elem = $(this);
            if (elem.hasClass('btn-update-row')) {
                var data = MainTable.row(elem.parents('tr')).data();
                var ID = data[Object.keys(data)[0]];
                var Supplier = data[Object.keys(data)[1]];
                var Address = data[Object.keys(data)[2]];

                $('#txtID').val(ID);
                $('#txtSupplier').val(Supplier);
                $('#txtAddress').val(Address);
            }
            if (elem.hasClass('btn-delete-row')) {
                var data = MainTable.row(elem.parents('tr')).data();
                var ID = data[Object.keys(data)[0]];
                if (confirm("Are you sure you want to delete this data?")) {
                    MainTable.row(elem.parents('tr')).remove().draw();
                    DeleteSupplier(ID);
                }
            }
        });

        function GetSuppliers(callback) {
            $.ajax({
                url: "Supplier.aspx/GetSuppliers",
                type: "POST",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    var btnEdit = '<button type="button" class="btn btn-sm btn-primary btn-update-row" title="Update"><i class="fas fa-edit"></i></button>';
                    var btnDelete = '<button type="button" class="btn btn-sm btn-danger btn-delete-row" title="Delete"><i class="fas fa-trash"></i></button>';
                    if (MainTable !== undefined && MainTable !== null) {
                        MainTable.DataTable('destroy');
                    }
                    MainTable = $("#tableSupplier").DataTable({
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
                            { data: "SupplierName", title: 'Supplier Name' },
                            { data: "SupplierAddress", title: 'Supplier Address' },
                            { data: "CreatedDate", title: 'Date Created' },
                            { data: "CreatedBy", title: 'Created by' },
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

        function AddSupplier(callback) {
            var SupplierDetails = {};
            SupplierDetails.UserID = $('#lblUserID').text();
            SupplierDetails.Supplier = $('#txtSupplier').val();
            SupplierDetails.Address = $('#txtAddress').val();
            $.ajax({
                url: "Supplier.aspx/AddSupplier",
                method: "POST",
                data: JSON.stringify({ sd: SupplierDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Item has been added successfully!');
                    location.reload();
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function UpdateSupplier(callback) {
            var SupplierDetails = {};
            SupplierDetails.UserID = $('#lblUserID').text();
            SupplierDetails.ID = $('#txtID').val();
            SupplierDetails.Supplier = $('#txtSupplier').val();
            SupplierDetails.Address = $('#txtAddress').val();
            $.ajax({
                url: "Supplier.aspx/UpdateSupplier",
                method: "POST",
                data: JSON.stringify({ sd: SupplierDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Item has been updated successfully!');
                    location.reload();
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function DeleteSupplier(ID, callback) {
            var SupplierDetails = {};
            SupplierDetails.UserID = $('#lblUserID').text();
            SupplierDetails.ID = ID;
            $.ajax({
                url: "Supplier.aspx/DeleteSupplier",
                type: "POST",
                data: JSON.stringify({ sd: SupplierDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    alert('Data Successfully Deleted!');
                    ClearFields();
                },
                error: function (errormessage) {
                    alert(errormessage.responseText);
                }
            });
        }

        function ClearFields() {
            $('#txtID').val('');
            $('#txtSupplier').val('');
            $('#txtAddress').val('');
        }
    </script>
</asp:Content>

