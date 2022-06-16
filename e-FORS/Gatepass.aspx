<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Gatepass.aspx.cs" Inherits="Gatepass" %>

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
                            <a href="AllTasks.aspx" class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>All Tasks</p>
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item menu-open">
                    <a href="#" class="nav-link active">
                        <i class="nav-icon fas fa-file-alt"></i>
                        <p>
                            Reports
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="Gatepass.aspx" class="nav-link active">
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
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Reports</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Reports</li>
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
                    <h3 class="card-title">Gatepass</h3>
                </div>
                <!-- /.card-header -->

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label for="tbSection">Section</label>
                                <asp:TextBox runat="server" ID="tbSection" CssClass="form-control"></asp:TextBox>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Supplier</label>
                                <asp:DropDownList runat="server" ID="ddlSupplier" CssClass="form-control select2" Width="100%" name="supplier"></asp:DropDownList>
                            </div>
                            <!-- /.form-group -->
                        </div>
                        <!-- /.col -->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date From</label>
                                <div class="input-group date" id="DateFrom" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="tbDateFrom" CssClass="form-control datetimepicker-input" data-target="#DateFrom" name="datefrom"></asp:TextBox>
                                    <div class="input-group-append" data-target="#DateFrom" data-toggle="datetimepicker">
                                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                    </div>
                                </div>
                            </div>
                            <!-- /.form-group -->
                            <div class="form-group">
                                <label>Date To</label>
                                <div class="input-group date" id="DateTo" data-target-input="nearest">
                                    <asp:TextBox runat="server" ID="tbDateTo" CssClass="form-control datetimepicker-input" data-target="#DateTo" name="dateto"></asp:TextBox>
                                    <div class="input-group-append" data-target="#DateTo" data-toggle="datetimepicker">
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
                        <div class="col">
                            <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-primary" Width="110px" OnClick="BtnSearch_OnClick" />
                            <asp:Button runat="server" ID="BtnClear" Text="Clear" class="btn btn-warning" Width="110px" OnClick="BtnClear_OnClick" />
                        </div>
                    </div>
                </div>
                <!-- /.card-body -->

                <div class="card-body">

                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="gvGatepass" CssClass="table table-bordered table-condensed table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="ControlNo." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lblCONTROLNO" runat="server" Text='<%#Eval("CONTROLNO") %>' CommandArgument='<%#Bind("CONTROLNO") %>' CommandName="Edit" Font-Bold="true" ForeColor="#cc0000" OnClick="lbControlNo_OnClick"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Requestor" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRequestorEmployeeName" runat="server" Text='<%#Eval("RequestorEmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Bearer" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBearerEmployeeName" runat="server" Text='<%#Eval("BearerEmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Destination" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDestinationAddress" runat="server" Text='<%#Eval("DestinationAddress") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Address" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOriginOfItem" runat="server" Text='<%#Eval("OriginOfItem") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Description" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemDescription" runat="server" Text='<%#Eval("ItemDescription") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="QTY." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="U/M" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("UnitOfMeasurement") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Value" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Purpose" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPurposeOfItem" runat="server" Text='<%#Eval("PurposeOfItem") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Date Requested" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDateRequested" runat="server" Text='<%#Eval("DateRequested") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Actual Date of Transfer" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActualDateOfTransfer" runat="server" Text='<%#Eval("ActualDateOfTransfer") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Target Date of Return" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTargetDateOfReturn" runat="server" Text='<%#Eval("TargetDateOfReturn") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Prepared by" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPREPAREDBY" runat="server" Text='<%#Eval("PREPAREDBY") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="DOCS Prepared" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDOCUMENTFORMAT" runat="server" Text='<%#Eval("DOCUMENTFORMAT") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Gatepass Number" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGATEPASSNO" runat="server" Text='<%#Eval("GATEPASSNO") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <!-- /.card-body -->
                    <div class="card-footer">
                    </div>
                </div>
                <!-- /.card -->
            </div>
        </div>
    </section>


</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(function () {
            $('#<%=gvGatepass.ClientID%>').DataTable({
                searching: false,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        title: 'Farm Out Monitoring'
                    },
                    {
                        extend: 'pdfHtml5',
                        title: 'Farm Out Monitoring'
                    }
                ]
            });

            $('.select2').select2()

            //Date picker
            $('#DateFrom').datetimepicker({
                format: 'L',
            });
            $('#DateTo').datetimepicker({
                format: 'L'
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('#<%=gvGatepass.ClientID%>').DataTable({
                    searching: false,
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'excelHtml5',
                            title: 'Farm Out Monitoring'
                        },
                        {
                            extend: 'pdfHtml5',
                            title: 'Farm Out Monitoring'
                        }
                    ]
                });

                $('.select2').select2()

                //Date picker
                $('#DateFrom').datetimepicker({
                    format: 'L',
                });
                $('#DateTo').datetimepicker({
                    format: 'L'
                });
            }
        })
    </script>
</asp:Content>

