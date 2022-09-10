import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/view_user_screen.dart';

class UserInfoCard extends StatefulWidget {
  const UserInfoCard({Key? key}) : super(key: key);

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: 60,
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "سالم سالم سالم",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            ),
          ),
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "091234567",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            ),
          ),
          Container(
            width: (size.width * 0.7) / 4,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "2222/22/22",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            ),
          ),
          Container(
            width: 100,
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              "مشترك",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: () {
                  Navigator.pushNamed(context, ViewUserScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
