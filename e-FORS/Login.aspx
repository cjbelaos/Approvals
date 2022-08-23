<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>e-FORS | Login</title>

    <!-- Google Font: Source Sans Pro -->
    <link href="AdminLTE-3.2.0/plugins/fonts/Poppins.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="AdminLTE-3.2.0/plugins/fontawesome-free/css/all.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="AdminLTE-3.2.0/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="AdminLTE-3.2.0/dist/css/adminlte.min.css">
    <!-- Toastr -->
    <link rel="stylesheet" href="AdminLTE-3.2.0/plugins/toastr/toastr.min.css">
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="AdminLTE-3.2.0/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">

    <link rel="shortcut icon" href="Images/e.ico" type="image/x-icon" />
</head>
<body class="hold-transition login-page">
    <form id="form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upTable"
            ClientIDMode="Predictable" ViewStateMode="Inherit">
            <ProgressTemplate>
                <div class="submit-progress hidden" runat="server" id="divProgress">
                    <img src="Images/Spinner.gif" />   
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="upTable" runat="server">
            <ContentTemplate>
                <div class="login-box">
                    <div class="login-logo">
                        <a href="Login.aspx" class="brand-link">
                            <img src="Images/e.png" alt="e-FORS Logo" class="brand-image float-none" style="opacity: .8"><b>-</b>FORS</a>
                    </div>
                    <!-- /.login-logo -->
                    <div class="card">
                        <div class="card-body login-card-body" style="background-image: url(Images/Epson.png); background-repeat: no-repeat">
                            <p class="login-box-msg">Login Form</p>

                            <div class="input-group mb-3">
                                <asp:TextBox ID="tbUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group mb-3">
                                <asp:TextBox ID="tbPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Password"></asp:TextBox>
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-4">
                                    <asp:Button runat="server" ID="BtnLogin" CssClass="btn btn-primary btn-block" Text="Sign In" Width="100px" OnClick="BtnLogin_Click" />
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>

                </div>
                <!-- /.login-card-body -->
                </div>
                </div>
                <!-- /.login-box -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <!-- jQuery -->
    <script src="AdminLTE-3.2.0/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="AdminLTE-3.2.0/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Toastr -->
    <script src="AdminLTE-3.2.0/plugins/toastr/toastr.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="AdminLTE-3.2.0/plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- AdminLTE App -->
    <script src="AdminLTE-3.2.0/dist/js/adminlte.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#tbUsername').focus();
        });

        function LoginFailed() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Login failed, please check your username and password.'
            })
        }
        function InputUsername() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Login failed, please put your username.'
            })
        }
        function InputPassword() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Login failed, please put your password.'
            })
        }

        function UserAndPassIsEmpty() {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000
            });
            Toast.fire({
                icon: 'error',
                title: 'Please put username and password!'
            })
        }
    </script>
</body>
</html>
