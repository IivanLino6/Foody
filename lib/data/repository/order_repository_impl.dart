import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/domain/repository/orders_repository.dart';
import 'package:stripe_payment/utils/resources.dart';

class OrderRepositoryImpl extends OrdersRepository {
  CollectionReference _orderRef;

  OrderRepositoryImpl(this._orderRef);

  @override
  Future<Resource<String>> registerOrder(OrderData order) async {
    try {
      //Public data on Firebase
      final data = await _orderRef.add(order.toJson());
      return Success('Successfully created');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Unknow Error');
    }
  }
}
