// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyCustom3DButtonWithText extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final Function() function;
  final Color? shadowColor;
  final Color? textColor;

  const MyCustom3DButtonWithText(
      {Key? key,
      required this.text,
      required this.height,
      required this.width,
      required this.color,
      required this.borderRadius,
      this.textColor,
      this.shadowColor,
      required this.function})
      : super(key: key);

  @override
  State<MyCustom3DButtonWithText> createState() =>
      _MyCustom3DButtonStateWithText();
}

class _MyCustom3DButtonStateWithText extends State<MyCustom3DButtonWithText> {
  static const double _shadowHeight = 4;
  double _position = _shadowHeight;

  @override
  Widget build(BuildContext context) {
    final double height = widget.height - _shadowHeight;
    return Center(
      child: GestureDetector(
        onTapUp: (_) async {
          setState(() {
            _position = _shadowHeight;
          });
          await widget.function();
        },
        onTapDown: (_) {
          setState(() {
            _position = 0;
          });
        },
        onTapCancel: () {
          setState(() {
            _position = _shadowHeight;
          });
        },
        child: SizedBox(
          height: height + _shadowHeight,
          width: widget.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: widget.shadowColor ?? Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            widget.shadowColor ?? Colors.grey.withOpacity(0.8),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: const Duration(milliseconds: 70),
                child: Container(
                  height: height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.text,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: widget.textColor ?? Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustom3DButtonWithWidget extends StatefulWidget {
  final Widget customWidget;
  final double height;
  final double width;
  final Color color;
  final double borderRadius;
  final Function() function;

  const MyCustom3DButtonWithWidget(
      {Key? key,
      required this.customWidget,
      required this.height,
      required this.width,
      required this.color,
      required this.borderRadius,
      required this.function})
      : super(key: key);

  @override
  State<MyCustom3DButtonWithWidget> createState() =>
      _MyCustom3DButtonWithWidgetState();
}

class _MyCustom3DButtonWithWidgetState
    extends State<MyCustom3DButtonWithWidget> {
  static const double _shadowHeight = 4;
  double _position = _shadowHeight;

  @override
  Widget build(BuildContext context) {
    final double height = widget.height - _shadowHeight;
    return Center(
      child: GestureDetector(
        onTapUp: (_) async {
          setState(() {
            _position = _shadowHeight;
          });
          await widget.function();
        },
        onTapDown: (_) {
          setState(() {
            _position = 0;
          });
        },
        onTapCancel: () {
          setState(() {
            _position = _shadowHeight;
          });
        },
        child: SizedBox(
          height: height + _shadowHeight,
          width: widget.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: const Duration(milliseconds: 70),
                child: Container(
                  height: height,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.borderRadius),
                    ),
                  ),
                  child: Center(
                    child: widget.customWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
