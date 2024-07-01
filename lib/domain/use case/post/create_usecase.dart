import 'dart:io';

import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';

class CreatePostUseCase {

  PostRepository _repository;

  CreatePostUseCase(this._repository);

  launch(Post post, File image) => _repository.create(post, image);

}