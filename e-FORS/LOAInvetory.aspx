<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="maincontent" runat="Server">
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
    <section class="content">
        <div class="container-fluid">
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">LOA Inventory</h3>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>LOANO</label>
                                <select name="LOANO" id="selectLOANO" class="form-control select2" style="width: 100%">
                                    <option selected value="0">Choose...</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>QTY</label>
                                <input type="text" name="QTY" id="txtAmount" class="form-control text-uppercase">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>AMT</label>
                                <input type="text" name="AMT" id="txtQuantity" class="form-control text-uppercase">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <button type="submit" id="btnSave" class="btn btn-primary">Save</button>
                        <button type="button" id="btnClear" class="btn btn-danger">Clear</button>
                    </div>
                </div>

                <div class="card-body" style="width: 100%; overflow: scroll">
                    <table id="tableLOA" class="table table-bordered table-striped" style="width: 100%; white-space: pre-wrap">
                    </table>
                </div>

                <div class="card-footer">
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

