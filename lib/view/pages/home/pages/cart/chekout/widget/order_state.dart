import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/order.dart';

class OrderState {
  String id;
  String createdDate;
  List<CartList> items;
  String subtotalAmount;
  String totalAmount;
  String paymentMethod;
  String costumerId;

  OrderState({
    this.id = '',
    this.createdDate='',
    this.items = const [],
    this.subtotalAmount='',
    this.totalAmount='',
    this.paymentMethod='',
    this.costumerId='',
  });
  //Asigna el valor de los campos
  OrderState copyWith({
    String? id,
    String? createdDate,
    List<CartList>? items,
    String? subtotalAmount,
    String? totalAmount,
    String? paymentMethod,
    String? costumerId,
  }) =>
      OrderState(
        id: id ?? this.id,
        createdDate: createdDate ?? this.createdDate,
        items: items ?? this.items,
        subtotalAmount: subtotalAmount ?? this.subtotalAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        costumerId: costumerId ?? this.costumerId,
      );

  toOrder() => OrderData(
        id: this.id,
        costumerId: this.costumerId,
        createdDate: this.createdDate,
        items: this.items,
        subtotalAmount: this.subtotalAmount,
        totalAmount: this.totalAmount,
        paymentMethod: this.paymentMethod,
      );
}
