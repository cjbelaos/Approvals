<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginTest.aspx.cs" Inherits="LoginTest" %>

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
                                <%--<asp:TextBox ID="tbUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>--%>
                                <input type="text" id="txtUsername" class="form-control" placeholder="Username" />
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group mb-3">
                                <%--<asp:TextBox ID="tbPassword" TextMode="Password" runat="server" CssClass="form-control" placeholder="Password"></asp:TextBox>--%>
                                <input type="password" id="txtPassword" autocomplete="off" class="form-control" placeholder="Password" />
                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <%--                                <div class="col-md-4"></div>
                                <div class="col-md-4"> <asp:Button runat="server" ID="BtnLogin" CssClass="btn btn-primary btn-block" Text="Sign In" Width="100px" OnClick="BtnLogin_Click" /></div>
                                <div class="col-md-4"></div>--%>
                                <btn type="button" id="btnLogin" class="btn btn-primary btn-block">Sign In</btn>
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

        var systemName;
        var link;

        function GetSession(callback) {
            $.ajax({
                url: 'SharedService.asmx/GetSession',
                method: 'POST',
                data: '{}',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                },
            });
        }

        function SetSession(userid, username, callback) {
            $.ajax({
                url: 'SharedService.asmx/SetSession',
                method: 'POST',
                data: JSON.stringify({link: '', userid: userid, username: username}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                },
            });
        }

        function GetSystemName(callback) {
            $.ajax({
                url: 'LoginTest.aspx/GetSystemName',
                method: 'POST',
                data: '{}',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                },
            });
        }

        function GetUser(systemname, username, password, callback) {
            var LoginDetails = {};
            LoginDetails.system = systemname;
            LoginDetails.username = username;
            LoginDetails.password = password;
            LoginDetails.ldap = false;
            $.ajax({
                url: 'LoginTest.aspx/GetUser',
                method: 'POST',
                data: JSON.stringify({ld: LoginDetails}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                },
            });
        }

        function CheckIfAuthenticated(username, password, callback) {
            $.ajax({
                url: 'LoginTest.aspx/CheckIfAuthenticated',
                method: 'POST',
                data: JSON.stringify({Username: username, Password: password}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                },
            });
        }

        $(function () {
            GetSession(function (d) {
                console.log(d);
                console.log(d['Link']);
            });
            GetSystemName(function (d) {
                systemName = d;
            });
            $('#tbUsername').focus();
        });

        $('#btnLogin').click(function () {
            if ($('#txtUsername') !== '' && $('#txtPassword') !== '') {
                var username = $('#txtUsername').val();
                var password = $('#txtPassword').val();
                GetUser(systemName, username, password, function (d) {
                    if (d.length > 0) {
                        var userid = d[0]['user_id'].toUpperCase();
                        var username = d[0]['user_name'].toUpperCase();
                        SetSession(userid, username, function () {
                            if (link === undefined) {
                                location.replace('Home.aspx');
                            }
                            else {
                                console.log(link);
                                location.replace(link);
                            }
                            
                        });
                        
                    }
                    else {
                        console.log(username, password);
                        CheckIfAuthenticated(username, password, function (d) {
                            console.log(d);
                        });
                    }
                });
            }
        });
    </script>
</body>
</html>
