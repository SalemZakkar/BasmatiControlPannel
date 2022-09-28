import 'package:flutter/material.dart';
import 'package:web_basmati/screens/subscriptions/manage_subscreen.dart';

import '../model/subscription_model.dart';

class SubscriptionCard extends StatefulWidget {
  final SubscriptionData data;
  const SubscriptionCard({Key? key, required this.data}) : super(key: key);

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
          context, ManageSubscriptionScreen.routeName,
          arguments: widget.data),
      child: Container(
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(22)),
        alignment: Alignment.center,
        child: Text(
          widget.data.name.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 20, overflow: TextOverflow.clip),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
