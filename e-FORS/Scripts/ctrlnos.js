var dtItems = [];

//declare row vars
var row1 = null,
    row2 = null;

var $container = $("#MyTable");

function GetCtrlNos(callback) {
    $.ajax({
        url: "TasksJS.aspx/GetCtrlNos",
        type: "post",
        data: "{}",
        dataType: "json",
        contentType: "application/json;charset=utf-8",
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

function GenerateCtrlNo(ctrlno) {
    return "EFORS-"+ (ctrlno + 1).toString();
}

function DrawTable(data, callback) {
    console.log(data);
    columnNames = Object.keys(data[0]);
    var columns = ["Delete", "ItemCode"];
    let d = [data.length];
    let xColWidth = [columns.length];
    let colType = [columns.length];
    for (var i in data) {
        let e = [columns.length];
        for (var j in columns) {
            var colName = columns[j];
            xColWidth[j] = 100;
            e[j] = data[i][colName];
            colType[j] = { type: 'text', readOnly: false, wordWrap: false, className: 'htCenter' };
            if (['Delete'].includes(colName)) {
                colType[j] = { readOnly: true, renderer: renderButtons };
            }
        }
        d[i] = e;
    }
    var config = {
        data: d,
        colHeaders: columns,
        columns: colType,
        csvHeaders: true,
        height: '200px',
        width: '100%',
        stretchH: 'all',
        className: 'custom-table',
        filters: true,
        filteringCaseSensitive: true,
        afterSelectionEnd(x1, y1, x2, y2) {
            //add this because of bug
            if ((x1 <= x2 && y1 < y2) || (x1 < x2 && y1 <= y2) || (x1 == x2 && y1 == y2)) {
                row1 = x1;
                if (x1 == 0)
                    row2 = parseInt(x2 + 1);
                else
                    row2 = x2;
            }
            else if ((x1 >= x2 && y1 > y2) || (x1 > x2 && y1 >= y2)) {
                row1 = x2;
                if (x2 == 0)
                    row2 = parseInt(x1 + 1);
                else
                    row2 = x1;
            }
            else if (x1 < x2 && y1 > y2) {
                row1 = x1;
                row2 = x2;
            }
            else if (x1 > x2 && y1 < y2) {
                row1 = x2;
                row2 = x1;
            }
        },
        //afterSelection: function (r, c) {
        //    console.log(this);
        //    //var data = this.getDataAtRow(r);
        //    //console.log(data[1]);
        //},
        licenseKey: 'non-commercial-and-evaluation'
    };

    function renderButtons(instance, td, row, col, prop, value, cellProperties) {
        td.className = "htCenter";
        td.innerHTML = "<button type='button' class='btn btn-sm btn-delete-row'><i class='fas fa-trash'></i></button>";
    }

    //MyTable = new Handsontable(document.getElementById("MyTable"), config);
    MyTable = $container.handsontable(config);

    if (callback !== undefined) {
        callback(MyTable);
    }
}

function AfterChange(data, hook) {
    console.log(data, hook);
}

function DataMapping(header, value) {
    var obj = [];
    for (var row in value) {
        var newRow = {};
        for (var col in header) {
            newRow[header[col]] = value[row][col];
        }
        obj.push(newRow);
    }
    return obj;
}

$(function () {
    $("#btnSave").click(function () {
        GetCtrlNos(function (e) {
            if (e.length === 0) {
                ctrlno = 0;
            }
            else {
                var ctrlno = e[e.length]["CtrlNo"];
            }
            ctrlno = GenerateCtrlNo(ctrlno);
            $("#txtCtrlNo").val(ctrlno);
            for (var i in dtItems) {
                dtItems[i]["CtrlNo"] = ctrlno;
            }
            console.log(dtItems);
        });
    });
    $("#btnPlus").click(function () {
        var itemcode = $("#txtItemCode").val();
        var newRow = {};
        newRow["ItemCode"] = itemcode;
        dtItems.push(newRow);

        DrawTable(dtItems, function (e) {
        });
    });

    $(document).on('click', 'button', function (e) {

        //gets instance of handsontable
        var instance = $container.handsontable('getInstance');

        var elem = $(this);
        if (elem.hasClass('btn-delete-row')) {
            if (confirm("Are you sure you want to delete this item?")) {
                instance.alter('remove_row', row1);
                var headers = instance.getColHeader();
                var data = instance.getSourceData();
                var newData = DataMapping(headers, data);
                dtItems = newData;
            }
        }
    });
});