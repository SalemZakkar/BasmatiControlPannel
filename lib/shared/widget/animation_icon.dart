import 'package:flutter/material.dart';

class MyCustomAnimationIcon extends StatefulWidget {
  final AnimatedIconData animatedIcons;
  final Function() functionOnTap;
  final Function() functionOnBack;

  const MyCustomAnimationIcon(
      {Key? key,
      required this.animatedIcons,
      required this.functionOnTap,
      required this.functionOnBack})
      : super(key: key);

  @override
  State<MyCustomAnimationIcon> createState() => _MyCustomAnimationIconState();
}

class _MyCustomAnimationIconState extends State<MyCustomAnimationIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future _handleOnPressed() async {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
    if (isPlaying == true) {
      await widget.functionOnTap();
    } else {
      await widget.functionOnBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await _handleOnPressed();
      },
      icon: AnimatedIcon(
        icon: widget.animatedIcons,
        progress: _animationController,
        semanticLabel: 'Show menu',
      ),
    );
  }
}
