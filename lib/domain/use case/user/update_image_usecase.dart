import 'dart:io';

import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/user_repository.dart';

class UpdateImageUseCase {
  UserRepository _repository;
  UpdateImageUseCase(this._repository);

  launch(UserData userData, File image) =>
      _repository.updateWithImage(userData, image);
}
