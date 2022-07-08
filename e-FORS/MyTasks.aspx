<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MyTasks.aspx.cs" Inherits="MyTasks" %>

<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upTable" runat="server">
        <ContentTemplate>
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Tasks</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                                <li class="breadcrumb-item active">My Tasks</li>
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
                            <h3 class="card-title">My Tasks</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="gvMyTasks" CssClass="table table-bordered table-condensed table-hover table-sm primary" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                        <HeaderStyle CssClass="thead-light" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="ControlNo." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbControlNo" runat="server" Text='<%#Eval("CONTROLNO") %>' CommandArgument='<%#Bind("controlno") %>' CommandName="Edit" Font-Bold="true" ForeColor="#cc0000" OnClick="lbControlNo_OnClick"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Division" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDivision" runat="server" Text='<%#Eval("DIVISION") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Process Name" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblProcessName" runat="server" Text='<%#Eval("PROCESSNAME") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Assigned Username" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssignedUsername" runat="server" Text='<%#Eval("ASSIGNEDUSERNAME") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Assigned Date" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAssignedDate" runat="server" Text='<%#Eval("ASSIGNEDATE") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Page ID" ItemStyle-VerticalAlign="Middle" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPageID" runat="server" Text='<%#Eval("PAGEID") %>'></asp:Label>
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
            $("#<%=gvMyTasks.ClientID%>").DataTable();

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $("#<%=gvMyTasks.ClientID%>").DataTable();
            }
        })
</script>
</asp:Content>

