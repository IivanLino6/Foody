import 'package:stripe_payment/domain/model/post.dart';

class CartList {
  Post post;
  int quantity;
  double totalAmount;
  bool isSelected;

  CartList(
      {required this.post,
      this.quantity = 1,
      this.totalAmount = 0,
      this.isSelected = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is CartList) {
      return post.id == other.post.id; // Assuming comparison based on post.id
    }
    return false;
  }

  @override
  int get hashCode => post.id.hashCode; // Assuming id is used for hash

  Map<String, dynamic> toJson() {
    return {
      'post': post.toJson(),
      'quantity': quantity,
      'totalAmount': totalAmount,
      'isSelected': isSelected,
    };
  }

  // Método fromJson para crear una instancia de CartList desde un Map
  static CartList fromJson(Map<String, dynamic> json) {
    return CartList(
      post: Post.fromJson(json['post']),
      quantity: json['quantity'],
      totalAmount: json['totalAmount'],
      isSelected: json['isSelected'],
    );
  }
  
}
