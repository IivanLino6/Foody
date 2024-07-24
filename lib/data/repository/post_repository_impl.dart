import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/repository/post_repository.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:path/path.dart';

class PostRepositoryImpl implements PostRepository {
  CollectionReference _postRef;
  Reference _postStorageRef;
  CollectionReference _cartRef;

  PostRepositoryImpl(this._postRef, this._postStorageRef, this._cartRef);

  @override
  Future<Resource<String>> create(Post post, File image) async {
    try {
      //Get the picture name
      String name = basename(image.path);
      int indexOfDot = name.lastIndexOf('.');

      //Public data on firestorage
      TaskSnapshot uploadTask = await _postStorageRef.child(name).putFile(
          image,
          SettableMetadata(
            contentType: 'image/png',
          ));
      String url = await uploadTask.ref.getDownloadURL();
      post.image = url;
      //Public data on Firebase
      final data = await _postRef.add(post.toJson());
      return Success('Successfully created');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Unknow error');
    }
  }

  @override
  Stream<Resource<List<Post>>> getPost() {
    try {
      //Get the data from Firebase
      final data = _postRef.snapshots(includeMetadataChanges: true);
      final dataMap = data.map((document) => Success(document.docs.map((post) {
            final id = post.id;
            final map = {...post.data() as Map<String, dynamic>, 'id': id};
            return Post.fromJson(map);
          }).toList()));
      return dataMap;
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Unknow error');
    }
  }

  @override
  Stream<Resource<List<Post>>> getCart() {
    try {
      //Get the data from Firebase
      final data = _cartRef.snapshots(includeMetadataChanges: true);
      final dataMap = data.map((document) => Success(document.docs.map((post) {
            final id = post.id;
            final map = {...post.data() as Map<String, dynamic>, 'id': id};
            return Post.fromJson(map);
          }).toList()));
      return dataMap;
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Unknow error');
    }
  }

  @override
  Future<Resource<String>> delete(String postId) async {
    try {
      await _postRef.doc(postId).delete();
      return Success('Post succesfully deleted');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Unknow Error');
    }
  }

  @override
  Future<Resource<String>> update(Post post) async {
    try {
      Map<String, dynamic> map = {
        'name': post.name,
        'description': post.description,
        'price': post.price,
        'category': post.category
      };
      final data = await _postRef.doc(post.id).update(map);
      return Success('El posts se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<Resource<String>> updateWithImage(Post post, File image) async {
    try {
      String name = basename(image.path);
      TaskSnapshot uploadTask = await _postStorageRef.child(name).putFile(
          image,
          SettableMetadata(
            contentType: 'image/png',
          ));
      String url = await uploadTask.ref.getDownloadURL();

      Map<String, dynamic> map = {
        'name': post.name,
        'description': post.description,
        'category': post.category,
        'image': url,
      };
      final data = await _postRef.doc(post.id).update(map);
      return Success('El posts se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<Resource<String>> addToCart(Post post) async {
    try {
      final data = await _cartRef.add(post.toJson());
      Fluttertoast.showToast(msg: 'Added to cart');
      return Success('Successfully created');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Unknow error');
    }
  }
  
  @override
  Stream<Resource<List<Post>>> getPostbyShopName(String shopName){
    try {
      //Get the data from Firebase
      final data = _postRef.where('shopName', isEqualTo:shopName ).snapshots(includeMetadataChanges: true);
      final dataMap = data.map((document) => Success(document.docs.map((post) {
            final id = post.id;
            final map = {...post.data() as Map<String, dynamic>, 'id': id};
            return Post.fromJson(map);
          }).toList()));
      return dataMap;
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Unknow error');
    }
  }
}
