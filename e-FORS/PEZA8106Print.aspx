<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PEZA8106Print.aspx.cs" Inherits="PEZA8106Print" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function fixform() {
            if (opener.document.getElementById("aspnetForm").target != "_blank") return;
            opener.document.getElementById("aspnetForm").target = "";
            opener.document.getElementById("aspnetForm").action = opener.location.href;
        }
    </script>
</head>
<body onload="fixform()">
    <form id="form1" runat="server">
        <div id ="dv" runat ="server">
            <CR:CrystalReportViewer runat="server" ID="CrystalReportViewer1" />
        </div>
    </form>
</body>
</html>
