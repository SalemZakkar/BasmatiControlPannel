import 'package:flutter/material.dart';

class MyCustomButton extends StatefulWidget {
  final Widget customWidget;
  final double height;
  final double width;
  final Color? color;
  final double borderRadius;
  final Function() function;

  const MyCustomButton(
      {Key? key,
      required this.customWidget,
      required this.height,
      required this.width,
      required this.color,
      required this.borderRadius,
      required this.function})
      : super(key: key);

  @override
  State<MyCustomButton> createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  double toNewSize = 2.0;
  double height = 0.0;
  double width = 0.0;

  @override
  void initState() {
    setState(() {
      height = widget.height;
      width = widget.width;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) async {
        setState(() {
          height = height - toNewSize;
          width = width - toNewSize;
        });
        await widget.function();
      },
      onTapDown: (_) {
        setState(() {
          height = height + toNewSize;
          width = width + toNewSize;
        });
      },
      onTapCancel: () {
        setState(() {
          height = height - toNewSize;
          width = width - toNewSize;
        });
      },
      child: AnimatedContainer(
        width: width,
        height: height,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.borderRadius),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 0,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 70),
        curve: Curves.fastOutSlowIn,
        child: widget.customWidget,
      ),
    );
  }
}
