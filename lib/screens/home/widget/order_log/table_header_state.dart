import 'package:flutter/material.dart';

class TableHeaderState extends StatefulWidget {
  const TableHeaderState({Key? key}) : super(key: key);

  @override
  State<TableHeaderState> createState() => _TableHeaderStateState();
}

class _TableHeaderStateState extends State<TableHeaderState> {
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
              "الإسم",
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
              "السعر",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width * 0.9) / 5.8,
            height: 50,
            alignment: Alignment.centerRight,
            child: Text(
              "الضمان",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
      ),
    );
  }
}

