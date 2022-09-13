import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/screens/app_information/bloc/app_info_bloc.dart';
import 'package:web_basmati/screens/app_information/models/app_info_model.dart';
import 'package:web_basmati/screens/app_information/widget/phone_card.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';

import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/flush_messages.dart';
import '../../shared/widget/text_field_holder.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({Key? key}) : super(key: key);
  static const String routeName = '/app_information';

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  AppInfoBloc appInfoBloc = AppInfoBloc();
  bool mainError = false;
  bool loading = false;
  String error = "";
  List<String> phones = [];
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  bool loaded = false;
  @override
  void dispose() {
    phone.dispose();
    about.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return BlocProvider<AppInfoBloc>(
      create: (context) => AppInfoBloc(),
      child: BlocBuilder<AppInfoBloc, AppInfoState>(
        builder: (context, state) {
          if (state is! GetAppInfoSuccess) {
            loaded = false;
          }
          if (state is AppInfoInitial) {
            context.read<AppInfoBloc>().add(AppInfoGetEvent());
          }
          if (state is AppInfoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAppInfoSuccess) {
            if (!loaded) {
              phones = state.appInfoModel.data?.whatsApp ?? [];
              about = TextEditingController(
                  text: state.appInfoModel.data?.description ?? "");
              loaded = true;
            }
            return MultiBlocListener(
              listeners: [
                BlocListener<SharedBloc, SharedState>(
                  listener: (context, state) {
                    if (state is RemoveStateAppInfo) {
                      setState(() {
                        phones.removeAt(state.id);
                      });
                    }
                  },
                ),
                BlocListener<AppInfoBloc, AppInfoState>(
                    bloc: appInfoBloc,
                    listener: (context, state2) {
                      if (state2 is UpdateAppInfoSuccess) {
                        showSuccessFlushMessage(context , "تم حفظ المعلومات بنجاح");
                        setState(() {
                          loading = false;
                          mainError = false;
                        });
                      }
                      if (state2 is AppInfoFail) {
                        setState(() {
                          loading = false;
                          mainError = true;
                          error = errorParse(state2.code);
                        });
                      }
                      if (state2 is AppInfoLoading) {
                        setState(() {
                          loading = true;
                          mainError = false;
                        });
                      }
                    }),
              ],
              child: Scaffold(
                drawer: const DrawerWidget(),
                appBar: AppBar(
                  title: const Text("معلومات التطبيق"),
                  toolbarHeight: 80,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30.0),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 250,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListTile(
                            title: Text(
                              "معلومات التطبيق",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(),
                            ),
                            subtitle: TextFieldHolder(
                                height: 220,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextFormField(
                                  controller: about,
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.top,
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(
                            "روابط تواصل الإجتماعي",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 280,
                              child: ListTile(
                                  title: Text(
                                    "رقم التواصل",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(),
                                  ),
                                  subtitle: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextFieldHolder(
                                      width: 240,
                                      height: 45,
                                      child: TextFormField(
                                        controller: phone,
                                        onEditingComplete: () {
                                          if (phone.text.trim().isNotEmpty) {
                                            setState(() {
                                              phones.add(phone.text);
                                              phone.clear();
                                            });
                                          }
                                        },
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        decoration: const InputDecoration(
                                            hintText: 'أدخل رقم التواصل'),
                                      ),
                                    ),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 36),
                                child: IconButton(
                                    onPressed: () {
                                      if (phone.text.trim().isNotEmpty) {
                                        setState(() {
                                          phones.add(phone.text);
                                          phone.clear();
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.add))),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 36),
                            //   child: MyCustomButton(
                            //     height: 40,
                            //     borderRadius: 22,
                            //     color: Theme.of(context).primaryColor,
                            //     width: 100,
                            //     customWidget: Text(
                            //       "حفظ",
                            //       style: Theme.of(context).textTheme.bodyText1,
                            //     ),
                            //     function: () {},
                            //   ),
                            // )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: phones.length,
                          itemBuilder: (context, index) {
                            return PhoneCardWidget(
                                number: phones[index], index: index);
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: loading
                                    ? const CircularProgressIndicator()
                                    : MyCustomButton(
                                  height: 40,
                                  borderRadius: 22,
                                  color: Theme.of(context).primaryColor,
                                  width: 100,
                                  customWidget: Text(
                                    "حفظ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1,
                                  ),
                                  function: () {
                                    appInfoBloc.add(AppInfoUpdateEvent(
                                        data: AppInfoData(
                                            description: about.text,
                                            phones: phones)));
                                  },
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: (mainError
                                  ? Text(
                                      error,
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor,
                                          fontSize: 17),
                                    )
                                  : const SizedBox()),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AppInfoFail) {
            return errorNotification(context, state.code, () {
              context.read<AppInfoBloc>().add(AppInfoGetEvent());
            });
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
