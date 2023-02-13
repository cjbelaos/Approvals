var fonts = {
    Roboto: {
        normal: '../adminlte-3.2.0/plugins/fonts/Roboto-Regular.ttf',
        bold: '../adminlte-3.2.0/plugins/fonts/Roboto-Medium.ttf',
        italics: '../adminlte-3.2.0/plugins/fonts/Roboto-Italic.ttf',
        bolditalics: '../adminlte-3.2.0/plugins/fonts/Roboto-MediumItalic.ttf'
    }
};

var printer = new PdfPrinter(fonts);
var fs = require('fs');

var docDefinition = {
	content: [
		'First paragraph',
		'Another paragraph, this time a little bit longer to make sure, this line will be divided into at least two lines'
	]
};

var pdfDoc = printer.createPdfKitDocument(docDefinition);
pdfDoc.pipe(fs.createWriteStream('pdfs/basics.pdf'));
pdfDoc.end();