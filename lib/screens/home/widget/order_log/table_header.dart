import 'package:flutter/material.dart';

class TableHeader extends StatefulWidget {
  const TableHeader({Key? key}) : super(key: key);

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          const SizedBox(
            width: 40,
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              "التاريخ",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              "الكمية",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              "الحالة",
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }
}
