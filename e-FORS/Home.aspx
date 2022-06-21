<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>


<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="script" runat="Server">
    <%--<script type="text/javascript">
        $(document).ready(function () {
            GetMyTasksCount();
        });

        function GetMyTasksCount() {
            $.ajax({
                type: "POST",
                url: "Home.aspx/GetMyTasksCount",
                data: "{}",
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function (e) {
                    var d = JSON.parse(e.d);
                    $("#MyTasksCount").append(d[0]["MyTasksCount"]);
                },
                error: function (err) {
                    console.log(err)
                }
            });
        }
    </script>--%>
</asp:Content>

