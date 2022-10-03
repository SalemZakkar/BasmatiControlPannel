import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_basmati/helper/payment_enum.dart';
import 'package:web_basmati/screens/home/model/order_logs_model.dart';
import 'package:web_basmati/screens/home/view_order_details.dart';
import 'package:web_basmati/shared/widget/date_time.dart';

class OrderLogCard extends StatefulWidget {
  final OrderLogData data;
  const OrderLogCard({Key? key, required this.data}) : super(key: key);

  @override
  State<OrderLogCard> createState() => _OrderLogCardState();
}

class _OrderLogCardState extends State<OrderLogCard> {
  DateFormat format = DateFormat("yyyy-MM-DD");
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 40,
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              getDate(format.parse(widget.data.createdAt!.toString())),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              widget.data.productsCount!.toString(),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              getPaymentStatus(widget.data.status?.status ?? ""),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ViewOrderDetails.routeName);
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).primaryColor,
              )),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
