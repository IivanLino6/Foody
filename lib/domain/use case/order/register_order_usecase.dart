import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/domain/repository/orders_repository.dart';

class RegisterOrderUseCase {
  OrdersRepository _repository;

  RegisterOrderUseCase( this._repository);

  launch(OrderData order) => _repository.registerOrder(order);
}
