import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';

class HomeViewModel extends ChangeNotifier {
  PostUsesCases _postUsesCases;

  HomeViewModel(this._postUsesCases) {}

  // Usa un Set para almacenar los shopNames sin duplicados
  Set<String> _shopNamesSet = {};
  List<String> _shopNamesList = [];
  List<String> get shopNamesList => _shopNamesList;

  //Stream<Resource<List<Post>>> getPosts() => _postUsesCases.getPost.launch();
  String concatImage(Post post) {
    // Encuentra la posición del último punto en la cadena
    int indexOfDot = post.image.lastIndexOf('.');

    // Divide la cadena en dos partes: antes y después del punto
    String beforeDot = post.image.substring(0, indexOfDot);
    String afterDot = post.image.substring(indexOfDot);

    // Concatenar el valor antes del punto
    String result = beforeDot + '_200x200' + afterDot;
    return result;
  }

  Future<List<String>> getShopNameList() async {
    //Implementar logica
    try {
      // Suscribirse al Stream de Posts y obtener una lista de posts
      final postsSnapshot = await _postUsesCases.getPost.launch().first;
      // Verificar si el Resource contiene datos
      if (postsSnapshot is Success<List<Post>>) {
        // Recorre los posts obtenidos
        for (var post in postsSnapshot.data){
          final shopName = post.shopName;
          if (shopName != null) {
            _shopNamesSet.add(shopName);
          }
        }
        // Convierte el Set a una List para retornar
        return _shopNamesList = _shopNamesSet.toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error getting shop names: $e");
      return [];
    }
  }
}
