<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TasksJS.aspx.cs" Inherits="TasksJS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
    <link href="AdminLTE-3.2.0/plugins/fonts/Poppins.css" rel="stylesheet" />
    <link href="AdminLTE-3.2.0/plugins/handsontable/css/handsontable.full.min.css" rel="stylesheet" />

    <style type="text/css">
        .custom-table thead th {
            background-color: #d7f1e1;
            font-weight: bold;
            font-family: 'Poppins', sans-serif;
            align-content: flex-start;
        }

        .custom-table tbody tr {
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }
    </style>

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
            <div class="card-body border">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Control No.</label>
                            <input type="text" id="txtCtrlNo" class="form-control" disabled />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Item Type</label>
                            <input type="text" id="txtItemType" class="form-control" />
                        </div>
                    </div>
                </div>
                <button type="button" id="btnAdd" class="btn btn-primary" data-toggle="collapse" data-target="#collapse" aria-expanded="false" aria-controls="collapse">Add</button>
            </div>
            <div class="card-body collapse" id="collapse">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Item Code</label>
                            <input type="text" id="txtItemCode" class="form-control" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group" style="margin-top: 31px">
                            <button type="button" id="btnPlus" class="btn btn-primary"><i class="fas fa-plus"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-body">
                <div id="MyTable"></div>
                <button type="button" id="btnSave" class="btn btn-primary">Save</button>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script src="AdminLTE-3.2.0/plugins/handsontable/js/handsontable.full.min.js"></script>
    <script src="AdminLTE-3.2.0/plugins/exceljs/js/exceljs.min.js"></script>
    <script src="AdminLTE-3.2.0/plugins/xlsx/xlsx.full.min.js"></script>
    <script src="Scripts/ctrlnos.js"></script>
</asp:Content>


