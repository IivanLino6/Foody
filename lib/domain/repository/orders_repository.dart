import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/utils/resources.dart';

abstract class OrdersRepository{
  Future<Resource<String>> registerOrder(OrderData order);
}