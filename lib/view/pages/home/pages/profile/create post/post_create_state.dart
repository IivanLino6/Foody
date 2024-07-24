import 'dart:io';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/validation_item.dart';

class PostsCreateState {
  ValidationItem name;
  ValidationItem description;
  ValidationItem price;
  String shopName;
  File? image;
  String category;
  String idUser;
  String error;

  PostsCreateState(
      {this.name = const ValidationItem(),
      this.description = const ValidationItem(),
      this.shopName = '',
      this.image,
      this.category = 'CATEGORIES',
      this.idUser = '',
      this.error = '',
      this.price = const ValidationItem()});

  toPost() => Post(
      name: name.value,
      description: description.value,
      price: price.value,
      shopName: shopName,
      category: category,
      idUser: idUser);

  bool isValid() {
    if (name.value.isEmpty ||
        name.error.isNotEmpty ||
        price.value.isEmpty ||
        price.error.isNotEmpty ||
        description.value.isEmpty ||
        description.error.isNotEmpty ||
        image == null ||
        category.isEmpty ||
        idUser.isEmpty
        || shopName.isEmpty) {
      return false;
    }
    return true;
  }

  PostsCreateState copyWith(
          {ValidationItem? name,
          ValidationItem? description,
          ValidationItem? price,
          String? shopName,
          File? image,
          String? category,
          String? idUser,
          String? error}) =>
      PostsCreateState(
        name: name ?? this.name,
        description: description ?? this.description,
        shopName: shopName ?? this. shopName,
        price: price ?? this.price,
        image: image ?? this.image,
        category: category ?? this.category,
        idUser: idUser ?? this.idUser,
        error: error ?? this.error,
      );
}
