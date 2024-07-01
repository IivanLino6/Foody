import 'package:flutter/material.dart';

class HomePostItem extends StatelessWidget {
  const HomePostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.1), // color de la sombra con opacidad
                  spreadRadius: 2, // qué tanto se expande la sombra
                  blurRadius: 7, // radio del desenfoque
                  offset: const Offset(
                      3, 3), // desplazamiento de la sombra (x, y)
                ),
              ],
            ),
            height: 160,
            width: 150,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Text(
                    'Bowl de avena',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Con frutos rojos, crema de cacahuate y granola',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text('150')
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: -30,
            right: -10,
            child: Image.asset(
              'asset/png/oat.png',
              height: 20,
              width: 20,
            )),
          Positioned(
            top: 0,
            right: 5,
            child: //Add Button
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Ajusta el radio según tus preferencias
                      ),
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.add,
                        size: 16,
                      ),
                      onPressed: () {
                        
                      }),
                ),
              ),)
      ],
    );
  }
}
