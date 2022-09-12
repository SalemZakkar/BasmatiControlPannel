import 'package:flutter/material.dart';

class TextFieldHolder extends StatefulWidget {
  final double width, height;
  final Widget? child;

  const TextFieldHolder(
      {Key? key,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);

  @override
  State<TextFieldHolder> createState() => _TextFieldHolderState();
}

class _TextFieldHolderState extends State<TextFieldHolder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: widget.child,
        )
      ],
    );
  }
}
