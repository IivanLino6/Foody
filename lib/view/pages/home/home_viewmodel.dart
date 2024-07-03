import 'package:flutter/material.dart';
import 'package:stripe_payment/domain/model/post.dart';
import 'package:stripe_payment/domain/use%20case/post/post_usecase.dart';
import 'package:stripe_payment/utils/resources.dart';

class HomeViewModel extends ChangeNotifier {
  PostUsesCases _postUsesCases;
  HomeViewModel(this._postUsesCases);


  Stream<Resource<List<Post>>> getPosts() => _postUsesCases.getPost.launch();
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

}
