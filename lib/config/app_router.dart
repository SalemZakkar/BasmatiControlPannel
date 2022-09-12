import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/view_user_screen.dart';
import 'package:web_basmati/screens/items/add_item.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens/items/manage_item.dart';
import 'package:web_basmati/screens/navigation_screen/navigation_screen.dart';
import 'package:web_basmati/screens_export.dart';

import '../screens/screens_export.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AuthenticationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case NavigationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      case ItemsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ItemsScreen());
      case ViewUserScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ViewUserScreen());
      case AddItem.routeName:
        return MaterialPageRoute(builder: (_) => const AddItem());
      case ManageItem.routeName:
        ManageItem data = routeSettings.arguments as ManageItem;
        return MaterialPageRoute(
            builder: (_) => ManageItem(
                  id: data.id,
                ));
      case AppInfoScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AppInfoScreen());
      default:
        return null;
    }
  }
}
