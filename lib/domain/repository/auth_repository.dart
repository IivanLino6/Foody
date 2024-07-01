import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/utils/resources.dart';

abstract class AuthRepository {
  //Saber si el usuario esta loggeado
  User? get user;
  //Method
  Future<Resource> login({required String email, required String password});
  Future<Resource> register(UserData user);
  Future<void> logout();
  Future<bool> pay({required String email, required double amount, required BuildContext context, required});
  Future<void> resetPassword({required String email});
}

