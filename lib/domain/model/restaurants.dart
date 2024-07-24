import 'dart:io';

import 'package:stripe_payment/domain/model/post.dart';

class Restaurant {
  final String id;
  final String name;
  final String address;
  final String logoUrl;
  final List<Post> postItems;

  Restaurant({
    this.id = '',
    this.name ='',
    this.address='',
    this.logoUrl='',
    this.postItems = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      logoUrl: json['logoUrl'] as String,
      postItems: (json['postItems'] as List<dynamic>)
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'logoUrl': logoUrl,
      'postItems': postItems.map((item) => item.toJson()).toList(),
    };
  }
}
