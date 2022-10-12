<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LiquidationLedger.aspx.cs" Inherits="LiquidationLedger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
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
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="card-body">
                            <table>
                                <tr>
                                    <td style="width: 200px">
                                        <asp:DropDownList runat="server" ID="ddlLOANo" CssClass="form-control select2" placeholder="LOA No.">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:LinkButton runat="server" ID="lnkDownload" CssClass="btn btn-primary" OnClick="LnkDownload_Click">
                                            <i class="fas fa-download"></i>
                                        </asp:LinkButton>

                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tableLiquidationLedger" class="table table-bordered table-condensed table-hover table-sm" style="white-space: nowrap;">
                    </table>
                </div>
                <!-- /.card-body -->

                <div class="card-footer">
                </div>
                <!-- /.card-footer -->

            </div>
            <!-- /.card -->
        </div>
    </section>

    <div class="modal fade" id="modalInfo">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body">
                    <div class="card-body" style="width: 100%; overflow: scroll">
                        <table id="tableLiquidInfo" class="table table-bordered table-condensed table-hover table-sm" style="white-space: nowrap;">
                        </table>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        var MainTable;
        var SubTable;
        $(document).ready(function () {

            $('select').select2();

            GetLiquidationLedger('');
            $("#<%=ddlLOANo.ClientID %>").on('change', function () {
                let loano = $(this).val();
                GetLiquidationLedger(loano);
            });

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
              
                //Initialize Select2 Elements
                $('.select2').select2()
            }
        });

        function GetLiquidationLedger(loano, callback) {
            var ReportDetails = {};
            ReportDetails.LOANO = loano;
            $.ajax({
                url: "LiquidationLedger.aspx/GetLiquidationLedger",
                type: "POST",
                data: JSON.stringify({ rd: ReportDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    if (MainTable !== undefined && MainTable !== null) {
                        MainTable.clear().destroy();
                    }
                    MainTable = $("#tableLiquidationLedger").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: false,
                        data: d['Table'],
                        select: { items: 'row', style: 'single' },
                        columns: [
                            { data: "LOANO", title: 'LOA No.' },
                            { data: "SUPPLIERID", title: 'Supplier ID' },
                            { data: "SUPPLIER", title: 'Supplier' },
                            { data: "TYPEOFITEM", title: 'Description' },
                            { data: "PEZADOCUMENTNO", title: 'PEZA Document No.' },
                            {
                                data: "DATEOFTRANSFER", title: 'Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                            { data: "TOTALQUANTITY", title: 'Quantity' },
                            { data: "TOTALAMOUNT", title: 'Amount' },
                        ],
                        order: [[6, 'desc']],
                    });
                    MainTable.on('select', function () {
                        let supplierid = MainTable.rows({ selected: true }).data()[0]['SUPPLIERID'];
                        let loano = MainTable.rows({ selected: true }).data()[0]['LOANO'];
                        let description = MainTable.rows({ selected: true }).data()[0]['TYPEOFITEM'];
                        let docno = MainTable.rows({ selected: true }).data()[0]['PEZADOCUMENTNO'];
                        let date = moment(MainTable.rows({ selected: true }).data()[0]['DATEOFTRANSFER']).format("L");

                        // now do what you need to do wht the row data
                        console.log(supplierid);
                        console.log(loano);
                        console.log(description);
                        console.log(docno);
                        console.log(date);

                        GetInfo(supplierid, loano, description, docno, date);
                        $('#modalInfo').modal('show');
                    });
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        function GetInfo(supplierid, loano, description, docno, date, callback) {
            var LiquidationLedgerDetails = {};
            LiquidationLedgerDetails.LOANO = loano;
            LiquidationLedgerDetails.SUPPLIERID = supplierid;
            LiquidationLedgerDetails.TYPEOFITEM = description;
            LiquidationLedgerDetails.PEZADOCUMENTNO = docno;
            LiquidationLedgerDetails.DATEOFTRANSFER = date;
            $.ajax({
                type: "POST",
                url: "LiquidationLedger.aspx/GetLiquidInfo",
                data: JSON.stringify({ ll: LiquidationLedgerDetails }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                    console.log(e);
                    if (SubTable !== undefined && SubTable !== null) {
                        SubTable.clear().destroy();
                    }
                    SubTable = $("#tableLiquidInfo").DataTable({
                        paging: true,
                        lengthChange: true,
                        ordering: true,
                        info: true,
                        autoWidth: true,
                        responsive: false,
                        buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                        data: d,
                        columns: [
                            { data: "CONTROLNO", title: 'Control No.' },
                            { data: "SUPPLIER", title: 'Supplier' },
                            { data: "LOANO", title: 'LOA No.' },
                            { data: "DOCUMENTFORMAT", title: 'Format' },
                            { data: "PEZADOCUMENTNO", title: 'Document No.' },
                            { data: "TYPEOFITEM", title: 'Description' },
                            { data: "QUANTITY", title: 'Quantity' },
                            { data: "AMOUNT", title: 'Amount' },
                            {
                                data: "DATEOFTRANSFER", title: 'Date', render: function (e) {
                                    return moment(e).format("L");
                                },
                            },
                            //{ data: "PAGEID", title: 'Page', visible: false, searchable: false },
                        ],
                        order: [[0, 'desc']],
                        columnDefs: [
                            {
                                targets: 0,
                                render: function (data, type, row, meta) {
                                    return '<a href="FarmOutDocuments.aspx?controlno=' + data + '" style="font-weight: bold; color: #cc0000">' + data + '</a>';
                                },
                            },
                        ],
                    });
                },
                error: function (error) {
                    console.log(error);
                }
            });
        }


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

