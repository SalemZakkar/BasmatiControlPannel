import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/helper_export.dart';

bool dialogRunning = false;
GlobalKey key = GlobalKey();

void myCustomShowLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (context) {
        dialogRunning = true;
        return WillPopScope(
          onWillPop: () async {
            // dialogRunning = true;
            return false;
          },
          child: Center(
            key: key,
            child: const CupertinoActivityIndicator(),
          ),
        );
      });
}

void myCustomKillLoadingDialog(BuildContext context, {String? message}) {
  if (dialogRunning) {
    Navigator.pop(context);
    dialogRunning = false;
    if (message != null) {
      myCustomShowSnackBarText(context, message);
    }
  }
}

void myCustomShowSnackBarText(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Widget myCustomCircularProgressIndicator() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget myCustomNoData(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.noData,
          width: 100,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "S.of(context).no_data",
          textScaleFactor: 1,
          style: TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

Widget myCustomShimmerShowText(
    {required String text,
    required double fontSize,
    required double height,
    required double width}) {
  return SizedBox(
    height: height,
    width: width,
    child: Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget myCustomShimmerShowLoading(
    {required double height, required double width}) {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.white24,
    child: Container(
      color: Colors.white,
      height: height,
      width: width,
    ),
  );
}

Widget myCustomShimmerCircularShowLoading(
    {required double height, required double width, required double circular}) {
  return Shimmer.fromColors(
    baseColor: Colors.black12,
    highlightColor: Colors.white24,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(circular),
      ),
    ),
  );
}
