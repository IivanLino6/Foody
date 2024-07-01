import 'package:flutter/material.dart';

class IconCustomBtn extends StatelessWidget {
  final double height;
  final double widht;
  final Icon icon;
  final String txt;
  final Color color;
  final Function onFcn;
  final Color txtColor;

  const IconCustomBtn({
    this.height = 45,
    this.widht = 200,
    required this.icon,
    required this.txt,
    this.color = Colors.black,
    required this.onFcn,
    this.txtColor = Colors.white,black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: widht,
      child: ElevatedButton.icon(
        onPressed: () {
          // Acción al presionar el botón
          onFcn();
        },
        icon: icon, // Cambia el icono según tu preferencia
        label: Text(txt,style: TextStyle(color: txtColor),), // Cambia el texto según tu preferencia
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color), // Fondo negro
          foregroundColor:
              MaterialStateProperty.all(Colors.white), // Texto blanco
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // Esquinas redondeadas
            ),
          ),
        ),
      ),
    );
  }
}
