import 'package:stripe_payment/domain/repository/post_repository.dart';

class DeletePostUseCase {

  PostRepository _repository;

  DeletePostUseCase(this._repository);

  launch(String postId) => _repository.delete(postId);

}