import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/order.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({super.key});

  @override
  Widget build(BuildContext context) {
    OrderData orderData =
        ModalRoute.of(context)?.settings.arguments as OrderData;
    List<CartList> items = orderData.items;
    String dateTimeNow = DateTime.now().toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          backgroundColor: Colors.black,
          title: Text(
            'Recibo',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,bottom: 25),
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Foody',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 32)),
                    ),
                  ),
                  const Center(
                    child: Text('No. de Pedido',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ),
                  const Center(
                    child: Text('N1837GhSg88',
                        style: TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                  Center(
                    child: Text(dateTimeNow,
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                  Center(
                    child: Text('Ticket No. 6192',
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                  Center(
                    child: Text('RFC: PHI-830429-MG6',
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ),
                  const Divider(
                    endIndent: 15,
                    indent: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.grey[300]),
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Item',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Cant.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Precio',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        ...items.map((item) {
                          return TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.post.name),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${item.quantity}'),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('\$${item.post.price}')),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const Divider(
                    endIndent: 15,
                    indent: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal (IVA incluido):'),
                        Text('\$${orderData.subtotalAmount}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text('\$${orderData.totalAmount}')
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text('Metodo de pago'),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9, right: 12),
                      child: Text(
                        ' VISA XXX XXX XXX 5647',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: QrImageView(
                        data: 'http://StripePagos.com',
                        version: QrVersions.auto,
                        size: 100.0,
                        
                      ),
                    ),
                  ),
                  Center(child: Text('Escanea el codigo para ver tu recibo',style: TextStyle(fontSize: 8),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
