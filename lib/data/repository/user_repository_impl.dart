import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/user.dart';
import 'package:stripe_payment/domain/repository/user_repository.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:path/path.dart';

class UserRepositoryImpl implements UserRepository {
  CollectionReference _usersRef;
  Reference _userStorageRef;

  UserRepositoryImpl(this._usersRef, this._userStorageRef);

  @override
  Stream<Resource<UserData>> getUserbyId(String id) {
    try {
      print('ID: ${id}');
      final data = _usersRef.doc(id).snapshots(includeMetadataChanges: true);
      final dataMap = data.map((doc) =>
          Success(UserData.fromJson(doc.data() as Map<String, dynamic>)));
      return dataMap;
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Unknow error');
    }
  }

  @override
  Future<Resource<String>> updateWithoutImage(UserData userData) async {
    try {
      Map<String, dynamic> map = {
        'username': userData.username,
        'image': userData.image,
      };
      final data = await _usersRef.doc(userData.id).update(map);
      return Success('El usuario se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

    @override
  Future<Resource<String>> updateWithImage(UserData userData, File image) async {
    try {      
      String name = basename(image.path);
      TaskSnapshot uploadTask = await _userStorageRef.child(name).putFile(image, SettableMetadata(
        contentType: 'image/png',        
      ));
      String url = await uploadTask.ref.getDownloadURL();
      
      Map<String, dynamic> map = {
        'username': userData.username,
        'image': url,        
      };
      final data = await _usersRef.doc(userData.id).update(map);
      return Success('El usuario se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }
}
