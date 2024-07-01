import 'package:flutter/material.dart';
import 'package:stripe_payment/widgets/icon_button.dart';

showActionsCamera(
    BuildContext context, Function() pickImage, Function() takePhoto) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
                child: const Text(
              'Select an option',
              style: TextStyle(fontSize: 16),
            )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconCustomBtn(
                  widht: 100,
                  txtColor: Colors.black,
                  color: Colors.white,
                  icon: Icon(Icons.image,color: Colors.black,), 
                  txt: '', onFcn: (){
                    Navigator.pop(context);
                    pickImage();
                  }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconCustomBtn(
                  widht: 100,
                  color: Colors.white,
                  txtColor: Colors.black,
                  icon: Icon(Icons.camera_enhance_outlined,color: Colors.black,), 
                  txt: '', onFcn: (){
                    Navigator.pop(context);
                    takePhoto();
                  }),
              ),
            ],
          ));
}
