import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';

class AddToCartUseCase {
  PostRepository _repository;

  AddToCartUseCase(this._repository);

  launch(Post post) => _repository.addToCart(post);
}
