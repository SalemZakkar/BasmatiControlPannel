import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:web_basmati/config/config_export.dart';
import 'package:web_basmati/screens/authentication/bloc/auth_bloc.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';
import 'package:web_basmati/screens/navigation_screen/bloc/navigation_bloc.dart';
import 'package:web_basmati/screens/splash.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';

import 'screens/home/bloc/home_bloc.dart';

void main() {
  setPathUrlStrategy();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<NavigationBloc>(create: (context) => NavigationBloc()),
      BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      BlocProvider<ItemsBloc>(create: (context) => ItemsBloc()),
      BlocProvider<SharedBloc>(create: (context) => SharedBloc()),
      BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basmati Control Panel',
      theme: lightTheme,
      home: const Splash(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: MediaQuery(
                data: data.copyWith(textScaleFactor: 0.8), child: child!));
      },
    );
  }
}
