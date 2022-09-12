import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/screens/authentication/bloc/auth_bloc.dart';
import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/text_field_holder.dart';
import '../home/home_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);
  static const String routeName = "/auth";

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool loading = false;
  bool error = false;
  String errorText = "";
  String phone = "";
  bool p = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(22)),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) => false);
                }
                if (state is AuthError) {
                  setState(() {
                    error = true;
                    errorText = errorParse(state.code);
                  });
                }
                if (state is AuthLoading) {
                  setState(() {
                    loading = true;
                    error = false;
                  });
                } else {
                  setState(() {
                    loading = false;
                  });
                }
              },
              builder: (context, state) {
                return Form(
                  key: formGlobalKey,
                  child: Column(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "تسجيل الدخول",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 320,
                            child: ListTile(
                                title: Text(
                                  "رقم الهاتف",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextFieldHolder(
                                    width: 270,
                                    height: 45,
                                    child: TextFormField(
                                      enableInteractiveSelection: false,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          hintText: 'أدخل رقم الهاتف'),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 320,
                            child: ListTile(
                                title: Text(
                                  "كلمة المرور",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextFieldHolder(
                                    width: 270,
                                    height: 45,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          hintText: 'أدخل كلمة المرور'),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      (loading
                          ? const Center(
                              child: CircularProgressIndicator(strokeWidth: 3),
                            )
                          : MyCustomButton(
                              height: 40,
                              borderRadius: 22,
                              color: Theme.of(context).primaryColor,
                              width: 110,
                              customWidget: Text(
                                "تسجيل الدخول",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              function: () {
                                context.read<AuthBloc>().add(const SignInEvent(
                                    phone: "+9660000000001",
                                    password: "P@\$\$w0rd"));
                              },
                            )),
                      const SizedBox(
                        height: 5,
                      ),
                      error
                          ? Text(
                              errorText,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 14),
                            )
                          : const SizedBox()
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
