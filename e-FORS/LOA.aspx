<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="LOA.aspx.cs" Inherits="LOA" %>

<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upTable" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Reports</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                                <li class="breadcrumb-item active">LOA</li>
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
                            <h3 class="card-title">LOA</h3>
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
                                    <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-primary" Width="70px" OnClick="BtnSearch_OnClick" />
                                    <asp:Button runat="server" ID="BtnClear" Text="Clear" class="btn btn-warning" Width="70px" OnClick="BtnClear_OnClick" />
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="gvLOA" CssClass="table table-bordered table-condensed table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" Width="4000px">
                                        <HeaderStyle CssClass="thead-light" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Date Transfer" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActualDateOfTransfer" runat="server" Text='<%#Eval("ActualDateOfTransfer") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Destination" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTargetDateOfReturn" runat="server" Text='<%#Eval("DestinationAddress") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Description" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSection" runat="server" Text='<%#Eval("ItemDescription") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Model" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSupplierName" runat="server" Text='<%#Eval("Model") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PartCode" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSupplierAddress" runat="server" Text='<%#Eval("ItemCode") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="QTY" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBearerEmployeeName" runat="server" Text='<%#Eval("Quantity") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Invoice Value" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblItemCode" runat="server" Text='<%#Eval("InvoiceValue") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Inv. No. / DR. No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("InvoiceNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Origin of Item" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("OriginOfItem") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="EPPI 8106" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("PEZADOCUMENTNO") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PEZA Permit No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("PEZAPERMITNO") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Gatepass No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("GATEPASSNO") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="FRF No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("CONTROLNO") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Delivery Slip No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("DeliverySlipNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Subcon 8105 No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("Subcon8105No") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PEZA Permit No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("8105PEZAPermitNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Date Returned" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("DateReturned") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Subcon 8106 No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("Subcon8106") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PEZA Permit No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("[8106PEZAPermit]") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="DR No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("DRNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="EPPI 8015 No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("EPPI8015No") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="PEZA Permit No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("EPPIPEZAPERMITNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="QTY" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("EPPIQTY") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Bond Amount" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblUnitOfMeasurement" runat="server" Text='<%#Eval("BONDAMOUNT") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

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
            $('#<%=gvLOA.ClientID%>').DataTable({
                searching: true,
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        title: 'LOA Monitoring'
                    },
                    {
                        extend: 'pdfHtml5',
                        title: 'LOA Monitoring'
                    }
                ]
            });

            //Initialize Select2 Elements
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
                $('#<%=gvLOA.ClientID%>').DataTable({
                    searching: true,
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'excelHtml5',
                            title: 'LOA Monitoring'
                        },
                        {
                            extend: 'pdfHtml5',
                            title: 'LOA Monitoring'
                        }
                    ]
                });

                //Initialize Select2 Elements
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

