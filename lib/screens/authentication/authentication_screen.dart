import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/helper/helper_export.dart';
import 'package:web_basmati/screens/authentication/bloc/auth_bloc.dart';

import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/flush_messages.dart';
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
  TextEditingController phone = TextEditingController(text: "0000000000");
  TextEditingController password = TextEditingController(text: "P@\$\$w0rd");
  bool p = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Container(
            height: 410,
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
                                height: 70,
                                child: TextFormField(
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  controller: phone,
                                  enableInteractiveSelection: false,
                                  keyboardType: TextInputType.multiline,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(9)
                                  ],
                                  validator: (value) {
                                    if (!Validator.checkNumber(phone.text) ||
                                        phone.text.length < 9) {
                                      return "رقم الهاتف غير صحبح";
                                    }
                                    return null;
                                  },
                                  onChanged: (e) {},
                                  decoration: InputDecoration(
                                      suffix: const Text("  966+"),
                                      fillColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      hintText: 'أدخل رقم الهاتف'),
                                ),
                              ),
                            )),
                      ),
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
                                height: 70,
                                child: TextFormField(
                                  obscureText: true,
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  controller: password,
                                  validator: (value) {
                                    if (!Validator.checkPassword(
                                        password.text)) {
                                      showErrorMessageFlushNoCode(
                                          context,
                                          "كلمة المرور يجب أن تكون بين 8 احرف الى 24 حرف\n"
                                          "يجب أن تحتوي احرف و أرقام و رموز");
                                      return "كلمة المرور لا يمكن استخدامها";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      hintText: 'أدخل كلمة المرور'),
                                ),
                              ),
                            )),
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
                                if (formGlobalKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(SignInEvent(
                                      phone: "+966${phone.text}",
                                      password: password.text));
                                }
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
