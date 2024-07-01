import 'package:stripe_payment/domain/repository/post_repository.dart';

class GetCartUseCase {
  PostRepository _repository;
  GetCartUseCase(this._repository);

  launch() => _repository.getCart();
}
