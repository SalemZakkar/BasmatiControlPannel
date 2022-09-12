import 'package:flutter/material.dart';
import 'package:web_basmati/helper/error_message.dart';

Widget errorNotification(
    BuildContext context, String code, VoidCallback callback) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.hide_source,
          color: Theme.of(context).errorColor,
          size: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "( $code )  ${errorParse(code)}",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.red, fontSize: 19),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            callback.call();
          },
          child: Text(
            "اعادة المحاولة",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.red, fontSize: 18),
          ),
        )
      ],
    ),
  );
}
