import 'dart:io';

import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/model/restaurants.dart';

class RestaurantCreateState {
  final String id;
  final String name;
  final String address;
  final File? logoUrl;
  final List<Post> postItems;

  RestaurantCreateState({
    this.id = '',
    this.name= '',
    this.address= '',
    this.logoUrl,
    this.postItems = const [],
  });

  // Método copyWith
  RestaurantCreateState copyWith({
    String? id,
    String? name,
    String? address,
    File? logoUrl,
    List<Post>? postItems,
  }) {
    return RestaurantCreateState(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      logoUrl: logoUrl ?? this.logoUrl,
      postItems: postItems ?? this.postItems,
    );
  }

  // Método para convertir a Restaurant
  Restaurant toRestaurant() {
    return Restaurant(
      id: id,
      name: name,
      address: address,
      postItems: postItems,
    );
  }
}
