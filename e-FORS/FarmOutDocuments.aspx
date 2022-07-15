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
                                                <asp:LinkButton runat="server" ID="LnkBtnView" CssClass="btn btn-info" Text="View" OnClick="LnkBtnView_Click" />
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.form-group -->
                                    <div class="form-group">
                                        <label>Document Format to be Used</label>
                                        <span style="color: #ff0000">*</span>
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
                                    <div class="form-group">
                                        <label id="lblLOAType" hidden>LOA Type</label>
                                        <asp:TextBox runat="server" ID="tbLOAType" CssClass="form-control" Visible="false"></asp:TextBox>
                                        <%--<asp:DropDownList runat="server" ID="ddlLOAType" CssClass="form-control select2" Width="100%" OnSelectedIndexChanged="ddlLOAType_SelectedIndexChanged" AutoPostBack="true" Enabled="false"></asp:DropDownList>--%>
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
                                        <span style="color: #ff0000">*</span>
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
                                        <span style="color: #ff0000">*</span>
                                        <div class="input-group">
                                            <asp:DropDownList runat="server" ID="ddlPreparedby" CssClass="form-control select2"></asp:DropDownList>
                                            <div class="input-group-append">
                                                <asp:Button runat="server" ID="BtnConfirm1" CssClass="btn btn-warning" Text="Confirm" Enabled="false" OnClick="BtnConfirm1_OnClick" />
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
                                        <span style="color: #ff0000">*</span>
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
            <%--<asp:AsyncPostBackTrigger ControlID="ddlLOAType" EventName="SelectedIndexChanged" />--%>
            <%--<asp:AsyncPostBackTrigger ControlID="ddlLOANo" EventName="SelectedIndexChanged" />--%>
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
                            <asp:Button runat="server" ID="BtnApprove" CssClass="btn btn-info btn-sm" Text="Approve" OnClick="BtnApprove_OnClick" Width="110px" />
                            <button type="button" class="btn btn-info btn-sm" data-dismiss="modal" style="width: 110px">Cancel</button>
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
                            <asp:Button runat="server" ID="BtnSaveRequestChange" CssClass="btn btn-info btn-sm" Text="Save" OnClick="BtnSaveRequestChange_OnClick" Width="110px" />
                            <asp:Button runat="server" ID="BtnCancelRequestChange" CssClass="btn btn-info btn-sm" Text="Cancel" OnClick="BtnCancelRequestChange_OnClick" Width="110px" />
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
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <div class="row mb-1">
                                            <div class="col-md-4">
                                                <label for="ddlReassignto">&nbsp; &nbsp; &nbsp;Re-assign to:</label>
                                                <span style="color: #ff0000">*</span>
                                            </div>
                                            <div class="col-md-8">
                                                <asp:DropDownList runat="server" ID="ddlReassignto" CssClass="form-control select2 ddlReassignto" Width="100%" name="reassignto"></asp:DropDownList>
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
                            <asp:Button runat="server" ID="BtnSaveReassignTask" CssClass="btn btn-info btn-sm" Text="Save" OnClick="BtnSaveReassignTask_OnClick" Width="110px" />
                            <asp:Button runat="server" ID="BtnCancelReassignTask" CssClass="btn btn-info btn-sm" Text="Cancel" OnClick="BtnCancelReassignTask_OnClick" Width="110px" />
                        </div>
                    </div>
                    <!-- /.modal-content -->
                </div>
                <!-- /.modal-dialog -->
            </div>
            <!-- /.modal -->
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

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript">
        $(function () {
            $('#<%=ddlControlNo.ClientID%>').on('change', function () {
                x = $('#<%=tbFarmOutControlNo.ClientID%>').val() + ',' + $(this).val();
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
                    x = $('#<%=tbFarmOutControlNo.ClientID%>').val() + ',' + $(this).val();
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
    </script>
</asp:Content>



