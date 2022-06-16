<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FarmOutRequestForm.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="sidebar" runat="Server">

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
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-edit"></i>
                        <p>
                            Forms
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="FarmOutRequestForm.aspx" class="nav-link active">
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
                            <a href="AllTasks.aspx" class="nav-link">
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
                <li class="nav-item">
                    <a href="#" class="nav-link">
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
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upTable" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Forms</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                                <li class="breadcrumb-item active">Forms</li>
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
                            <h3 class="card-title">Farm-out Request Form</h3>
                            <asp:TextBox runat="server" ID="inputUserID" CssClass="form-control" Visible="false"></asp:TextBox>
                            <asp:Label runat="server" ID="lblMessage"></asp:Label>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group" id="ControlNo">
                                        <label class="col-form-label" for="tbControlNo"><i class="far fa-bell"></i>&nbsp;Control No.</label>
                                        <asp:TextBox runat="server" ID="tbControlNo" CssClass="form-control ControlNo" Enabled="false"></asp:TextBox>
                                        <small id="tbControlNoHelpBlock" class="form-text text-danger">This is auto-generated upon saving.</small>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Division</label>
                                        <asp:DropDownList runat="server" ID="ddlDivision" CssClass="form-control select2" Width="100%" name="division"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Nature of Item</label>
                                        <asp:DropDownList runat="server" ID="ddlNatureofItem" CssClass="form-control select2" Width="100%" name="natureofitem"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Type of Item</label>
                                        <asp:DropDownList runat="server" ID="ddlTypeofItem" CssClass="form-control select2" Width="100%" name="typeofitem"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Purpose of Item</label>
                                        <asp:DropDownList runat="server" ID="ddlPurposeofItem" CssClass="form-control select2" Width="100%" name="purposeofitem" OnSelectedIndexChanged="ddlPurposeofItem_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">

                                    <div class="form-group">
                                        <label>Transfer to</label>
                                        <asp:DropDownList runat="server" ID="ddlTransferto" CssClass="form-control select2" Width="100%" name="transferto"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Classification of Item</label>
                                        <asp:DropDownList runat="server" ID="ddlClassificationofItem" CssClass="form-control select2" Width="100%" name="classificationofitem"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group" id="Others" hidden>
                                        <label>Others</label>
                                        <asp:TextBox runat="server" ID="tbOthers" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <h5 class="card-subtitle mb-2 text-danger text-center">For Fixed Assets and Quasi Fixed Assets Only</h5>
                            <h6 class="card-subtitle mb-2 text-muted">Bearer</h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Bearer Employee No.</label>
                                        <asp:TextBox runat="server" ID="tbBearerEmployeeNo" CssClass="form-control" OnTextChanged="tbBearerEmployeeNo_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Bearer Name</label>
                                        <asp:TextBox runat="server" ID="tbBearerEmployeeName" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <h6 class="card-subtitle mb-2 text-muted">Requestor</h6>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Employee No.</label>
                                        <asp:TextBox runat="server" ID="tbEmployeeNo" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Employee Name</label>
                                        <asp:TextBox runat="server" ID="tbEmployeeName" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label for="tbSection">Section</label>
                                        <asp:TextBox runat="server" ID="tbSection" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbLocalNo">Local No.</label>
                                        <asp:TextBox runat="server" ID="tbLocalNo" CssClass="form-control" name="localno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <!-- Date -->
                                    <div class="form-group">
                                        <label>Date Requested</label>
                                        <div class="input-group date" id="DateRequested" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbDateRequested" CssClass="form-control datetimepicker-input" data-target="#DateRequested" name="daterequested"></asp:TextBox>
                                            <div class="input-group-append" data-target="#DateRequested" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-6">
                                    <!-- Date -->
                                    <div class="form-group">
                                        <label>Actual Date of Transfer</label>
                                        <div class="input-group date" id="ActualDateofTransfer" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbActualDateofTransfer" CssClass="form-control datetimepicker-input" data-target="#ActualDateofTransfer" name="actualdateoftransfer"></asp:TextBox>
                                            <div class="input-group-append" data-target="#ActualDateofTransfer" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <!-- Date -->
                                    <div class="form-group">
                                        <label>Target Date of Return</label>
                                        <div class="input-group date" id="TargetDateofReturn" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbTargetDateofReturn" CssClass="form-control datetimepicker-input" data-target="#TargetDateofReturn" name="targetdateofreturn"></asp:TextBox>
                                            <div class="input-group-append" data-target="#TargetDateofReturn" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row mb-1">
                                <asp:Button runat="server" ID="BtnAdd" Text="Add" class="btn btn-primary BtnAdd" OnClick="BtnAdd_OnClick" Width="110px" />
                            </div>
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="gvItems" CssClass="table table-bordered table-striped table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" OnRowCommand="GrvItems_RowCommand">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="ID" ItemStyle-VerticalAlign="Middle" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblID" runat="server" Text='<%#Eval("ID") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Item/Part Code/Serial No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemCode" runat="server" Text='<%#Eval("ItemCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Item Description" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemDescription" runat="server" Text='<%#Eval("ItemDescription") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Quantity" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Unit of Measurement" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("UnitOfMeasurement") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Amount ($)" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Fixed/Quasi Fixed Asset No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssetNo" runat="server" Text='<%#Eval("AssetNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="OD" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblODNo" runat="server" Text='<%#Eval("ODNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Container" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContainerNo" runat="server" Text='<%#Eval("ContainerNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PEZA Seal" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPEZASeal" runat="server" Text='<%#Eval("PEZASeal") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="DS/RDR Number" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDSRDRNo" runat="server" Text='<%#Eval("DSRDRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit"
                                                        CommandName="EditItem"
                                                        CommandArgument='<%#Eval("ID") %>'
                                                        CssClass="btn btn-warning btn-sm"
                                                        Width="100px" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                                        CommandName="DeleteItem"
                                                        CommandArgument='<%#Eval("ID") %>'
                                                        OnClientClick="return confirm('Are you sure you want to delete product?')"
                                                        CssClass="btn btn-danger btn-sm"
                                                        Width="100px" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="thead-light" HorizontalAlign="Center" />
                                    </asp:GridView>
                                </div>
                            </div>


                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Packaging Used</label>
                                        <asp:DropDownList runat="server" ID="ddlPackagingUsed" CssClass="form-control select2" Width="100%" name="packagingused"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbChooseFile">Choose File</label>
                                        <div class="input-group">
                                            <div class="custom-file">
                                                <asp:FileUpload runat="server" CssClass="custom-file-input" ID="fuChooseFile" name="choosefile" AllowMultiple="true" />
                                                <label class="custom-file-label" for="fuChooseFile">Choose file</label>
                                            </div>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnUpload" CssClass="btn btn-outline-secondary" Text="Upload" OnClick="BtnUpload_Click" />
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-body p-0">
                                                <asp:GridView runat="server" ID="gvFiles" CssClass="table table-sm" AutoGenerateColumns="false" Visible="false">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                                                    CommandName="DeleteItem"
                                                                    CommandArgument='<%#Eval("ID") %>'
                                                                    OnClientClick="return confirm('Are you sure you want to delete product?')"
                                                                    CssClass="btn btn-danger btn-sm"
                                                                    Width="100px" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="File Name" ItemStyle-VerticalAlign="Middle">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFileName" runat="server" Text='<%#Eval("FileName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->

                                </div>
                                <!-- /.col -->

                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Supplier Name</label>
                                        <asp:DropDownList runat="server" ID="ddlSupplierName" CssClass="form-control select2" Width="100%" name="suppliername" OnSelectedIndexChanged="ddlSupplierName_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="tbOriginofItem">Origin of Item</label>
                                        <asp:TextBox runat="server" ID="tbOriginofItem" CssClass="form-control" name="originofitem"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Destination Address</label>
                                        <asp:DropDownList runat="server" ID="ddlDestinationAddress" CssClass="form-control select2 ddlDestinationAddress" Width="100%" Enabled="false"></asp:DropDownList>
                                        <small id="DestinationAddressHelpBlock" class="form-text text-danger" hidden>Please select destination address.</small>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbVoiceNo">Invoice No.</label>
                                        <asp:TextBox runat="server" ID="tbInvoiceNo" CssClass="form-control" name="invoiceno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="tbContactPerson">Contact Person</label>
                                        <asp:TextBox runat="server" ID="tbContactPerson" CssClass="form-control" name="contactperson"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="tbTelephoneNo">Telephone No.</label>
                                        <asp:TextBox runat="server" ID="tbTelephoneNo" CssClass="form-control" name="telephoneno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Mode of Transfer</label>
                                        <asp:DropDownList runat="server" ID="ddlModeofTransfer" CssClass="form-control select2" Width="100%" name="modeoftransfer"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="inputDeliveryReceiptNo">Delivery Receipt No.</label>
                                        <asp:TextBox runat="server" ID="tbDeliveryReceiptNo" CssClass="form-control" name="receiptno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="inputContactNo">Contact No.</label>
                                        <asp:TextBox runat="server" ID="tbContactNo" CssClass="form-control" name="contactno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="inputFaxNo">Fax No.</label>
                                        <asp:TextBox runat="server" ID="tbFaxNo" CssClass="form-control" name="faxno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Type of Transfer</label>
                                        <asp:DropDownList runat="server" ID="ddlTypeofTransfer" CssClass="form-control select2" Width="100%" name="typeoftransfer"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Requested by</label>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlRequestedby" CssClass="form-control select2" Enabled="false"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm1" CssClass="btn btn-outline-secondary" Text="Confirm" OnClick="BtnConfirm1_OnClick" Enabled="false" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group">
                                        <label>Status</label>
                                        <asp:Label runat="server" ID="lblStatus1" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Comment</label>
                                        <asp:Label runat="server" ID="lblComment1" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Date</label>
                                        <asp:Label runat="server" ID="lblDate1" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Checked by</label>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlCheckedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm2" CssClass="btn btn-outline-secondary" Text="Confirm" Enabled="false" OnClick="BtnConfirm2_OnClick" />
                                            </div>
                                        </div>
                                        <small id="CheckedbyHelpBlock" class="form-text text-danger" hidden>Required before saving.</small>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblStatus2" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblComment2" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblDate2" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Approved by</label>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlApprovedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm3" CssClass="btn btn-outline-secondary" Text="Confirm" Enabled="false" OnClick="BtnConfirm3_OnClick" />
                                            </div>
                                        </div>
                                        <small id="ApprovedbyHelpBlock" class="form-text text-danger" hidden>Required before saving.</small>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblStatus3" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblComment3" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblDate3" class="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <asp:Button runat="server" ID="BtnSave" CssClass="btn btn-success BtnSave" Text="Save" OnClick="BtnSave_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </section>
        </ContentTemplate>
        <Triggers>
            <%--<asp:AsyncPostBackTrigger ControlID="BtnUpload" />--%>
            <asp:AsyncPostBackTrigger ControlID="ddlSupplierName" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upModalItem" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modal">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Item Information</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <asp:TextBox runat="server" ID="tbID" CssClass="form-control" Enabled="false" Visible="false"></asp:TextBox>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbItemNo">Item/Part Code/Serial No.</label>
                                        <asp:TextBox runat="server" ID="tbItemNo" CssClass="form-control" name="itemno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbItemDescription">Item Description</label>
                                        <asp:TextBox runat="server" ID="tbItemDescription" CssClass="form-control" name="itemdescription"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbQuantity">Quantity</label>
                                        <asp:TextBox runat="server" ID="tbQuantity" CssClass="form-control" name="quantity" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbUnitofMeasurement">Unit of Measurement</label>
                                        <asp:TextBox runat="server" ID="tbUnitofMeasurement" CssClass="form-control" name="unitofmeasurement"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbAmount">Amount ($)</label>
                                        <asp:TextBox runat="server" ID="tbAmount" CssClass="form-control" name="amount" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbAssetNo">Fixed/Quasi Fixed Asset No.</label>
                                        <asp:TextBox runat="server" ID="tbAssetNo" CssClass="form-control" name="assetno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbOD">OD</label>
                                        <asp:TextBox runat="server" ID="tbOD" CssClass="form-control" name="od"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbContainer">Container</label>
                                        <asp:TextBox runat="server" ID="tbContainer" CssClass="form-control" name="container"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbPEZASeal">PEZA Seal</label>
                                        <asp:TextBox runat="server" ID="tbPEZASeal" CssClass="form-control" name="peza"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbDSRDRNo">DS/RDR Number</label>
                                        <asp:TextBox runat="server" ID="tbDSRDRNo" CssClass="form-control" name="dsrdrno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <div class="modal-footer justify-content-between">
                            <button type="button" id="btnClose" class="btn btn-danger" data-dismiss="modal" style="width: 100px">Close</button>
                            <asp:Button runat="server" ID="BtnSubmit" CssClass="btn btn-primary" Text="Submit" OnClick="BtnSubmit_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            </section>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upModalConfirm" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalConfirm">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Approve</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <asp:TextBox runat="server" ID="tbWorkFlowID" CssClass="form-control" Enabled="false" Visible="false"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbApproverID" CssClass="form-control" Enabled="false" Visible="false"></asp:TextBox>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbComment">Comment</label>
                                        <asp:TextBox runat="server" ID="tbComment" CssClass="form-control" TextMode="MultiLine" Height="125px" Width="466px" name="Comment"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnApprove" CssClass="btn btn-success btn-sm" Text="Approve" OnClick="BtnApprove_OnClick" Width="110px" />
                            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 110px">Cancel</button>
                            <asp:Button runat="server" ID="BtnRequestChange" Text="Request Change" CssClass="btn btn-info btn-sm" OnClick="BtnRequestChange_OnClick" Width="110px" />
                            <asp:Button runat="server" ID="BtnReassignTask" Text="Reassign Task" CssClass="btn btn-info btn-sm" OnClick="BtnReassignTask_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upRequestChange" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalRequestChange" data-backdrop="static">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Request Change</h4>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="row mb-1">
                                            <div class="col-md-3">
                                                <label for="tbAssignedto">&nbsp; &nbsp; &nbsp;Assigned to:</label>
                                            </div>
                                            <div class="col-md-9">
                                                <asp:TextBox runat="server" ID="tbAssignedto" CssClass="form-control" Enabled="false" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:TextBox runat="server" ID="tbRequestChangeComment" CssClass="form-control" TextMode="MultiLine" Height="125px" Width="466px" name="Comment"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnSaveRequestChange" CssClass="btn btn-success btn-sm" Text="Save" OnClick="BtnSaveRequestChange_OnClick" Width="110px" />
                            <asp:Button runat="server" ID="BtnCancelRequestChange" CssClass="btn btn-danger btn-sm" Text="Cancel" OnClick="BtnCancelRequestChange_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upReassignTask" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalReassignTask" data-backdrop="static">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Re-assign Task</h4>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="row mb-1">
                                            <div class="col-md-4">
                                                <label for="ddlReassignto">&nbsp; &nbsp; &nbsp;Re-assign to:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <asp:DropDownList runat="server" ID="ddlReassignto" CssClass="form-control select2" Width="100%" name="reassignto"></asp:DropDownList>
                                            </div>
                                            <div class="col-md-4">
                                                <label>&nbsp;</label>
                                            </div>
                                            <div class="col-md-8">
                                                <small id="ReassigntoHelpBlock" class="form-text text-danger" hidden>Required before saving.</small>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <asp:TextBox runat="server" ID="tbReassigntoComment" CssClass="form-control" TextMode="MultiLine" Height="125px" Width="466px" name="Comment"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnSaveReassignTask" CssClass="btn btn-success btn-sm" Text="Save" OnClick="BtnSaveReassignTask_OnClick" Width="110px" />
                            <asp:Button runat="server" ID="BtnCancelReassignTask" CssClass="btn btn-danger btn-sm" Text="Cancel" OnClick="BtnCancelReassignTask_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>



</asp:Content>



<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(function () {

            $('.BtnAdd').attr('disabled', true)

            //Initialize Select2 Elements
            $('.select2').select2()

            //Date picker
            $('#DateRequested').datetimepicker({
                format: 'L',
                defaultDate: new Date()
            });
            $('#ActualDateofTransfer').datetimepicker({
                format: 'L'
            });
            $('#TargetDateofReturn').datetimepicker({
                format: 'L'
            });

            bsCustomFileInput.init();

            $('#form1').validate({
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    error.addClass('invalid-feedback');
                    element.closest('.form-group').append(error);
                }
            });

            $("#<%=gvFiles.ClientID%>").removeAttr("border");
            $("#<%=gvFiles.ClientID%>").removeAttr("rules");

            if ($(".ControlNo").val() != '[AUTOMATIC]') {
                $('#tbControlNoHelpBlock').prop('hidden', true);
                $('.BtnAdd').attr('disabled', false);
            }

            var x = $('#CheckedbyHelpBlock').attr('hidden')
            if (typeof x == typeof undefined) {
                $('#<%=ddlCheckedby.ClientID%>').on('change', function () {
                    if ($('#<%=ddlCheckedby.ClientID%>').val() != '') {
                        $('#CheckedbyHelpBlock').prop('hidden', true);
                    }
                    else {
                        $('#CheckedbyHelpBlock').prop('hidden', false);
                    }
                });
            }

            var x = $('#ApprovedbyHelpBlock').attr('hidden')
            if (typeof x == typeof undefined) {
                $('#<%=ddlApprovedby.ClientID%>').on('change', function () {
                    if ($('#<%=ddlApprovedby.ClientID%>').val() != '') {
                        $('#ApprovedbyHelpBlock').prop('hidden', true);
                    }
                    else {
                        $('#ApprovedbyHelpBlock').prop('hidden', false);
                    }
                });
            }

            var x = $('#ReassigntoHelpBlock').attr('hidden')
            if (typeof x == typeof undefined) {
                $('#<%=ddlReassignto.ClientID%>').on('change', function () {
                    if ($('#<%=ddlReassignto.ClientID%>').val() != '') {
                        $('#ReassigntoHelpBlock').prop('hidden', true);
                    }
                    else {
                        $('#ReassigntoHelpBlock').prop('hidden', false);
                    }
                });
            }

            var x = $('#DestinationAddressHelpBlock').attr('hidden')
            if (typeof x == typeof undefined) {
                $('#<%=ddlDestinationAddress.ClientID%>').on('change', function () {
                    if ($('#<%=ddlDestinationAddress.ClientID%>').val() != '') {
                        $('#DestinationAddressHelpBlock').prop('hidden', true);
                    }
                    else {
                        $('#DestinationAddressHelpBlock').prop('hidden', false);
                    }
                });
            }

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {

                $('.BtnAdd').attr('disabled', true)

                //Initialize Select2 Elements
                $('.select2').select2()

                //Date picker
                $('#DateRequested').datetimepicker({
                    format: 'L',
                    defaultDate: new Date()
                });
                $('#ActualDateofTransfer').datetimepicker({
                    format: 'L'
                });
                $('#TargetDateofReturn').datetimepicker({
                    format: 'L'
                });

                bsCustomFileInput.init();

                $('#form1').validate({
                    errorElement: 'span',
                    errorPlacement: function (error, element) {
                        error.addClass('invalid-feedback');
                        element.closest('.form-group').append(error);
                    }
                });

                $("#<%=gvFiles.ClientID%>").removeAttr("border");
                $("#<%=gvFiles.ClientID%>").removeAttr("rules");

                if ($("#maincontent_tbControlNo").val() != '[AUTOMATIC]') {
                    $('#tbControlNoHelpBlock').prop('hidden', true);
                    $('.BtnAdd').attr('disabled', false);
                }

                var x = $('#CheckedbyHelpBlock').attr('hidden')
                if (typeof x == typeof undefined) {
                    $('#<%=ddlCheckedby.ClientID%>').on('change', function () {
                        if ($('#<%=ddlCheckedby.ClientID%>').val() != '') {
                            $('#CheckedbyHelpBlock').prop('hidden', true);
                        }
                        else {
                            $('#CheckedbyHelpBlock').prop('hidden', false);
                        }
                    });
                }

                var x = $('#ApprovedbyHelpBlock').attr('hidden')
                if (typeof x == typeof undefined) {
                    $('#<%=ddlApprovedby.ClientID%>').on('change', function () {
                        if ($('#<%=ddlApprovedby.ClientID%>').val() != '') {
                            $('#ApprovedbyHelpBlock').prop('hidden', true);
                        }
                        else {
                            $('#ApprovedbyHelpBlock').prop('hidden', false);
                        }
                    });
                }

                var x = $('#ReassigntoHelpBlock').attr('hidden')
                if (typeof x == typeof undefined) {
                    $('#<%=ddlReassignto.ClientID%>').on('change', function () {
                        if ($('#<%=ddlReassignto.ClientID%>').val() != '') {
                            $('#ReassigntoHelpBlock').prop('hidden', true);
                        }
                        else {
                            $('#ReassigntoHelpBlock').prop('hidden', false);
                        }
                    });
                }

                var x = $('#DestinationAddressHelpBlock').attr('hidden')
                if (typeof x == typeof undefined) {
                    $('#<%=ddlDestinationAddress.ClientID%>').on('change', function () {
                        if ($('#<%=ddlDestinationAddress.ClientID%>').val() != '') {
                            $('#DestinationAddressHelpBlock').prop('hidden', true);
                        }
                        else {
                            $('#DestinationAddressHelpBlock').prop('hidden', false);
                        }
                    });
                }
            }
        })

        function InvalidCOntrolNo() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Unable to upload. Invalid Control No.'
            })
        }

        function UploadFailedAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Please choose file(s) to upload!'
            })
        }

        function SaveFarmOutSuccessAlert() {
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

        function SaveFarmOutFailedAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Unable to save. Please complete the details.'
            })
        }

        function AddItemsSuccessAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'success',
                title: 'Items has been saved successfully.'
            })
        }

        function AddItemsFailedAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Please try again.'
            })
        }

        function UpdateItemsSuccessAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'success',
                title: 'Items has been updated successfully.'
            })
        }

        function ApprovedFarmOutSuccessAlert() {
            toastr.success('Task successfully approve!')
        }

        function RequestChangeFarmOutSuccessAlert() {
            toastr.success('Successfully Request Change!')
        }

        function ReassignFarmOutSuccessAlert() {
            toastr.success('Task successfully reassigned!')
        }

        function FailedAlert() {
            toastr.error('Please save Farm-Out First!')
        }

        function DisableForm() {
            $('#maincontent_ddlDivision').prop('disabled', true);
            $('#maincontent_ddlNatureofItem').prop('disabled', true);
            $('#maincontent_ddlTransferto').prop('disabled', true);
            $('#maincontent_ddlTypeofItem').prop('disabled', true);
            $('#maincontent_ddlClassificationofItem').prop('disabled', true);
            $('#maincontent_ddlPurposeofItem').prop('disabled', true);
            $('#maincontent_tbLocalNo').prop('disabled', true);
            $('#maincontent_tbDateRequested').prop('disabled', true);
            $('#maincontent_tbActualDateofTransfer').prop('disabled', true);
            $('#maincontent_tbTargetDateofReturn').prop('disabled', true);
            $('#maincontent_BtnAdd').prop('disabled', true);
            $('#maincontent_ddlPackagingUsed').prop('disabled', true);
            $('#maincontent_fuChooseFile').prop('disabled', true);
            $('#maincontent_BtnUpload').prop('disabled', true);
            $('#maincontent_ddlSupplierName').prop('disabled', true);
            $('#maincontent_tbOriginofItem').prop('disabled', true);
            $('#maincontent_tbDestinationAddress').prop('disabled', true);
            $('#maincontent_tbInvoiceNo').prop('disabled', true);
            $('#maincontent_tbDeliveryReceiptNo').prop('disabled', true);
            $('#maincontent_tbContactPerson').prop('disabled', true);
            $('#maincontent_tbContactNo').prop('disabled', true);
            $('#maincontent_tbTelephoneNo').prop('disabled', true);
            $('#maincontent_tbFaxNo').prop('disabled', true);
            $('#maincontent_ddlModeofTransfer').prop('disabled', true);
            $('#maincontent_ddlTypeofTransfer').prop('disabled', true);
            $('#maincontent_ddlCheckedby').prop('disabled', true);
            $('#maincontent_ddlApprovedby').prop('disabled', true);
            $('#maincontent_BtnSave').prop('disabled', true);
            $('#maincontent_BtnConfirm1').prop('disabled', true);
            $('#maincontent_BtnConfirm2').prop('disabled', true);
            $('#maincontent_BtnConfirm3').prop('disabled', true);
            $("#maincontent_gvItems").find("input,button,textarea,select").attr("disabled", "disabled");
        }

        //Function to allow only Decimal values to textbox
        function isNumberKey(key) {
            //getting key code of pressed key
            var keycode = (key.which) ? key.which : key.keyCode;
            //comparing pressed keycodes
            if (!(keycode == 8 || keycode == 46) && (keycode < 48 || keycode > 57)) {
                return false;
            }
            else {
                var parts = key.srcElement.value.split('.');
                if (parts.length > 1 && keycode == 46)
                    return false;
                return true;
            }
        }

        function ModalErrorPrevention() {
            $("#modalRequestChange").modal({ backdrop: "static ", keyboard: false });
        }

        function RemoveTableBorder() {
            $("#<%=gvFiles.ClientID%>").removeAttr("border");
            $("#<%=gvFiles.ClientID%>").removeAttr("rules");
        }

        function ShowOthers() {
            $('#Others').removeAttr('hidden');
        }

        function ShowApprovalHelpBlock() {
            $('#CheckedbyHelpBlock').removeAttr('hidden');
            $('#ApprovedbyHelpBlock').removeAttr('hidden');
        }

        function ShowCheckedbyHelpBlock() {
            $('#CheckedbyHelpBlock').removeAttr('hidden');
        }

        function ShowApprovedbyHelpBlock() {
            $('#ApprovedbyHelpBlock').removeAttr('hidden');
        }

        function HideControlNoHelpBlock() {
            $('#tbControlNoHelpBlock').prop('hidden', true);
        }

        function ShowReassigntoHelpBlock() {
            $('#ReassigntoHelpBlock').removeAttr('hidden');
        }

        function ShowDestinationAddressHelpBlock() {
            if ( $('.ddlDestinationAddress').val() != '')
            {
                $('#DestinationAddressHelpBlock').removeAttr('hidden');
            }
        }


    </script>
</asp:Content>
