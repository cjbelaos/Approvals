<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FarmOutRequestForm.aspx.cs" Inherits="Default" %>

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
                                <li class="breadcrumb-item active">Farm-out Request Form</li>
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
                            <h3 class="card-title">Farm-out Request Form</h3>
                            <asp:TextBox runat="server" ID="inputUserID" CssClass="form-control" Visible="false"></asp:TextBox>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group" id="ControlNo">
                                        <label class="col-form-label" for="tbControlNo"><i class="far fa-bell"></i>&nbsp;Control No.</label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="tbControlNo" CssClass="form-control ControlNo" Enabled="false"></asp:TextBox>
                                            <div class="input-group-append">
                                                <asp:LinkButton runat="server" ID="LnkBtnBack" CssClass="btn btn-info" Text="Back" OnClick="LnkBtnBack_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label>Division</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlDivision" CssClass="form-control select2" Width="100%" name="division"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nature of Item</label>
                                        <asp:DropDownList runat="server" ID="ddlNatureofItem" CssClass="form-control select2" Width="100%" name="natureofitem"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Transfer to</label>
                                        <asp:DropDownList runat="server" ID="ddlTransferto" CssClass="form-control select2" Width="100%" name="transferto"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Type of Item</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlTypeofItem" multiple="multiple" data-placeholder="Choose..." CssClass="form-control select2" Width="100%" name="typeofitem"></asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hfTypeofItem" />
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Classification of Item</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlClassificationofItem" CssClass="form-control select2" Width="100%" name="classificationofitem"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Purpose of Item</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlPurposeofItem" CssClass="form-control select2" Width="100%" name="purposeofitem" OnSelectedIndexChanged="ddlPurposeofItem_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group" id="Others" hidden>
                                        <label>Others</label>
                                        <asp:TextBox runat="server" ID="tbOthers" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
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
                                <asp:Button runat="server" ID="BtnAdd" Text="Add" CssClass="btn btn-primary BtnAdd" Enabled="false" OnClick="BtnAdd_OnClick" Width="70px" />
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
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="LOA Description" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTypeOfItem" runat="server" Text='<%#Eval("TypeOfItem") %>'></asp:Label>
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
                                                    <asp:Button ID="BtnEdit" runat="server" Text="Edit"
                                                        CommandName="EditItem"
                                                        CommandArgument='<%#Eval("ID") %>'
                                                        CssClass="btn btn-warning btn-sm"
                                                        Width="70px" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                                <ItemTemplate>
                                                    <asp:Button ID="BtnDelete" runat="server" Text="Delete"
                                                        CommandName="DeleteItem"
                                                        CommandArgument='<%#Eval("ID") %>'
                                                        OnClientClick="return confirm('Are you sure you want to delete product?')"
                                                        CssClass="btn btn-danger btn-sm"
                                                        Width="70px" />
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
                                                <label class="custom-file-label" for="fuChooseFile"></label>
                                            </div>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnUpload" CssClass="btn btn-success" Text="Upload" OnClick="BtnUpload_Click" />
                                            </div>
                                        </div>
                                        <div class="card">
                                            <div class="card-body p-0">
                                                <asp:GridView runat="server" ID="gvFiles" BorderStyle="None" CssClass="table table-sm table-borderless" 
                                                    AutoGenerateColumns="false" OnRowCommand="gvFiles_RowCommand" Visible="false">
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-VerticalAlign="Middle">
                                                            <ItemTemplate>
                                                                <asp:Button ID="BtnDelete" runat="server" Text="Delete"
                                                                    CommandName="Delete"
                                                                    CommandArgument='<%#Eval("FileName") %>'
                                                                    OnClientClick="return confirm('Are you sure you want to delete this file?')"
                                                                    
                                                                    CssClass="btn btn-danger btn-sm"
                                                                    Width="70px"/>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="File Name" ItemStyle-VerticalAlign="Middle">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblFileName" runat="server" Text='<%#Eval("FileName") %>' CommandArgument='<%#Bind("FileName") %>' CommandName="View" OnClick="lblFileName_Click"></asp:LinkButton>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlSupplierName" CssClass="form-control select2" Width="100%" name="suppliername" OnSelectedIndexChanged="ddlSupplierName_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        <small id="ddlSupplierHelpBlock" class="form-text text-danger" hidden>Please  choose a supplier.</small>
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
                                        <asp:TextBox runat="server" ID="tbDestinationAddress" CssClass="form-control" Enabled="false"></asp:TextBox>
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
                                                <asp:Button runat="server" ID="BtnConfirm1" CssClass="btn btn-warning" Text="Confirm" OnClick="BtnConfirm1_OnClick" Enabled="false" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group">
                                        <label>Status</label>
                                        <asp:Label runat="server" ID="lblStatus1" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Comment</label>
                                        <asp:Label runat="server" ID="lblComment1" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Date</label>
                                        <asp:Label runat="server" ID="lblDate1" CssClass="form-control-plaintext"></asp:Label>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlCheckedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm2" CssClass="btn btn-warning" Text="Confirm" Enabled="false" OnClick="BtnConfirm2_OnClick" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblStatus2" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblComment2" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblDate2" CssClass="form-control-plaintext"></asp:Label>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlApprovedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm3" CssClass="btn btn-warning" Text="Confirm" Enabled="false" OnClick="BtnConfirm3_OnClick" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblStatus3" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblComment3" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblDate3" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <asp:Button runat="server" ID="BtnSave" CssClass="btn btn-primary BtnSave" Text="Save" OnClick="BtnSave_OnClick" Width="70px" />
                            <asp:Button runat="server" ID="BtnPrint" CssClass="btn btn-info" Text="Print" OnClick="BtnPrint_Click" Width="70px" Visible="false"/>
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </section>

        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlSupplierName" EventName="SelectedIndexChanged" />
            <asp:PostBackTrigger ControlID="BtnUpload" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upModalItem" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modal">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-primary">
                            <h4 class="modal-title">Item Information</h4>
                            <asp:Label runat="server" ID="lblMessage"></asp:Label>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Type of Item</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlItemType" CssClass="form-control select2"></asp:DropDownList>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <asp:TextBox runat="server" ID="tbID" CssClass="form-control" Enabled="false" Visible="false"></asp:TextBox>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbItemNo">Item/Part Code/Serial No.</label>
                                        <asp:TextBox runat="server" ID="tbItemNo" CssClass="form-control text-uppercase" name="itemno"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbItemDescription">Item Description</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:TextBox runat="server" ID="tbItemDescription" CssClass="form-control text-uppercase" name="itemdescription"></asp:TextBox>
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
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:TextBox runat="server" ID="tbQuantity" CssClass="form-control text-uppercase" name="quantity" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbUnitofMeasurement">Unit of Measurement</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:TextBox runat="server" ID="tbUnitofMeasurement" CssClass="form-control text-uppercase" name="unitofmeasurement"></asp:TextBox>
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
                                        <asp:TextBox runat="server" ID="tbAmount" CssClass="form-control text-uppercase" name="amount" onkeypress="return isNumberKey(event)"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbAssetNo">Fixed/Quasi Fixed Asset No.</label>
                                        <asp:TextBox runat="server" ID="tbAssetNo" CssClass="form-control text-uppercase" name="assetno"></asp:TextBox>
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
                                        <asp:TextBox runat="server" ID="tbOD" CssClass="form-control text-uppercase" name="od"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbContainer">Container</label>
                                        <asp:TextBox runat="server" ID="tbContainer" CssClass="form-control text-uppercase" name="container"></asp:TextBox>
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
                                        <asp:TextBox runat="server" ID="tbPEZASeal" CssClass="form-control text-uppercase" name="peza"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tbDSRDRNo">DS/RDR Number</label>
                                        <asp:TextBox runat="server" ID="tbDSRDRNo" CssClass="form-control text-uppercase" name="dsrdrno"></asp:TextBox>
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
            <asp:AsyncPostBackTrigger ControlID="BtnSubmit" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upModalConfirm" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalConfirm" data-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="row">
                                <asp:TextBox runat="server" ID="tbWorkFlowID" CssClass="form-control-sm" Enabled="false" Visible="false"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbApproverID" CssClass="form-control-sm" Enabled="false" Visible="false"></asp:TextBox>
                                <asp:TextBox runat="server" ID="tbAssignedID" CssClass="form-control-sm" Enabled="false" Visible="false"></asp:TextBox>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class="col-form-label-sm">Comment</label>
                                        <asp:TextBox runat="server" ID="tbComment" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <!-- /.row -->
                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnApprove" CssClass="btn btn-success btn-sm" Text="Approve" OnClick="BtnApprove_OnClick" Width="120px" />
                            <asp:Button runat="server" ID="BtnRequestChange" Text="Request Change" CssClass="btn btn-primary btn-sm" OnClick="BtnRequestChange_OnClick" Width="120px" />
                            <asp:Button runat="server" ID="BtnReassignTask" Text="Reassign Task" CssClass="btn btn-primary btn-sm" OnClick="BtnReassignTask_OnClick" Width="120px" />
                            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 120px">Cancel</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.Modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upRequestChange" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalRequestChange" data-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Request Change</h5>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <label class="col-form-label-sm">Assigned</label>
                                        </div>
                                        <div class="col-sm-9">
                                            <asp:TextBox runat="server" ID="tbAssignedto" CssClass="form-control-sm" Enabled="false" Width="100%"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <asp:TextBox runat="server" ID="tbRequestChangeComment" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.form-group -->
                            </div>
                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnSaveRequestChange" CssClass="btn btn-primary btn-sm" Text="Save" OnClick="BtnSaveRequestChange_OnClick" Width="70px" />
                            <asp:Button runat="server" ID="BtnCancelRequestChange" CssClass="btn btn-danger btn-sm" Text="Cancel" OnClick="BtnCancelRequestChange_OnClick" Width="70px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.Modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upReassignTask" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalReassignTask" data-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Re-assign Task</h5>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="row mb-1">
                                            <div class="col-sm-1">
                                                <label class="col-form-label-sm">To</label>
                                            </div>
                                            <div class="col-sm-11">
                                                <asp:DropDownList runat="server" ID="ddlReassignto" CssClass="form-control-sm select2" Width="100%" name="reassignto"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <asp:TextBox runat="server" ID="tbReassigntoComment" CssClass="form-control" TextMode="MultiLine" placeholder="Comment"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnSaveReassignTask" CssClass="btn btn-primary btn-sm" Text="Save" OnClick="BtnSaveReassignTask_OnClick" Width="70px" />
                            <asp:Button runat="server" ID="BtnCancelReassignTask" CssClass="btn btn-danger btn-sm" Text="Cancel" OnClick="BtnCancelReassignTask_OnClick" Width="70px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.Modal -->
            </section>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">

        $(function () {
            $('#<%=ddlTypeofItem.ClientID%>').on('change', function () {
                x = $(this).val();
                array = x + ""
                $('#<%=hfTypeofItem.ClientID%>').val(array);
            });

            var items = ($('#<%=hfTypeofItem.ClientID%>').val().split(','));
            $("#<%=ddlTypeofItem.ClientID%>").val(items).trigger('change');

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

            if ($(".ControlNo").val() != '[AUTOMATIC]') {
                $('#tbControlNoHelpBlock').prop('hidden', true);
                var items = ($('#<%=hfTypeofItem.ClientID%>').val().split(','));
                $("#<%=ddlTypeofItem.ClientID%>").val(items).trigger('change');
            }

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {

                $('#<%=ddlTypeofItem.ClientID%>').on('change', function () {
                    x = $(this).val();
                    array = x + ""
                    $('#<%=hfTypeofItem.ClientID%>').val(array);
                });

                var items = ($('#<%=hfTypeofItem.ClientID%>').val().split(','));
                $("#<%=ddlTypeofItem.ClientID%>").val(items).trigger('change');

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
                icon: 'warning',
                title: 'Please complete the required item information.'
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

        function ReassignToAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Please select re-assign to.'
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

        function ShowOthers() {
            $('#Others').removeAttr('hidden');
        }

    </script>
</asp:Content>
