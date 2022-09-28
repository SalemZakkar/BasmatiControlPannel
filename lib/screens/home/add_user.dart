import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/home/home_screen.dart';
import 'package:web_basmati/screens/home/model/user_model.dart';

import '../../helper/validator.dart';
import '../../shared/widget/flush_messages.dart';
import '../../shared/widget/text_field_holder.dart';

class AddUser extends StatefulWidget {
  static const String routeName = "/addUser";
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  HomeBloc bloc = HomeBloc();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool saving = false;
  List<String> userType = ["عميل", "مسؤول"];
  List<String> sendType = ["Customer", "Admin"];
  int currentType = 0;
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          bloc: bloc,
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
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
            }
            if (state.stateStatusUserInfo.failure == true) {
              showErrorMessageFlush(
                  context, state.stateStatusUserInfo.errorMessage ?? "999");
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إضافة مستخدم"),
          toolbarHeight: 70,
        ),
        body: Form(
          key: globalKey,
          child: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 270,
                    height: 100,
                    child: ListTile(
                      title: Text(
                        "اسم المستخدم",
                        style: Theme.of(context).textTheme.headline1,
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
                          decoration:
                              const InputDecoration(hintText: 'الإسم الثلاثي'),
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
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: TextFieldHolder(
                        width: 270,
                        height: 70,
                        child: TextFormField(
                          validator: (value) {
                            if (!Validator.checkNumber(phone.text) ||
                                phone.text.length < 9) {
                              return "الرقم غير صحيح";
                            }
                            return null;
                          },
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          controller: phone,
                          decoration: const InputDecoration(
                              hintText: 'الرقم', suffix: Text("   966+  ")),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9)
                          ],
                        ),
                      ),
                    ),
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
                            if (!Validator.checkPassword(password.text)) {
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
                              hintText: 'ادخل كلمة المرور'),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(24)
                          ],
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 140,
                    child: ListTile(
                      title: Text(
                        "نوع الحساب",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: Align(
                        alignment: Alignment.centerRight,
                        child: TextFieldHolder(
                          height: 60,
                          width: 200,
                          child: DropdownButtonFormField(
                            items: userType
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: SizedBox(
                                        child: Text(e),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              currentType = userType.indexOf(value.toString());
                            },
                            value: userType[currentType],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Checkbox(
                          value: isActive,
                          onChanged: (value) {
                            setState(() {
                              isActive = !isActive;
                            });
                          }),
                      Text(
                        "حساب محقق",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: 270,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: saving
                          ? const CircularProgressIndicator()
                          : InkWell(
                              onTap: () {
                                if (globalKey.currentState!.validate() &&
                                    !saving) {
                                  bloc.add(AddUserEvent(
                                      data: UserData(
                                          fullName: name.text,
                                          phone: phone.text,
                                          type: sendType[currentType]),
                                      password: password.text));
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(22)),
                                child: const Text(
                                  "حفظ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
