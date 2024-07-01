import 'dart:io';

import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/validation_item.dart';

class PostsUpdateState {
  ValidationItem name;
  ValidationItem description;
  ValidationItem price;
  String id;
  String image;
  String category;
  String idUser;
  String error;

  PostsUpdateState(
      {this.id = '',
      this.name = const ValidationItem(),
      this.description = const ValidationItem(),
      this.price = const ValidationItem(),
      this.image = '',
      this.category = 'CATEGORIES',
      this.idUser = '',
      this.error = ''});

  Post toPost() => Post(
      id: id,
      name: name.value,
      description: description.value,
      price: price.value,
      category: category,
      idUser: idUser,
      image: image);

  bool isValid() {
    if (name.value.isEmpty ||
        name.error.isNotEmpty ||
        price.value.isEmpty ||
        price.error.isNotEmpty ||
        description.value.isEmpty ||
        description.error.isNotEmpty ||
        image == null ||
        category.isEmpty ||
        idUser.isEmpty) {
      return false;
    }
    return true;
  }

  PostsUpdateState copyWith({
    ValidationItem? name,
    ValidationItem? description,
    ValidationItem?price,
    String? image,
    String? category,
    String? idUser,
    String? error,
    String? id,
  }) =>
      PostsUpdateState(
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
        category: category ?? this.category,
        idUser: idUser ?? this.idUser,
        error: error ?? this.error,
        id: id ?? this.id,
      );
}
