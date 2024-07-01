import 'package:stripe_payment/domain/model/post.dart';

class CartList {
  Post post;
  int quantity;
  double totalAmount;

  CartList({required this.post, this.quantity = 1,this.totalAmount = 0});

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
}
