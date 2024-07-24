import 'dart:io';

import 'package:stripe_payment/domain/repository/orders_repository.dart';

class UploadReceiptUseCase {
  OrdersRepository _repository;

  UploadReceiptUseCase(this._repository);

  launch(File pdfFile) => _repository.uploadReceipt(pdfFile);
}
