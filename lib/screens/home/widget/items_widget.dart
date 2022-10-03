import 'package:flutter/material.dart';

Widget myCustomItemsWidget(BuildContext context, String state, String time) {
  return Row(
    children: [
      Text(
        state,
        style: Theme.of(context).textTheme.headline1,
      ),
      const SizedBox(width: 40.0),
      Text(
        time,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20.0),
      ),
    ],
  );
}
