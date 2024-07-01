import 'package:stripe_payment/domain/use%20case/user/getUserById_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/update_image_usecase.dart';
import 'package:stripe_payment/domain/use%20case/user/update_profile_usecase.dart';

class UserUseCase {
  GetUserByIdUseCase getById;
  UpdateUserUseCase updateWithoutImage;
  UpdateImageUseCase updateWithImage;

  UserUseCase({
    required this.getById, 
  required this.updateWithoutImage,
  required this.updateWithImage});
}
