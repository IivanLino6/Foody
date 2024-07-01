import 'package:stripe_payment/domain/use%20case/post/add_cart_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/create_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/delete_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/get_cart_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/get_post_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/update_post_image_usecase.dart';
import 'package:stripe_payment/domain/use%20case/post/update_usecase.dart';

class PostUsesCases {
  CreatePostUseCase create;
  GetPostUseCase getPost;
  DeletePostUseCase delete;
  UpdatePostUseCase update;
  UpdatePostImageUseCase updateWithImage;
  AddToCartUseCase addToCart;
  GetCartUseCase getCart;

  PostUsesCases(
      {required this.create,
      required this.getPost,
      required this.delete,
      required this.update,
      required this.updateWithImage,
      required this.addToCart,
      required this.getCart});
}
