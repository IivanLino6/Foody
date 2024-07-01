import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<dynamic> BottomSheetPayment(BuildContext context) {

    return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      CardFormEditController controller = CardFormEditController(
                        //initialDetails: state
                      );
                      return SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Ingresa los datos de tu tarjeta',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, right: 10, left: 10),
                              child: CardFormField(
                                controller: controller,
                              ),
                            ),
                            SizedBox(
                              width: 370,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Acción a realizar al presionar el botón
                                  Navigator.pushNamed(context, 'TestPage');
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black), // Color de fondo negro
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        0.0), // Bordes redondeados
                                  )),
                                ),
                                child: const Text(
                                  'Pagar',
                                  style: TextStyle(
                                    color:
                                        Colors.white, // Color de letra blanco
                                    fontSize: 16.0, // Tamaño de letra
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
  }

