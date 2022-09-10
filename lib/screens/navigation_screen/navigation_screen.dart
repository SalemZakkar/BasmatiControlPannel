import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';
import 'package:web_basmati/screens/screens_export.dart';
import 'package:web_basmati/screens_export.dart';

import 'bloc/navigation_bloc.dart';

class NavigationScreen extends StatefulWidget {
  static const routeName = '/main';

  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List widgets = const [
    HomeScreen(),
    ItemsScreen(),
    AppInfoScreen(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: BlocConsumer<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state is NavigationChangedState) {
              setState(() {
                index = state.i;
              });
            }
          },
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const DrawerWidget(),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: widgets[index])
              ],
            );
          },
        ),
      ),
    );
  }
}
