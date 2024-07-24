import 'dart:io';

import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/utils/resources.dart';

abstract class PostRepository {
  Future<Resource<String>> create(Post post, File image);
  Future<Resource<String>> delete(String postId);
  Future<Resource<String>> addToCart(Post post);
  Future<Resource<String>> update(Post post);
  Future<Resource<String>> updateWithImage(Post post, File image);
  Stream<Resource<List<Post>>> getPost();
  Stream<Resource<List<Post>>> getCart();
  Stream<Resource<List<Post>>> getPostbyShopName(String shopName);
}
