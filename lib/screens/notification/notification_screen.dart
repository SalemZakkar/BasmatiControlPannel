import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/notification/model/notification_model.dart';
import 'package:web_basmati/shared/widget/flush_messages.dart';

import '../../shared/widget/text_field_holder.dart';
import 'bloc/notification_bloc.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = "/notification";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool loading = false;
  NotificationBloc bloc = NotificationBloc();
  @override
  Widget build(BuildContext context) {
    List<String> ids =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state.waiting == true) {
              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
            if (state.success == true) {
              showSuccessFlushMessage(context, "تم ارسال الإشعار");
            }
            if (state.fail == true) {
              showErrorMessageFlush(context, state.errorCode ?? "999");
            }
          },
          bloc: bloc,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: const Text("ارسال إشعار"),
        ),
        body: Form(
          key: globalKey,
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 270,
                    height: 100,
                    child: ListTile(
                      title: Text(
                        "العنوان",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: TextFieldHolder(
                        width: 270,
                        height: 70,
                        child: TextFormField(
                          controller: title,
                          validator: (value) {
                            if (title.text.trim().isEmpty) {
                              return "العنوان فارغ";
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'أدخل العنوان'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 300,
                    child: ListTile(
                      title: Text(
                        "النص",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: TextFieldHolder(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 210,
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: description,
                          validator: (value) {
                            if (description.text.trim().isEmpty) {
                              return "النص فارغ";
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'أدخل النص'),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 10),
                    child: loading
                        ? const CircularProgressIndicator()
                        : InkWell(
                            onTap: () {
                              if (globalKey.currentState!.validate()) {
                                bloc.add(NotifyEvent(
                                    data: NotificationData(
                                        title: title.text,
                                        body: description.text),
                                    ids: ids));
                              }
                            },
                            child: Container(
                              width: 120,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(22)),
                              child: const Text(
                                "ارسال",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
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
