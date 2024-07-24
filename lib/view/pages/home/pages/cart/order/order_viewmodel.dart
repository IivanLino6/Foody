import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/order/order_usescases.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:stripe_payment/view/pages/navigator_bar/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/order/widget/order_state.dart';

class OrderViewModel extends ChangeNotifier {
  AuthUseCases _authUseCases;
  OrderUsesCases _orderUseCases;
  OrderState _state = OrderState();

  Resource _response = Init();
  Resource get response => _response;

  OrderViewModel(this._authUseCases, this._orderUseCases);

  double _totalAmount = 0;
  double get totalAmount => _totalAmount;

  double _subTotalAmount = 0;
  double get subTotalAmount => _subTotalAmount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StreamController<Resource> _responseController = StreamController<Resource>();
  Stream<Resource> get responsePayment => _responseController.stream;

  String getUser() {
    String emailSession = _authUseCases.getUser.userSession?.email ?? '';
    return emailSession;
  }

  String concatImage(Post post) {
    // Encuentra la posición del último punto en la cadena
    int indexOfDot = post.image.lastIndexOf('.');

    // Divide la cadena en dos partes: antes y después del punto
    String beforeDot = post.image.substring(0, indexOfDot);
    String afterDot = post.image.substring(indexOfDot);

    // Concatenar el valor antes del punto
    String result = beforeDot + '_200x200' + afterDot;
    return result;
  }

  double calculateSubtotalAmount(List<CartList> _checkoutList) {
    double total = 0.0;
    double postPrice = 0;
    double postQuantity = 0;

    for (var checkoutItem in _checkoutList) {
      postPrice = double.parse(checkoutItem.post.price);
      postQuantity = checkoutItem.quantity.toDouble();
      total += postPrice * postQuantity;
      _subTotalAmount = total;
    }
    return total;
  }

  double calculateTotalAmount() {
    return _totalAmount = _subTotalAmount + 35.0;
  }

  Future<bool> initPayment(String email, double amount, BuildContext context,
      List<CartList> cartList) async {
    //Loading payment sheet
    _responseController.add(Loading());
    bool result = await _authUseCases.pay
        .launch(email: email, amount: amount, context: context);
    _responseController.add(Success(result));
    if (result) {
      var vmCart = Provider.of<CartViewModel>(context, listen: false);
      var vmNavigator =
          Provider.of<NavigatorBottomViewModel>(context, listen: false);

      //Create order method
      createOrder(cartList);
      //Go to receipt page
      Navigator.popAndPushNamed(context, 'ReceiptPage',
          arguments: _state.toOrder());
      //Cleand all List data
      vmCart.clearCart();
      vmNavigator.resetIndex();
    } else {
      print('paymemnt failed');
    }
    return result;
  }

  createOrder(List<CartList> cartList) async {
    String createdDate = DateTime.now().toString();

    _state = _state.copyWith(
        items: cartList,
        createdDate: createdDate,
        subtotalAmount: _subTotalAmount.toString(),
        totalAmount: _totalAmount.toString(),
        costumerId: 'Hsh8282dmd02');

    // Verificar que _state.items tiene los datos esperados
    print('Estado después de actualizar: ${_state.items.length} items');
    //_response = Loading();
    notifyListeners();
    //_response = await _orderUseCases.registerOrder.launch(_state.toOrder());
    notifyListeners();
  }
}
