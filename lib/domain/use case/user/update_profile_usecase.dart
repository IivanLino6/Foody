import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/user_repository.dart';

class UpdateUserUseCase {
  UserRepository _repository;
  UpdateUserUseCase(this._repository);

  launch(UserData userData) => _repository.updateWithoutImage(userData);
}
