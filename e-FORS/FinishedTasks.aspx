<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FinishedTasks.aspx.cs" Inherits="FinishedTasks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="maincontent" runat="Server">
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
                                <li class="breadcrumb-item active">Finished Tasks</li>
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
                            <h3 class="card-title">Finished Tasks</h3>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <asp:GridView runat="server" ID="gvFinishedTasks" CssClass="table table-bordered table-condensed table-hover table-sm" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
                                        <HeaderStyle CssClass="thead-light" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Control No." ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lblControlNo" runat="server" Text='<%#Eval("CONTROLNO") %>' Font-Bold="true" ForeColor="#cc0000" OnClick="lblControlNo_Click"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Approved by" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovedBy" runat="server" Text='<%#Eval("APPROVEDBY") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Approved Date" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblApprovedDate" runat="server" Text='<%#Eval("APPROVEDDATE") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Created by" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCreatedBy" runat="server" Text='<%#Eval("CREATEDBY") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Created Date" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCreatedDate" runat="server" Text='<%#Eval("CREATEDDATE") %>'></asp:Label>
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
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="Server">
    $(function () {
            $('#<%=gvFinishedTasks.ClientID%>').DataTable();

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('#<%=gvFinishedTasks.ClientID%>').DataTable();
            }
        })
</asp:Content>

