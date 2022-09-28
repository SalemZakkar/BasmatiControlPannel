import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/add_user.dart';

class TableTitle extends StatefulWidget {
  const TableTitle({Key? key}) : super(key: key);

  @override
  State<TableTitle> createState() => _TableTitleState();
}

class _TableTitleState extends State<TableTitle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "اسم المستخدم",
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "رقم الهاتف",
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "تاريخ آخر عملية شراء",
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            ),
          ),
          Container(
            width: 120,
            height: 50,
            alignment: Alignment.centerRight,
            // color: Colors.red,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "نوع الإشتراك",
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 18),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, AddUser.routeName),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  alignment: Alignment.center,
                  child: const Text(
                    "إضافة مستخدم",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
