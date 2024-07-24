import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:printing/printing.dart';
import 'package:stripe_payment/domain/use%20case/order/order_usescases.dart';
import 'package:path_provider/path_provider.dart';

class ReceiptViewModel extends ChangeNotifier {
  OrderUsesCases _orderUsesCases;

  ReceiptViewModel(this._orderUsesCases);
  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  bool _exit = false;
  bool get exit => _exit;

  double _alignmentY = 0.3;
  double get alignmentY => _alignmentY;

  bool _isFinished = false;
  bool get isFinished => _isFinished;

  set isFinished(bool isFinished) {
    _isFinished = isFinished;
  }

  set alignmentY(double aligmentY) {
    _alignmentY = aligmentY;
  }

  set exit(bool value) {
    _exit = value;
    notifyListeners();
  }

  set isCompleted(bool value) {
    _isCompleted = value;
    notifyListeners();
  }

  generateQR() {
    QrImageView(
      data: '1234567890',
      version: QrVersions.auto,
      size: 200.0,
    );
  }

  String formatDate(DateTime date) {
    List<String> months = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];

    return '${date.day} de ${months[date.month - 1]} de ${date.year}';
  }

  Future<pw.Font> loadFont(String path) async {
    final fontData = await rootBundle.load(path);
    return pw.Font.ttf(fontData);
  }

  Future<void> uploadReceipt(File pfdFile) async {
    await _orderUsesCases.uploadReceipt.launch(pfdFile);
  }

  Future<void> generatePdf(
      OrderData orderData,
      DateTime dateTimeNow,
      List<CartList> items,
      String shopName,
      String lastDigitCard,
      String pickUpAddress,
      String deliverAddress,
      String expirationCardDate) async {
    final pdf = pw.Document();
    final uberMoveRegular = await loadFont('fonts/UberMove-Regular.ttf');
    final uberMoveBold = await loadFont('fonts/UberMove-Bold.ttf');

    // Cargar la imagen de la tarjeta
    final imageVisa =
        (await rootBundle.load('asset/visa.png')).buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.white,
            borderRadius: pw.BorderRadius.circular(15.0),
          ),
          child: pw.Padding(
            padding: pw.EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.only(left: 5, top: 20),
                      child: pw.Text(
                        'Uber',
                        style: pw.TextStyle(
                          font: uberMoveRegular,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.only(right: 5, top: 25),
                      child: pw.Text(
                        formatDate(dateTimeNow),
                        style: pw.TextStyle(
                          font: uberMoveRegular,
                          fontWeight: pw.FontWeight.normal,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Divider(endIndent: 5, indent: 5),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 5, top: 8),
                  child: pw.Text(
                    'Gracias por tu pedido, Ivan',
                    style: pw.TextStyle(
                      font: uberMoveBold,
                      fontSize: 14,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 5, top: 5),
                  child: pw.Text(
                    'Este es el recibo de $shopName',
                    style: pw.TextStyle(
                      font: uberMoveRegular,
                      fontSize: 8,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 20,
                    bottom: 10,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Total',
                        style: pw.TextStyle(
                          font: uberMoveBold,
                          fontSize: 12,
                        ),
                      ),
                      pw.Text(
                        '${(orderData.totalAmount)} US\$',
                        style: pw.TextStyle(
                          font: uberMoveBold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Divider(endIndent: 5, indent: 5, color: PdfColors.black),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 5, right: 5),
                  child: pw.Column(
                    children: items.map((item) {
                      return pw.Padding(
                        padding: pw.EdgeInsets.all(2.0),
                        child: pw.Row(
                          children: [
                            pw.Container(
                              padding: pw.EdgeInsets.symmetric(horizontal: 3),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                  color: PdfColors.black,
                                  width: 0.15,
                                ),
                              ),
                              child: pw.Text(
                                '${item.quantity}',
                                style: pw.TextStyle(
                                  font: uberMoveRegular,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.only(left: 10),
                              child: pw.Text(
                                '${item.post.name}',
                                style: pw.TextStyle(
                                  font: uberMoveRegular,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                            pw.Spacer(),
                            pw.Text(
                              '${(item.post.price)} US\$',
                              style: pw.TextStyle(
                                font: uberMoveRegular,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                pw.Divider(endIndent: 5, indent: 5),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Subtotal',
                        style: pw.TextStyle(
                          font: uberMoveBold,
                          fontSize: 10,
                        ),
                      ),
                      pw.Text(
                        '${(orderData.subtotalAmount)} US\$',
                        style: pw.TextStyle(
                          font: uberMoveBold,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Cuota de servicio',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                          pw.Text(
                            '3,06 US\$',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Tax',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                          pw.Text(
                            '2,12 US\$',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Delivery Fee',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                          pw.Text(
                            '0,49 US\$',
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Divider(endIndent: 5, indent: 5),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 5, top: 8),
                  child: pw.Text(
                    'Pagos',
                    style: pw.TextStyle(
                      font: uberMoveBold,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          pw.SizedBox(
                            height: 20,
                            child: pw.Image(pw.MemoryImage(imageVisa)),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 12),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  'Visa****$lastDigitCard',
                                  style: pw.TextStyle(
                                    font: uberMoveBold,
                                    fontSize: 8,
                                  ),
                                ),
                                pw.Text(
                                  expirationCardDate,
                                  style: pw.TextStyle(
                                    font: uberMoveRegular,
                                    fontSize: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.Text(
                        '${(orderData.totalAmount)} US\$',
                        style: pw.TextStyle(
                          font: uberMoveBold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Divider(endIndent: 5, indent: 5),
                pw.Padding(
                  padding: pw.EdgeInsets.only(left: 5),
                  child: pw.Text(
                    'Hiciste tu pedido de $shopName',
                    style: pw.TextStyle(
                      font: uberMoveRegular,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Se recolecto en',
                            style: pw.TextStyle(
                              font: uberMoveBold,
                              fontSize: 8,
                            ),
                          ),
                          pw.Text(
                            pickUpAddress,
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'Entregado a',
                            style: pw.TextStyle(
                              font: uberMoveBold,
                              fontSize: 8,
                            ),
                          ),
                          pw.Text(
                            deliverAddress,
                            style: pw.TextStyle(
                              font: uberMoveRegular,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

     // Guardar el PDF en el sistema de archivos
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/receipt.pdf');
    await file.writeAsBytes(await pdf.save());

    // Subir el archivo PDF a Firestore
    await uploadReceipt(file);
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
