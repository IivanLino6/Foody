import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/view/pages/navigator_bar/navigator_bottom%20page.dart';

class NavigatorBottomViewModel extends ChangeNotifier {
  
  NavigatorBottomPage() {
    _currentIndex = 0;
  }

  int _cartItemCount = 1;
  int get CartItemCount => _cartItemCount;

   set cartItemCount(int value) {
    if (value >= 0) {
      _cartItemCount = value;
    } 
  }

  AuthUseCases _authUseCases;
  int _currentIndex = 0;
  //Getter
  int get currentIndex => _currentIndex;

  NavigatorBottomViewModel(this._authUseCases);

  //Setter
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }
}
