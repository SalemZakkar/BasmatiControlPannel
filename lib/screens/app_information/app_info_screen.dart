import 'package:flutter/material.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';

import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/text_field_holder.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({Key? key}) : super(key: key);
  static const String routeName = 'app_information';

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                    style: Theme.of(context).textTheme.headline1!.copyWith(),
                  ),
                  subtitle: TextFieldHolder(
                      height: 220,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
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
                    width: 320,
                    child: ListTile(
                        title: Text(
                          "رقم التواصل",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerRight,
                          child: TextFieldHolder(
                            width: 240,
                            height: 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'أدخل رقم التواصل'),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 320,
                    child: ListTile(
                        title: Text(
                          "رقم Whatsapp",
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(),
                        ),
                        subtitle: Align(
                          alignment: Alignment.centerRight,
                          child: TextFieldHolder(
                            width: 240,
                            height: 45,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'أدخل رقم Whatsapp'),
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: MyCustomButton(
                      height: 40,
                      borderRadius: 22,
                      color: Theme.of(context).primaryColor,
                      width: 100,
                      customWidget: Text(
                        "حفظ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      function: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
