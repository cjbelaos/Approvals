﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RequestFormPrint.aspx.cs" Inherits="RequestFormPrint" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <CR:CrystalReportViewer runat="server" ID="CrystalReportViewer1" />
        </div>
    </form>
</body>
</html>
