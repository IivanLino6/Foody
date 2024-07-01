import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/.env';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/auth_repository.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection;

  AuthRepositoryImpl(this._firebaseAuth, this._usersCollection);

  @override
  Future<Resource> login(
      {required String email, required String password}) async {
    try {
      UserCredential data = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.message ?? 'Unknow Error');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<Resource> register(UserData user) async {
    try {
      //Data retorna la informacion de la creacion del usuario
      UserCredential data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.password = '';
      //Asigna el valor de UID
      user.id = data.user?.uid ?? "";
      //Selecciona el doc de firebase con base al uid obtenido de data
      await _usersCollection.doc(user.id).set(user.toJson());
      return Success(data);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return Error(e.message ?? 'Unknow Error');
    }
  }

  @override
  User? get user => _firebaseAuth.currentUser;

  @override
  Future<bool> pay(
      {required String email,
      required double amount,
      required BuildContext context,
      required}) async {
    try {
      //Create a new payment intent on server
      final response = await http.post(Uri.parse(StripeHttpUrl), body: {
        'email': email,
        'amount': (amount * 100).toString(),
      });
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse.toString());
      
      //Initialize the payment sheetjsonResponse.body);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'FoodyApp',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        appearance: const PaymentSheetAppearance(
            shapes: PaymentSheetShape(borderRadius: 25)),
        //applePay: const PaymentSheetApplePay(merchantCountryCode: 'MX',)
      ));

      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(msg: 'Payment Successful');
      return true;
    } catch (error) {
      if (error is StripeException) {
        print('${error.error.localizedMessage}');
        Fluttertoast.showToast(
            fontSize: 14,
            msg: 'An error occured ${error.error.localizedMessage}',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            textColor: Colors.white,
            backgroundColor: Colors.black,
            timeInSecForIosWeb: 4);
      } else {
        print('${error}');
        Fluttertoast.showToast(msg: 'An error occured $error');
      }
      return false;
    }
  }

  @override
  Future<Resource> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
          fontSize: 14,
          msg: 'Check your email',
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 3);
      return Recovery();
    } on FirebaseAuthException catch (e) {
      return Error(e.message ?? 'Unknow Error');
    }
  }
}
