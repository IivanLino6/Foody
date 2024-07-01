import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/view/pages/home/navigator_bottom_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/cart_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/chekout/widget/order_state.dart';

class OrderViewModel extends ChangeNotifier {
  AuthUseCases _authUseCases;
  CartViewModel _vmCart;
  OrderState _state = OrderState();

  OrderViewModel(this._authUseCases, this._vmCart);

  double _totalAmount = 0;
  double get totalAmount => _totalAmount;

  double _subTotalAmount = 0;
  double get subTotalAmount => _subTotalAmount;

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

  Future<bool> initPayment(
      String email, double amount, BuildContext context) async {
    bool result = await _authUseCases.pay
        .launch(email: email, amount: amount, context: context);

    if (result) {
      var vmCart = Provider.of<CartViewModel>(context, listen: false);
      vmCart.clearCart();
      Navigator.popAndPushNamed(context, 'NavigatorBottomPage');
      var vmNavigator =
          Provider.of<NavigatorBottomViewModel>(context, listen: false);
      vmNavigator.resetIndex();
    } else {
      print('paymemnt failed');
    }
    return result;
  }



  void createOrder(List<CartList> cartList) {
    String createdDate = DateTime.now().toString();
    _state = _state.copyWith(items: cartList,createdDate: createdDate,subtotalAmount: _subTotalAmount.toString(),totalAmount: _totalAmount.toString(),costumerId: 'Hsh8282dmd02');
  }
}
