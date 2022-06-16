<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Supplier.aspx.cs" Inherits="Supplier" %>

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
                            <a href="Supplier.aspx" class="nav-link active">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Supplier</p>
                            </a>
                        </li>
                    </ul>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="EPPIAuthorizedSignatory.aspx" class="nav-link">
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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>

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
                                        <asp:DropDownList runat="server" ID="ddlSupplier" CssClass="form-control select2" Width="100%" name="supplier"></asp:DropDownList>
                                        <%--<select id="select_Supplier" class="form-control select2" style="width: 100%;" name="Supplier">
                                    <option selected value="">Choose...</option>
                                </select>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>LOA Type</label>
                                        <asp:DropDownList runat="server" ID="ddlLOAType" CssClass="form-control select2" Width="100%" OnSelectedIndexChanged="ddlLOAType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>LOA No.</label>
                                        <asp:DropDownList runat="server" ID="ddlLOANo" CssClass="form-control select2" Width="100%" OnSelectedIndexChanged="ddlLOANo_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        <%--<input type="text" name="LOANo" id="txtLOANo" class="form-control">--%>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="inputLOAAmountLimit">LOA Amount Limit</label>
                                        <asp:TextBox runat="server" ID="tbLOAAmountLimit" CssClass="form-control"></asp:TextBox>
                                        <%--<input type="text" name="LOAAmountLimit" id="txtLOAAmountLimit" class="form-control">--%>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Surety Bond No.</label>
                                        <asp:DropDownList runat="server" ID="ddlSuretyBondNo" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                        <%--<input type="text" name="SuretyBondNo" id="txtSuretyBondNo" class="form-control">--%>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">

                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Expiration Date</label>
                                        <div class="input-group date" id="ExpirationDate1" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbExpirationDate1" CssClass="form-control datetimepicker-input" data-target="#ExpirationDate1" name="expirationdate1"></asp:TextBox>
                                            <%--<input type="text" name="ExpirationDate1" id="txtExpirationDate1" class="form-control datetimepicker-input" data-target="#ExpirationDate1" />--%>
                                            <div class="input-group-append" data-target="#ExpirationDate1" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="inputLOAQuantityLimit">LOA Quantity Limit</label>
                                        <asp:TextBox runat="server" ID="tbLOAQuantityLimit" CssClass="form-control"></asp:TextBox>
                                        <%--<input type="text" name="LOAQuantityLimit" id="txtLOAQuantityLimit" class="form-control">--%>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Expiration Date</label>
                                        <div class="input-group date" id="ExpirationDate2" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbExpirationDate2" CssClass="form-control datetimepicker-input" data-target="#ExpirationDate2" name="expirationdate2"></asp:TextBox>
                                            <%--<input type="text" name="ExpirationDate2" id="txtExpirationDate2" class="form-control datetimepicker-input" data-target="#ExpirationDate2" />--%>
                                            <div class="input-group-append" data-target="#ExpirationDate2" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-2">
                                    <asp:Button runat="server" ID="BtnSave" Text="Save" class="btn btn-primary" Width="110px" OnClick="BtnSave_OnClick" />
                                    <%--<button type="submit" id="btnSave" class="btn btn-primary">Save</button>--%>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <%--<table id="tableSupplier" class="table table-bordered table-striped">
                    </table>--%>
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel ID="upTable" runat="server">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="table-responsive">
                                            <asp:GridView runat="server" ID="gvSupplier" CssClass="table table-bordered table-condensed table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" OnRowCommand="gvSupplier_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Supplier">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSupplierName" runat="server" Text='<%#Eval("SupplierName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="LOA Type">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLOAType" runat="server" Text='<%#Eval("LOAType") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="LOA No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLOANo" runat="server" Text='<%#Eval("LOANo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="LOA Expiration Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblLOAExpirationDate" runat="server" Text='<%#Eval("LOAExpirationDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount Limit">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAmountLimit" runat="server" Text='<%#Eval("AmountLimit") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Quantity Limit">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblQTYLimit" runat="server" Text='<%#Eval("QTYLimit") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Surety Bond No.">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSuretyBondNo" runat="server" Text='<%#Eval("SuretyBondNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Surety Bond Expiration">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSuretyBondExpiration" runat="server" Text='<%#Eval("SuretyBondExpiration") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Edit">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnEdit" runat="server" Text="<i class='fas fa-edit'></i>"
                                                                CommandName="EditItem"
                                                                CommandArgument='<%#Eval("SupplierName") %>'
                                                                CssClass="btn btn-sm btn-primary" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="Delete">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnDelete" runat="server" Text="<i class='fas fa-trash'></i>"
                                                                CommandName="DeleteItem"
                                                                CommandArgument='<%#Eval("SupplierName") %>'
                                                                OnClientClick="return confirm('Are you sure you want to delete product?')"
                                                                CssClass="btn btn-sm btn-danger" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                </Columns>
                                                <HeaderStyle CssClass="thead-light" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <div class="card-footer">
                        </div>
                    </div>
                    <!-- /.card -->

                </div>
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(function () {
            $('#<%=gvSupplier.ClientID%>').DataTable({
                paging: true,
                lengthChange: false,
                searching: true,
                ordering: true,
                info: true,
                autoWidth: false,
                responsive: true,
                buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
            }).buttons().container().appendTo('#<%=gvSupplier.ClientID%>_wrapper .col-md-6:eq(0)');

            //Initialize Select2 Elements
            $('.select2').select2()

            //Date picker
            $('#ExpirationDate1').datetimepicker({
                format: 'L',
            });
            $('#ExpirationDate2').datetimepicker({
                format: 'L'
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('#<%=gvSupplier.ClientID%>').DataTable({
                    paging: true,
                    lengthChange: false,
                    searching: true,
                    ordering: true,
                    info: true,
                    autoWidth: false,
                    responsive: true,
                    buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                }).buttons().container().appendTo('#<%=gvSupplier.ClientID%>_wrapper .col-md-6:eq(0)');

                //Initialize Select2 Elements
                $('.select2').select2()

                //Date picker
                $('#ExpirationDate1').datetimepicker({
                    format: 'L',
                });
                $('#ExpirationDate2').datetimepicker({
                    format: 'L'
                });
            }
        })

        function SaveSuccessAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'success',
                title: 'Data has been saved successfully.'
            })
        }

        function SaveFailedAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Unable to save. Please complete the details!'
            })
        }
    </script>
</asp:Content>

