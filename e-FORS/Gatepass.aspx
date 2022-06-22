<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Gatepass.aspx.cs" Inherits="Gatepass" %>

<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server">
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
                                <li class="breadcrumb-item active">Gatepass</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </section>

            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">

                    <div class="card card-info">
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
                                    <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-info" Width="80px" OnClick="BtnSearch_OnClick" />
                                    <asp:Button runat="server" ID="BtnClear" Text="Clear" class="btn btn-info" Width="80px" OnClick="BtnClear_OnClick" />
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">


                            <div class="row">
                                <div class="table-responsive" style="overflow: auto; width: 1500px">
                                    <asp:GridView runat="server" ID="gvGatepass" CssClass="table table-bordered table-condensed table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" HeaderStyle-HorizontalAlign="Center" HeaderStyle-BackColor="Teal" HeaderStyle-ForeColor="White" Width="2000px">
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


                            <!-- /.card-body -->
                            <div class="card-footer">
                            </div>
                        </div>
                        <!-- /.card -->
                    </div>
                </div>
            </section>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="BtnSearch" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="BtnClear" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
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

