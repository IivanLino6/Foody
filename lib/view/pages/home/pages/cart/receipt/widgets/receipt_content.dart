import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/domain/model/order.dart';
import 'package:stripe_payment/view/pages/navigator_bar/navigator_bottom%20page.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/receipt/receipt_viewmodel.dart';
import 'package:stripe_payment/view/pages/home/pages/cart/receipt/widgets/exit_transition_page.dart';
import 'package:stripe_payment/widgets/icon_button.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class ReceiptContent extends StatefulWidget {
  ReceiptViewModel vm;
  OrderData orderData;
  ReceiptContent(this.vm,this.orderData);
  @override
  FlutterPrintAppState createState() => FlutterPrintAppState();
}

class FlutterPrintAppState extends State<ReceiptContent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {}
    });

    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {});
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.vm.isFinished = false;
              widget.vm.exit = false;
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      //Icon transition
      SlideTransition(
          position: Tween<Offset>(
                  begin: const Offset(0.0, -0.3), end: const Offset(0.0, -0.83))
              .animate(CurvedAnimation(
                  parent: _controller, curve: Curves.easeInOut)),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(top: 150),
                  child: const Icon(
                    Icons.description,
                    size: 60,
                    color: Utils.darkGreen,
                  )))),
      //Target Icon
      Padding(
        padding: const EdgeInsets.all(80.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(80),
                color:
                    widget.vm.isCompleted ? Utils.checkGreen : Utils.blueColor,
                child: InkWell(
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Icon(
                            widget.vm.isCompleted
                                ? Icons.done
                                : Icons.description,
                            color: Colors.white,
                            size: 30))))),
      ),
      //Swip up icon
      Align(
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              margin: const EdgeInsets.only(top: 240),
              child: const Column(children: [
                SizedBox(height: 20),
                Icon(Icons.swipe_up, color: Colors.grey, size: 40),
                SizedBox(height: 10),
                Text('Swipe Up\nTo Print',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey))
              ]),
            ),
          )),
      //Vertical slider
      GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            widget.vm.alignmentY +=
                details.delta.dy / (MediaQuery.of(context).size.height / 2);
            widget.vm.alignmentY = widget.vm.alignmentY.clamp(-0.85, 0.72);
            //Check the position of the widge
            if (widget.vm.alignmentY < -0.83) {
              // Print button position
              widget.vm.isCompleted = true;
              print('Print');
              HapticFeedback.lightImpact();
            } else if (widget.vm.alignmentY > 0.70) {
              // Exit button position
              widget.vm.exit = true;
              print('Exit');
              HapticFeedback.lightImpact();

              Future.delayed(
                const Duration(milliseconds: 200),
                () async {
                  // Page transition
                  await scaleController.forward();
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.center,
                          duration: Duration(milliseconds: 400),
                          child: NavigatorBottomPage(),
                          type: PageTransitionType.fade));
                },
              );
              //scaleController.reverse();
            }
            // Ensure it doesn't go out of bounds
          });
        },
        child: Align(
          alignment: Alignment(0.0, widget.vm.alignmentY),
          child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: widget.vm.isCompleted
                    ? Utils.checkGreen
                    : widget.vm.exit
                        ? Colors.red
                        : Utils.lightGreen,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                    bottomLeft: Radius.circular(55),
                    bottomRight: Radius.circular(55)),
              ),
              alignment: Alignment.topCenter,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      color: widget.vm.isCompleted
                          ? Utils.checkGreen
                          : widget.vm.exit
                              ? Colors.red
                              : Utils.darkGreen,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(widget.vm.isCompleted ? Icons.done : Icons.print,
                      color: Colors.white, size: 40))),
        ),
      ),
      //Exit button
      Positioned(
        top: 650,
        left: (MediaQuery.of(context).size.width - 80) / 2,
        child: Align(
            alignment: Alignment.topCenter,
            child: AnimatedBuilder(
              animation: scaleAnimation,
              builder: (context, child) => Transform.scale(
                scale: scaleAnimation.value,
                child: Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(80),
                    color: widget.vm.exit ? Colors.red : Colors.red,
                    child: InkWell(
                        child: SizedBox(
                      width: 80,
                      height: 80,
                    ))),
              ),
            )),
      ),
      Positioned(
          top: 650,
          left: (MediaQuery.of(context).size.width - 80) / 2,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Icon(widget.vm.exit ? Icons.cancel : Icons.cancel,
                color: Colors.white, size: 30),
          )),
      //Receipt Button
      Positioned(
        top: 760,
        left: (MediaQuery.of(context).size.width - 180) / 2,
        child: IconCustomBtn(
            color: Colors.black,
            txtColor: Colors.white,
            widht: 180,
            height: 50,
            icon: const Icon(
              Icons.receipt,
              color: Colors.white,
            ),
            txt: 'Recibo',
            onFcn: () {
              Navigator.pushNamed(context, 'UberReceiptPage',arguments: widget.orderData);
            }),
      ),
    ]));
  }
}

class Utils {
  static const Color blueColor = Color(0xFF03AED2);
  static const Color darkGreen = Color(0xFF01B5A7);
  static const Color lightGreen = Color(0xFF32D8C7);
  static const Color checkGreen = Color(0xFF29D300);
}
