import 'package:stripe_payment/domain/use%20case/order/register_order_usecase.dart';
import 'package:stripe_payment/domain/use%20case/order/upload_receipt_usecase.dart';

class OrderUsesCases {
  RegisterOrderUseCase registerOrder;
  UploadReceiptUseCase uploadReceipt;

  OrderUsesCases({required this.registerOrder,required this.uploadReceipt});
}
