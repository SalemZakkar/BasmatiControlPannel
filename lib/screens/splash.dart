import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/authentication/authentication_screen.dart';
import 'package:web_basmati/screens/authentication/bloc/auth_bloc.dart';
import 'package:web_basmati/screens/authentication/persistance/storage.dart';
import 'package:web_basmati/screens/home/home_screen.dart';
import 'package:web_basmati/web_services/api_engine/api_engine.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void startApp(BuildContext context) async {
    ApiEngine.initDio();
    String? phone = await AuthStore.getPhone();
    String? pass = await AuthStore.getPass();
    if (phone == null || pass == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, AuthenticationScreen.routeName, (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      context.read<AuthBloc>().add(SignInEvent(phone: phone, password: pass));
    }
  }

  @override
  void initState() {
    startApp(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          }
          if (state is AuthError) {
            Navigator.pushNamedAndRemoveUntil(
                context, AuthenticationScreen.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints.expand(),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
