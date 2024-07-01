import 'dart:io';

import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/resources.dart';

abstract class UserRepository {
  Stream<Resource<UserData>> getUserbyId(String id);
  Future<Resource<String>> updateWithoutImage(UserData userData);
  Future<Resource<String>> updateWithImage(UserData userData, File image);
}
