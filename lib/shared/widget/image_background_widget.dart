import 'package:flutter/material.dart';

import '../../helper/helper_export.dart';

class BackgroundImageWidget extends StatefulWidget {
  final Widget? child;

  const BackgroundImageWidget({Key? key, this.child}) : super(key: key);

  @override
  State<BackgroundImageWidget> createState() => _BackgroundImageWidgetState();
}

class _BackgroundImageWidgetState extends State<BackgroundImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              AppAssets.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          widget.child ?? const Center()
        ],
      ),
    );
  }
}
