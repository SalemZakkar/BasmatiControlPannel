import 'package:flutter/material.dart';

Widget myCustomShadowText(String text) {
  return Text(
    text,
    style: const TextStyle(
      shadows: <Shadow>[
        Shadow(
          offset: Offset(2.0, 4.0),
          blurRadius: 7.0,
          color: Colors.black45,
          // color: Color.fromARGB(255, 0, 0, 0),
        ),
        // Shadow(
        //   offset: Offset(10.0, 10.0),
        //   blurRadius: 8.0,
        //   color: Color.fromARGB(125, 0, 0, 255),
        // ),
      ],
    ),
  );
}

Widget myCustomShadowBall({
  required Widget widget,
  required Color color,
  required double sizeBall,
}) {
  return Container(
    alignment: Alignment.center,
    height: sizeBall,
    width: sizeBall,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      border: Border.all(
        width: 1,
        color: Colors.grey.withOpacity(0.2),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 7,
          offset: const Offset(4, 3), // changes position of shadow
        ),
      ],
      // gradient:  RadialGradient(
      //   colors: [color,color, Colors.grey.shade400],
      //   radius: 0.75,
      // ),

      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [
          0.1,
          0.55,
          0.9,
        ],
        colors: [
          color,
          color,
          Colors.grey.shade400,
          // color,
          // Colors.grey.withOpacity(0.2),
          // const Color.fromRGBO(9, 11, 16, 0.20392156862745098),
        ],
      ),
    ),
    child: widget,
  );
}
