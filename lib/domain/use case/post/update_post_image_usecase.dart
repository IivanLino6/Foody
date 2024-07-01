import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';

@Injectable()
class UpdatePostImageUseCase {

  PostRepository _repository;

  UpdatePostImageUseCase(this._repository);

  launch(Post post, File file) => _repository.updateWithImage(post, file);

}