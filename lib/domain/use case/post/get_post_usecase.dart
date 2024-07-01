import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';

class GetPostUseCase {
  PostRepository _repository;

  GetPostUseCase(this._repository);
  Stream<Resource<List<Post>>>launch() => _repository.getPost();
}
