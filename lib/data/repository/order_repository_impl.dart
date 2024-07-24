import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/domain/repository/orders_repository.dart';
import 'package:stripe_payment/utils/resources.dart';
import 'package:path/path.dart';

class OrderRepositoryImpl extends OrdersRepository {
  CollectionReference _orderRef;
  Reference _orderStorageRef;

  OrderRepositoryImpl(this._orderRef,this._orderStorageRef);

  @override
  Future<Resource<String>> registerOrder(OrderData order) async {
    try {
      //Public data on Firebase
      final data = await _orderRef.add(order.toJson());
      return Success('Successfully created');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Unknow Error');
    }
  }

  @override
  Future<Resource<String>> uploadReceipt(File pdfFile) async{
    try {
    // Obtener el nombre del archivo
    String name = basename(pdfFile.path);
    int indexOfDot = name.lastIndexOf('.');

    // Subir el archivo PDF a Firebase Storage
    TaskSnapshot uploadTask = await _orderStorageRef.child(name).putFile(
      pdfFile,
      SettableMetadata(
        contentType: 'application/pdf',
      ),
    );

    // Obtener la URL de descarga del archivo subido
    String url = await uploadTask.ref.getDownloadURL();

    // Aquí puedes guardar la URL en tu base de datos si es necesario
    // Ejemplo: post.pdfUrl = url;

    // Devolver un mensaje de éxito
    return Success('PDF subido exitosamente');
  } on FirebaseException catch (e) {
    return Error(e.message ?? 'Error desconocido');
  }
  }
}
