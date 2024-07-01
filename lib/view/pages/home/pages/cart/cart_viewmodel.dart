import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/domain/model/cart_list.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/auth/auth_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';

class CartViewModel extends ChangeNotifier {
  PostUsesCases _postUsesCases; 
  AuthUseCases _authUseCases;

  CartViewModel(this._postUsesCases, this._authUseCases){
    countItems();
  }
  
  double _totalAmount = 0; // Initialize _counter with 0.0
  double get totalAmount => _totalAmount; // Getter for counter
  
  List<CartList> _cartList = [];
  List<CartList> get cartList => _cartList;

  int _itemCounter = 0;
  int get itemCounter => _itemCounter; // Getter for cartList

  void setCartList(List<CartList> items) {
    _cartList = items;
    notifyListeners();
  }

  String getUser() {
    String emailSession = _authUseCases.getUser.userSession?.email ?? '';
    return emailSession;
  }

  void countItems() {
    _itemCounter = 0;
    for (var item in _cartList) {
      _itemCounter += item.quantity;
    }
    notifyListeners();
  }

  void addToCart(Post post) {
    var cartSelected = CartList(post: post);
    // Check if the item already exists in the cart
    int index = _cartList.indexWhere((item) => item.post.id == post.id);
    if (index == -1) {
      // Item does not exist, add it to the cart
      _cartList.add(cartSelected);
    } else {
      // Item exists, increment the quantity
      _cartList[index].quantity += 1;
    }
    countItems();
    Fluttertoast.showToast(msg: 'Added to cart');
    notifyListeners();
  }

  void removeFromCart(Post post) {
    _cartList.removeWhere((item) => item.post == post);
    notifyListeners();
  }

  void incrementCounter(Post post) {
    int index = _cartList.indexWhere((item) => item.post.id == post.id);
    _cartList[index].quantity += 1;
    calculateTotalAmount();
    countItems();
    notifyListeners();
  }

  void decrementCounter(Post post) {
    int index = _cartList.indexWhere((item) => item.post.id == post.id);
    _cartList[index].quantity -= 1;
    calculateTotalAmount();
    countItems();
    notifyListeners();
  }

  double calculateTotalAmount() {
    double total = 0.0;
    double postPrice = 0;
    double postQuantity = 0;
    for (var cartItem in _cartList) {
      postPrice = double.parse(cartItem.post.price);
      postQuantity = cartItem.quantity.toDouble();
      total += postPrice * postQuantity;
      _totalAmount = total;
    }
    notifyListeners();
    return total;
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

  void clearCart() {
    _cartList.clear();
    _totalAmount = 0;
    notifyListeners();
  }
}
