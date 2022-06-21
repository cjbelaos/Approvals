<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Supplier.aspx.cs" Inherits="Supplier" %>

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

