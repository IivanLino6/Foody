import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';

class UpdatePostUseCase {
  PostRepository _repository;

  UpdatePostUseCase(this._repository);
  launch(Post post) => _repository.update(post);
}
