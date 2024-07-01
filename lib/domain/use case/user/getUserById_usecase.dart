import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/user_repository.dart';
import 'package:stripe_payment/utils/resources.dart';

class GetUserByIdUseCase {
  UserRepository _repository;

  GetUserByIdUseCase(this._repository);

  Stream<Resource<UserData>> launch({required String id}) =>
      _repository.getUserbyId(id);
}
