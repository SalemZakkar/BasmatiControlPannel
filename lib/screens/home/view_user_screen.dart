import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/helper_export.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/home/model/user_model.dart';
import 'package:web_basmati/screens/home/widget/block_button.dart';
import 'package:web_basmati/screens/home/widget/delete_button.dart';
import 'package:web_basmati/screens/home/widget/order_log/order_log_widget.dart';
import 'package:web_basmati/screens/home/widget/sub_log/sub_log_widget.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';
import 'package:web_basmati/shared/widget/text_field_holder.dart';

import '../../shared/widget/flush_messages.dart';
import '../notification/notification_screen.dart';

class ViewUserScreen extends StatefulWidget {
  static const routeName = '/viewUser';
  const ViewUserScreen({Key? key}) : super(key: key);

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  HomeBloc homeBloc = HomeBloc();
  HomeBloc saveBloc = HomeBloc();
  late TextEditingController name;
  late TextEditingController phone;
  bool saving = false;
  TextEditingController password = TextEditingController();
  bool loaded = false;
  GlobalKey<FormState> globalKey = GlobalKey();
  bool activeWidget = false;
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات المستخدم"),
        toolbarHeight: 70,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.routeName,
                    arguments: <String>[id]);
              },
              icon: const Icon(Icons.notifications)),
          DeleteButton(
            id: id,
          ),
        ],
      ),
      body: MultiBlocListener(
          listeners: [
            BlocListener<SharedBloc, SharedState>(
              listener: (context, state) {
                if (state is ResetUserState) {
                  homeBloc.add(GetUserData(id: id));
                }
              },
            ),
            BlocListener<HomeBloc, HomeState>(
              bloc: saveBloc,
              listener: (context, state) {
                if (state.stateStatusUserInfo.inProgress == true) {
                  setState(() {
                    saving = true;
                  });
                } else {
                  setState(() {
                    saving = false;
                  });
                }
                if (state.stateStatusUserInfo.success == true) {
                  context.read<SharedBloc>().add(ResetUserEvent());
                  showSuccessFlushMessage(context, "تم حفظ البيانات");
                }
                if (state.stateStatusUserInfo.failure == true) {
                  showErrorMessageFlush(
                      context, state.stateStatusUserInfo.errorMessage ?? "999");
                }
              },
            )
          ],
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: homeBloc,
            builder: (context, state) {
              if (state is HomeInitial) {
                homeBloc.add(GetUserData(id: id));
              }
              if (state.stateStatusUserInfo.inProgress == true) {
                loaded = false;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.stateStatusUserInfo.failure == true) {
                return errorNotification(
                    context, state.stateStatusUserInfo.errorMessage ?? "999",
                    () {
                  homeBloc.add(GetUserData(id: id));
                });
              } else if (state.stateStatusUserInfo.success == true) {
                if (!loaded) {
                  name = TextEditingController(
                      text: state.userData?.fullName.toString());
                  phone = TextEditingController(
                      text:
                          state.userData?.phone.toString().split("+966").last);
                  loaded = true;
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topRight,
                  child: Form(
                    key: globalKey,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 270,
                                height: 100,
                                child: ListTile(
                                  title: Text(
                                    "اسم المستخدم",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  subtitle: TextFieldHolder(
                                    width: 270,
                                    height: 70,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (!Validator.checkName(name.text)) {
                                          return "الاسم غير صحيح";
                                        }
                                        return null;
                                      },
                                      controller: name,
                                      decoration: const InputDecoration(
                                          hintText: 'الإسم الثلاثي'),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 270,
                                height: 100,
                                child: ListTile(
                                  title: Text(
                                    "رقم الهاتف",
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  subtitle: TextFieldHolder(
                                    width: 270,
                                    height: 70,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (!Validator.checkNumber(
                                                phone.text) ||
                                            phone.text.length < 9) {
                                          return "الرقم غير صحيح";
                                        }
                                        return null;
                                      },
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.start,
                                      controller: phone,
                                      decoration: const InputDecoration(
                                          hintText: 'الرقم',
                                          suffix: Text("   966+  ")),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(9)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 270,
                            height: 100,
                            child: ListTile(
                              title: Text(
                                "كلمة المرور",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              subtitle: TextFieldHolder(
                                width: 270,
                                height: 70,
                                child: TextFormField(
                                  controller: password,
                                  validator: (value) {
                                    if (password.text.isEmpty ||
                                        password.text == "") {
                                      return null;
                                    }
                                    if (!Validator.checkPassword(
                                        password.text)) {
                                      showErrorMessageFlushNoCode(
                                          context,
                                          "كلمة المرور يجب أن تكون بين 8 احرف الى 24 حرف\n"
                                          "يجب أن تحتوي احرف و أرقام و رموز");
                                      return "كلمة المرور لا يمكن استخدامها";
                                    }
                                    return null;
                                  },
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      hintText: 'ادخل كلمة المرور الجديدة'),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(24)
                                  ],
                                  obscureText: true,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Checkbox(
                                  value: state.userData!.isVerified!.phone!,
                                  onChanged: (value) {}),
                              Text(
                                "حساب محقق",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: 270,
                                child: BlockButton(
                                    id: id, active: state.userData!.isActive!),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 270,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 10),
                                  child: saving
                                      ? const CircularProgressIndicator()
                                      : InkWell(
                                          onTap: () {
                                            if (globalKey.currentState!
                                                    .validate() &&
                                                !saving) {
                                              saveBloc.add(EditUserEvent(
                                                  password: password.text,
                                                  data: UserData(
                                                    id: id,
                                                    phone: phone.text,
                                                    fullName: name.text,
                                                  )));
                                            }
                                          },
                                          child: Container(
                                            width: 120,
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            child: const Text(
                                              "حفظ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: state.userData?.type == "Customer",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Radio(
                                    value: activeWidget,
                                    groupValue: false,
                                    onChanged: (value) {
                                      if (activeWidget) {
                                        setState(() {
                                          activeWidget = false;
                                        });
                                      }
                                    }),
                                Text(
                                  "سجلات الشراء",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Radio(
                                    value: activeWidget,
                                    groupValue: true,
                                    onChanged: (value) {
                                      if (!activeWidget) {
                                        setState(() {
                                          activeWidget = !activeWidget;
                                        });
                                      }
                                    }),
                                Text(
                                  "سجلات الاشتراكات",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: state.userData?.type == "Customer",
                            child: Align(
                              alignment: Alignment.center,
                              child: activeWidget
                                  ? SubscriptionLogWidget(
                                      id: id,
                                    )
                                  : OrderLogWidget(id: id),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )),
    );
  }
}
