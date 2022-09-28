import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/add_user.dart';
import 'package:web_basmati/screens/home/view_user_screen.dart';
import 'package:web_basmati/screens/items/add_item.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens/items/manage_item.dart';
import 'package:web_basmati/screens/navigation_screen/navigation_screen.dart';
import 'package:web_basmati/screens/splash.dart';
import 'package:web_basmati/screens/subscriptions/add_sub_screen.dart';
import 'package:web_basmati/screens/subscriptions/manage_subscreen.dart';
import 'package:web_basmati/screens/subscriptions/subscriptions_screen.dart';
import 'package:web_basmati/screens_export.dart';

import '../screens/notification/notification_screen.dart';
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
        var data = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ViewUserScreen(
                  id: data,
                ));
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
      case AddUser.routeName:
        return MaterialPageRoute(builder: (_) => const AddUser());
      case NotificationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case SubscriptionsScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SubscriptionsScreen());
      case AddSubScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AddSubScreen());
      case ManageSubscriptionScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const ManageSubscriptionScreen());
      default:
        return null;
    }
  }

  static Map<String, WidgetBuilder> routes = {
    HomeScreen.routeName: (context) => const HomeScreen(),
    ItemsScreen.routeName: (context) => const ItemsScreen(),
    AddUser.routeName: (context) => const AddUser(),
    NotificationScreen.routeName: (context) => const NotificationScreen(),
    SubscriptionsScreen.routeName: (context) => const SubscriptionsScreen(),
    AddSubScreen.routeName: (context) => const AddSubScreen(),
    ManageSubscriptionScreen.routeName: (context) =>
        const ManageSubscriptionScreen(),
    AuthenticationScreen.routeName: (context) => const AuthenticationScreen(),
    "/splash": (context) => const Splash()
  };
}
