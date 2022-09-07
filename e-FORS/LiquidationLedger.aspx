<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LiquidationLedger.aspx.cs" Inherits="LiquidationLedger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
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
                                <li class="breadcrumb-item active">Liquidation Ledger</li>
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
                            <h3 class="card-title">Liquidation Ledger</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>LOA No.</label>
                                        <asp:DropDownList runat="server" ID="ddlLOANo" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->

                            <div class="row">
                                <div class="col">
                                    <asp:Button runat="server" ID="BtnSearch" Text="Search" class="btn btn-primary btn-sm" Width="70px" OnClick="BtnSearch_OnClick" />
                                    <asp:Button runat="server" ID="BtnSave" Text="Save" class="btn btn-success btn-sm" Width="70px" OnClick="BtnSave_Click" />
                                </div>
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="grdLiquidationLedger" CssClass="table table-bordered table-condensed table-hover table-sm" Style="white-space: nowrap;" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                        <HeaderStyle CssClass="thead-light" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField DataField="SUPPLIER" HeaderText="Supplier" />
                                            <asp:BoundField DataField="TYPEOFITEM" HeaderText="Description of Goods" />
                                            <asp:BoundField DataField="PEZADOCUMENTNO" HeaderText="8106" />
                                            <asp:BoundField DataField="DATEOFTRANSFER" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" />
                                            <asp:BoundField DataField="TOTALQUANTITY" HeaderText="Quantity" />
                                            <asp:BoundField DataField="TOTALAMOUNT" HeaderText="$ Value" />
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
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        $(function () {
            <%--$('#<%=grdLiquidationLedger.ClientID%>').DataTable({
                searching: true,
            });--%>
            //Initialize Select2 Elements
            $('.select2').select2()

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                <%--$('#<%=grdLiquidationLedger.ClientID%>').DataTable({
                    searching: true,
                });--%>
                //Initialize Select2 Elements
                $('.select2').select2()
            }
        })


        function SelectLOAAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Please choose LOA No.'
            })
        }
    </script>
</asp:Content >

