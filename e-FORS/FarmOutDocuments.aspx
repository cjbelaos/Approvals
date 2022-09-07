<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FarmOutDocuments.aspx.cs" Inherits="FarmOutDocuments" %>

<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Forms</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Home.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Farm-out Documents</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="upTable" runat="server">
        <ContentTemplate>
            <section class="content">
                <div class="container-fluid">
                    <div class="card card-primary">
                        <div class="card-header">
                            <h3 class="card-title">Farm-out Documents</h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Farm-out Control No.</label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="tbFarmOutControlNo" CssClass="form-control" Enabled="false"></asp:TextBox>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnCancel" CssClass="btn btn-danger" Text="Cancel" OnClick="BtnCancel_Click" Visible="false" />
                                                <asp:LinkButton runat="server" ID="LnkBtnView" CssClass="btn btn-info" Text="View" OnClick="LnkBtnView_Click" />
                                                <asp:Button runat="server" ID="BtnPrintRF" CssClass="btn btn-info" Text="Print" OnClick="BtnPrintRF_Click" Visible="false" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Document Format to be Used</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlDocumentFormattobeUsed" CssClass="form-control select2" Width="100%" OnSelectedIndexChanged="ddlDocumentFormattobeUsed_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                        <div class="card">
                                            <div class="card-body p-0">
                                                <asp:GridView runat="server" ID="GrvPrint" BorderStyle="None" CssClass="table table-sm table-borderless" ShowHeaderWhenEmpty="true" AutoGenerateColumns="true" OnRowCommand="GrvPrint_RowCommand" Visible="false" OnRowDataBound="GrvPrint_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:Button ID="BtnPrint" runat="server" Text="Print"
                                                                    CommandName="Print"
                                                                    CommandArgument='<%#Eval("Task") %>'
                                                                    CssClass="btn btn-sm btn-info BtnPrint" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>PEZA Document No.</label>
                                        <asp:TextBox runat="server" ID="tbPEZADocumentNo" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div runat="server" id="divFiles" class="col-md-6" visible="false">
                                    <label>Attached Files</label>
                                    <div class="card">
                                        <div class="card-body p-0">
                                            <asp:GridView runat="server" ID="gvFiles" BorderStyle="None" CssClass="table table-sm table-borderless table-hover table-striped"
                                                AutoGenerateColumns="false">
                                                <HeaderStyle CssClass="thead-light" />
                                                <Columns>
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
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Gatepass No.</label>
                                        <asp:TextBox runat="server" ID="tbGatepassNo" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div runat="server" id="divLOA" class="form-group">
                                        <label>LOA No.</label>
                                        <asp:TextBox runat="server" ID="tbLOANo" CssClass="form-control" Enabled="false"></asp:TextBox>
                                        <%--<asp:DropDownList runat="server" ID="ddlLOANo" CssClass="form-control select2" Width="100%" OnSelectedIndexChanged="ddlLOANo_SelectedIndexChanged" AutoPostBack="true" Enabled="false"></asp:DropDownList>--%>
                                    </div>
                                    <!-- /.form-group -->
                                    <div runat="server" id="divSB" class="form-group">
                                        <label>Surety Bond No.</label>
                                        <asp:TextBox runat="server" ID="tbSBNo" CssClass="form-control" Enabled="false"></asp:TextBox>
                                        <%--<asp:DropDownList runat="server" ID="ddlSuretyBondNo" CssClass="form-control select2" Width="100%" Enabled="false"></asp:DropDownList>--%>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Container No.</label>
                                        <asp:TextBox runat="server" ID="tbContainerNo" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Plate No.</label>
                                        <asp:TextBox runat="server" ID="tbPlateNo" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>8105 Control No.</label>
                                        <asp:TextBox runat="server" ID="tb8105ControlNo" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>EPPI Authorized Signatory</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <asp:DropDownList runat="server" ID="ddlEPPIAuthorizedSignatory" CssClass="form-control select2" Width="100%"></asp:DropDownList>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>PEZA Examiner Signatory</label>
                                        <asp:TextBox runat="server" ID="tbPEZAExaminerSignatory" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>PEZA OIC Signatory</label>
                                        <asp:TextBox runat="server" ID="tbPEZAOICSignatory" CssClass="form-control" Enabled="false"></asp:TextBox>
                                    </div>
                                    <!-- /.form-group -->

                                </div>
                                <!-- /.col -->
                                <div class="col-md-6">
                                    <div runat="server" id="divLOAExp" class="form-group">
                                        <label>Expiry Date</label>
                                        <div class="input-group date" id="ExpiryDate1" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbExpiryDate1" CssClass="form-control datetimepicker-input" data-target="#ExpiryDate1" Enabled="false"></asp:TextBox>
                                            <div class="input-group-append" data-target="#ExpiryDate1" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div runat="server" id="divSBExp" class="form-group">
                                        <label>Expiry Date</label>
                                        <div class="input-group date" id="ExpiryDate2" data-target-input="nearest">
                                            <asp:TextBox runat="server" ID="tbExpiryDate2" CssClass="form-control datetimepicker-input" data-target="#ExpiryDate2" Enabled="false"></asp:TextBox>
                                            <div class="input-group-append" data-target="#ExpiryDate2" data-toggle="datetimepicker">
                                                <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label for="inputPEZASeal">PEZA Seal</label>
                                        <asp:TextBox runat="server" ID="tbPEZASeal" CssClass="form-control"></asp:TextBox>
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
                                        <label>Prepared by</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlPreparedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm1" CssClass="btn btn-warning" Text="Confirm" OnClick="BtnConfirm1_OnClick" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Status</label>
                                        <asp:Label runat="server" ID="lblStatus1" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Comment</label>
                                        <asp:Label runat="server" ID="lblComment1" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <div class="col-md-2" style="text-align: center">
                                    <div class="form-group-row">
                                        <label>Date</label>
                                        <asp:Label runat="server" ID="lblDate1" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Approved by</label>
                                        <span style="color: #ff0000; font-weight: bold">*</span>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlApprovedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm2" CssClass="btn btn-warning" Text="Confirm" Enabled="false" OnClick="BtnConfirm2_OnClick" />
                                            </div>
                                        </div>
                                        <small id="ApprovedbyHelpBlock" class="form-text text-danger" hidden>Required before saving.</small>
                                    </div>
                                </div>
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
                                    <!-- /.form-group -->
                                    <div class="form-group-row">
                                        <label>&nbsp; </label>
                                        <asp:Label runat="server" ID="lblDate2" CssClass="form-control-plaintext"></asp:Label>
                                    </div>
                                    <!-- /.form-group -->
                                </div>
                                <!-- /.col -->
                            </div>
                        </div>
                        <!-- /.card-body -->

                        <div class="card-footer">
                            <asp:Button runat="server" ID="BtnSave" CssClass="btn btn-primary" Text="Save" Width="70px" Enabled="false" OnClick="BtnSave_OnClick" />
                        </div>
                    </div>
                    <!-- /.card -->
                </div>
            </section>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlDocumentFormattobeUsed" EventName="SelectedIndexChanged" />
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
                                            <asp:TextBox runat="server" ID="tbAssigned" CssClass="form-control-sm" Enabled="false" Visible="false" Width="100%"></asp:TextBox>
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
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upPrint" runat="server">
        <ContentTemplate>
            <div class="modal fade" id="modalPrint">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">
                                <asp:Label ID="lblPrintTitle" runat="server"></asp:Label></h3>
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Date</label>
                                    <div class="input-group date" id="Date" data-target-input="nearest">
                                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control datetimepicker-input" data-target="#Date"></asp:TextBox>
                                        <div class="input-group-append" data-target="#Date" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- /.form-group -->
                                <div runat="server" id="divControlNo" class="form-group">
                                    <label runat="server" id="lblControlNo">ControlNo.</label>
                                    <asp:DropDownList runat="server" ID="ddlControlNo" multiple="multiple" data-placeholder="Choose..." CssClass="form-control select2" Width="100%" name="typeofitem"></asp:DropDownList>
                                    <asp:HiddenField runat="server" ID="hfControlNo" />
                                </div>
                                <!-- /.form-group -->
                            </div>
                        </div>
                        <div class="modal-footer justify-content-between">
                            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal" style="width: 70px">Close</button>
                            <asp:Button runat="server" ID="BtnDone" CssClass="btn btn-primary btn-sm" Text="Done" OnClick="BtnDone_Click" Width="70px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upCancel" runat="server">
        <ContentTemplate>
            <!-- Modal -->
            <div class="modal fade" id="modalCancel" data-backdrop="static">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-body justify-content-between">
                            <asp:TextBox runat="server" ID="txtReason" CssClass="form-control" TextMode="MultiLine" placeholder="Reason for cancellation"></asp:TextBox>
                        </div>
                        <div class="modal-footer justify-content-between">
                            <asp:Button runat="server" ID="BtnCancelRequest" CssClass="btn btn-danger btn-sm" Text="Yes" OnClick="BtnCancelRequest_Click" Width="70px" />
                            <button type="button" class="btn btn-success btn-sm" data-dismiss="modal" style="width: 70px">No</button>
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.Modal -->
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(function () {

            $('#<%=ddlControlNo.ClientID%>').on('change', function () {
                x = $(this).val();
                array = x + ""
                $('#<%=hfControlNo.ClientID%>').val(array);
            });

            //Initialize Select2 Elements
            $('.select2').select2()

            //Date picker
            $('#ExpiryDate1').datetimepicker({
                format: 'L'
            });
            $('#ExpiryDate2').datetimepicker({
                format: 'L'
            });
            $('#Date').datetimepicker({
                format: 'L'
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('#<%=ddlControlNo.ClientID%>').on('change', function () {
                    x = $(this).val();
                    //x = $(this).val();
                    array = x + ""
                    $('#<%=hfControlNo.ClientID%>').val(array);
                });

                //Initialize Select2 Elements
                $('.select2').select2()

                //Date picker
                $('#ExpiryDate1').datetimepicker({
                    format: 'L'
                });
                $('#ExpiryDate2').datetimepicker({
                    format: 'L'
                });
                $('#Date').datetimepicker({
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

        function FileNotExistAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'File not exist! Maybe it is remove or replace.'
            })
        }

        function NoCommentAlert() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'warning',
                title: 'Please state your reason for cancellation.'
            })
        }

        function ApprovedAlert() {
            toastr.success('Task successfully approve!')
        }

        function RequestChangeAlert() {
            toastr.success('Successfully Request Change!')
        }

        function ReassignAlert() {
            toastr.success('Task successfully reassigned!')
        }

        function ConfirmFailedAlert() {
            toastr.error('Save farm-out document first!')
        }

        function SelectReassignToAlert() {
            toastr.error('Please select reassign to.')
        }

        function GetControlNoPrinted8112() {
            var ctrlno = ($('#<%=hfControlNo.ClientID%>').val().split(','));
            console.log(ctrlno);
            $("#<%=ddlControlNo.ClientID%>").val(ctrlno).trigger('change');
        }
    </script>
</asp:Content>



