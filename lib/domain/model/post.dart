import 'dart:convert';
import 'package:stripe_payment/domain/model/user.dart';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String id;
  String image;
  String name;
  String price;
  String description;
  String idUser;
  String category;
  String shopName;
  List<String> likes;
  UserData? userData;

  Post(
      {this.id = '',
      this.image = '',
      this.name = '',
      this.price = '',
      this.description = '',
      this.idUser = '',
      this.category = '',
      this.shopName = '',
      this.likes = const [],
      this.userData});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] ?? '',
        image: json["image"] ?? '',
        name: json["name"] ?? '',
        price: json["price"] ?? '',
        description: json["description"] ?? '',
        shopName: json["shopName"] ?? '',
        idUser: json["id_user"] ?? '',
        category: json["category"] ?? '',
        likes: json["likes"] != null ? List.from(json["likes"]) : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "description": description,
        "shopName": shopName,
        "id_user": idUser,
        "category": category,
        'likes': likes,
      };

  Map<String, List<Post>> categorizePosts(List<Post> posts) {
    Map<String, List<Post>> categorizedPosts = {};
    for (var post in posts) {
      if (!categorizedPosts.containsKey(post.category)) {
        categorizedPosts[post.category] = [];
      }
      categorizedPosts[post.category]!.add(post);
    }
    return categorizedPosts;
  }
}
