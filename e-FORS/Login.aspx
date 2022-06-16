<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AdminLTE 3 | Log in</title>

    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
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

    <style type="text/css">
        #cbRemember {
            content: "";
            display: inline-block;
            position: absolute;
            width: 22px;
            height: 22px;
            border: 1px solid #D3CFC8;
            border-radius: 0;
        }
    </style>
</head>
<body class="hold-transition login-page">
    <form id="form1" method="post" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="upTable" runat="server">
            <ContentTemplate>
                <div class="login-box">
                    <div class="login-logo">
                        <a href="Login.aspx"><b>e-</b>FORS</a>
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
                                <div class="col-8">
                                    <div class="icheck-primary">
                                        <asp:CheckBox runat="server" ID="cbRemember" type="checkbox" />
                                        <label for="cbRemember">Remember Me</label>
                                    </div>
                                </div>
                                <!-- /.col -->
                                <div class="col-4">
                                    <asp:Button runat="server" ID="BtnLogin" class="btn btn-primary btn-block" Text="Sign In" OnClick="BtnLogin_Click" />
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
            toastr.error('Login failed, please check your username and password.')
        }
        function InputUsername() {
            toastr.error('Login failed, please put username.')
        }
        function InputPassword() {
            toastr.error('Login failed, please put your password.')
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
