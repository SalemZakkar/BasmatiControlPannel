import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_basmati/helper/payment_enum.dart';
import 'package:web_basmati/screens/home/model/subscription_log_model.dart';

import '../../../../shared/widget/date_time.dart';

class SubCard extends StatefulWidget {
  final SubscriptionLogData data;
  const SubCard({Key? key, required this.data}) : super(key: key);

  @override
  State<SubCard> createState() => _SubCardState();
}

class _SubCardState extends State<SubCard> {
  DateFormat formal = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        children: [
          const SizedBox(
            width: 40,
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 4.5,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              widget.data.subscription?.name?.toString() ?? "null",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              getDate(formal.parse(widget.data.createdAt!.toString())),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              getPaymentStatus(
                  widget.data.status?.status?.toString() ?? "null"),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
