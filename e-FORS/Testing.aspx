<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Testing.aspx.cs" Inherits="Testing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="style" runat="Server">
    <link href="AdminLTE-3.2.0/plugins/fonts/Poppins.css" rel="stylesheet" />
    <link href="AdminLTE-3.2.0/plugins/handsontable/css/handsontable.full.min.css" rel="stylesheet" />
    <style type="text/css">
        .hidden-label {
            color: transparent;
            text-shadow: none;
            background-color: transparent;
            border: 0;
        }

        .overlay {
            display: none;
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 999;
            background: rgba(255,255,255,0.8) url("Images/Spinner.gif") center no-repeat;
        }
        /* Turn off scrollbar when body element has the loading class */
        body.loading {
            overflow: hidden;
        }
            /* Make spinner image visible when body element has the loading class */
            body.loading .overlay {
                display: block;
            }

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
    <div class="overlay"></div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        function GetFarmOut(controlno, callback) {
            var FarmOutDetails = {};
            FarmOutDetails.ControlNo = controlno;
            $.ajax({
                type: "POST",
                url: "FarmOutRequestForm.aspx/GetFarmOut",
                data: JSON.stringify({ fo: FarmOutDetails }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    $('.overlay').show();
                },
                complete: function () {
                    $('.overlay').hide();
                },
                success: function (e) {
                    var d = JSON.parse(e.d);
                    if (callback !== undefined) {
                        callback(d);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        $(function () {
            GetFarmOut('EFORS-PR WHO-22-12-0818', function (e) {
                console.log(e['Table'][0]);
                data = e['Table'][0];
                var DataForPrint = [];
                for (var i in data) {
                    var newRow = {}
                    newRow['field'] = i;
                    newRow['value'] = data[i];
                    DataForPrint.push(newRow);

                }
                console.log(DataForPrint);
                var body = [];
                for (var i in DataForPrint) {
                    if (i % 2 == 1) {
                        body.push('{  border: [true, true, false, true], text: "' + DataForPrint[i]["field"] + '"}, {border: [false, true, true, true], text: "' + DataForPrint[i]["value"] + '"}]');
                    }
                    else {
                        body.push('[{  border: [true, true, false, true], text: "' + DataForPrint[i]["field"] + '"}, {border: [false, true, true, true], text: "' + DataForPrint[i]["value"] + '"}');
                    }
                }
                console.log(body.toString());
                body = body.toString();

                var dd = {
                    content: [
                        { text: 'EPSON PRECISION PHILIPPINES INC.', style: 'header' },
                        { text: 'FARM-OUT REQUEST FORM', style: 'title' },
                        {
                            style: 'tableExample',
                            table: {
                                widths: ['*', '*', '*', '*'],
                                body: [
                                   body.toString()
                                ]
                            }
                        },
                    ],
                    styles: {
                        header: {
                            fontSize: 16,
                            bold: true,
                            lineHeight: 2
                        },
                        title: {
                            fontSize: 18,
                            bold: true,
                            lineHeight: 2,
                            alignment: 'center'
                        }
                    }
                };
                console.log(dd);
                pdfMake.createPdf(dd).open();
            })
        });

        //var controlno = 'EFORS-VP PE-22-12-0015';
        //var division = 'VP';
        //var dd = {
        //    content: [
        //        { text: 'EPSON PRECISION PHILIPPINES INC.', style: 'header' },
        //        { text: 'FARM-OUT REQUEST FORM', style: 'title' },
        //        {
        //            style: 'tableExample',
        //            table: {
        //                widths: ['*', '*', '*', '*'],
        //                body: [
        //                    [
        //                        {
        //                            border: [true, true, false, true],
        //                            text: 'Control Number: '
        //                        },
        //                        {
        //                            border: [false, true, true, true],
        //                            text: controlno
        //                        },
        //                        {
        //                            border: [false, true, false, true],
        //                            text: 'Division: '
        //                        },
        //                        {
        //                            border: [false, true, true, true],
        //                            text: division
        //                        },
        //                    ],
        //                    [
        //                        {
        //                            border: [true, true, false, true],
        //                            text: 'Control Number: '
        //                        },
        //                        {
        //                            border: [false, true, true, true],
        //                            text: controlno
        //                        },
        //                        {
        //                            border: [false, true, false, true],
        //                            text: 'Division: '
        //                        },
        //                        {
        //                            border: [false, true, true, true],
        //                            text: division
        //                        },
        //                    ]

        //                    //['Control Number: ', controlno, 'Division: ', division],
        //                    //['Nature of Item: ', controlno, 'Transfer to: ', division],
        //                    //['Type of Item: ', controlno, 'Classification of Item: ', division],
        //                ]
        //            }
        //        },
        //    ],
        //    styles: {
        //        header: {
        //            fontSize: 16,
        //            bold: true,
        //            lineHeight: 2
        //        },
        //        title: {
        //            fontSize: 18,
        //            bold: true,
        //            lineHeight: 2,
        //            alignment: 'center'
        //        }
        //    }
        //};
        //pdfMake.createPdf(dd).open();
    </script>
</asp:Content>
