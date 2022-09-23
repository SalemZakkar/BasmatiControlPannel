import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:web_basmati/helper/error_message.dart';

void showErrorMessageFlush(BuildContext context, String code) {
  Flushbar(
    title: "حدث خطأ  " "($code)",
    backgroundColor: Theme.of(context).errorColor,
    flushbarPosition: FlushbarPosition.BOTTOM,
    borderRadius: BorderRadius.circular(25),
    message: errorParse(code),
    messageSize: 20,
    duration: const Duration(seconds: 3),
    flushbarStyle: FlushbarStyle.FLOATING,
    maxWidth: 300,
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width - 330, bottom: 5),
  ).show(context);
}

void showErrorMessageFlushNoCode(context, msg) {
  Flushbar(
    title: "حدث خطأ  ",
    backgroundColor: Theme.of(context).errorColor,
    flushbarPosition: FlushbarPosition.BOTTOM,
    borderRadius: BorderRadius.circular(25),
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    messageSize: 20,
    duration: const Duration(seconds: 3),
    flushbarStyle: FlushbarStyle.FLOATING,
    maxWidth: 300,
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width - 330, bottom: 5),
  ).show(context);
}

void showSuccessFlushMessage(BuildContext context, String message) {
  Flushbar(
    title: "تم",
    backgroundColor: Colors.green,
    flushbarPosition: FlushbarPosition.BOTTOM,
    borderRadius: BorderRadius.circular(25),
    message: message,
    messageSize: 20,
    duration: const Duration(seconds: 3),
    flushbarStyle: FlushbarStyle.FLOATING,
    maxWidth: 300,
    margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width - 330, bottom: 5),
  ).show(context);
}
