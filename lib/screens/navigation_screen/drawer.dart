import 'package:flutter/material.dart';
import 'package:web_basmati/screens/authentication/authentication_screen.dart';
import 'package:web_basmati/screens/authentication/repository/repository.dart';
import 'package:web_basmati/screens/home/home_screen.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens_export.dart';

import '../../helper/app_assets.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late Map<bool, Color> buttonColor;
  List states = [false, false, false];

  @override
  Widget build(BuildContext context) {
    buttonColor = {
      true: Theme.of(context).cardColor,
      false: Theme.of(context).primaryColor
    };
    // void pressed(int j) {
    //   for (int i = 0; i < 3; i++) {
    //     setState(() {
    //       states[i] = i == j;
    //     });
    //   }
    // }

    Size size = MediaQuery.of(context).size;
    return Container(
      width: 240,
      height: size.height,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22.0),
            bottomLeft: Radius.circular(22.0),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 240,
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.appIcon,
              width: 80,
              height: 80,
            ),
          ),
          InkWell(
            onTap: () {
              // context
              //     .read<NavigationBloc>()
              //     .add(const NavigationChangeEvent(i: 0));
              // pressed(0);
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 45,
              width: 220,
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: buttonColor[states[0]],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              alignment: Alignment.centerRight,
              child: Text("معلومات المستخدمين",
                  style:
                      TextStyle(fontSize: 20, color: buttonColor[!states[0]])),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              // context
              //     .read<NavigationBloc>()
              //     .add(const NavigationChangeEvent(i: 1));
              // pressed(1);
              Navigator.pushNamedAndRemoveUntil(
                  context, ItemsScreen.routeName, (route) => false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 45,
              width: 220,
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: buttonColor[states[1]],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              alignment: Alignment.centerRight,
              child: Text("إدارة المنتجات",
                  style:
                      TextStyle(fontSize: 20, color: buttonColor[!states[1]])),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              // context
              //     .read<NavigationBloc>()
              //     .add(const NavigationChangeEvent(i: 2));
              // pressed(2);
              Navigator.pushNamedAndRemoveUntil(
                  context, AppInfoScreen.routeName, (route) => false);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 45,
              width: 220,
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: buttonColor[states[2]],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              alignment: Alignment.centerRight,
              child: Text("معلومات من نحن",
                  style:
                      TextStyle(fontSize: 20, color: buttonColor[!states[2]])),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              AuthRepository.logout();
              Navigator.pushNamedAndRemoveUntil(
                  context, AuthenticationScreen.routeName, (route) => false);
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15),
              width: 200,
              height: 40,
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerRight,
              child: Text(
                "تسجيل الخروج",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 19),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
