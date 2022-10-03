import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_basmati/screens/home/model/order_details_model.dart';
import 'package:web_basmati/shared/widget/date_time.dart';

class OrderCardState extends StatefulWidget {
  final ProductsOrder productOrder;
  const OrderCardState({Key? key, required this.productOrder})
      : super(key: key);

  @override
  State<OrderCardState> createState() => _OrderCardStateState();
}

class _OrderCardStateState extends State<OrderCardState> {
  bool used = false;
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
              widget.productOrder.name?.toString() ?? "",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              widget.productOrder.qty?.toString() ?? "",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              "${widget.productOrder.price.toString()} ر.س",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              widget.productOrder.warrantyExpiresAt == null
                  ? "-"
                  : getDate(DateFormat("yyyy-MM-dd").parse(
                      widget.productOrder.warrantyExpiresAt?.toString() ?? "")),
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
            ),
          ),
          const Spacer(),
          Checkbox(
              value: used,
              onChanged: (value) {
                setState(() {
                  used = !used;
                });
              }),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }
}
