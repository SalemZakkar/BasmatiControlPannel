import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/subscriptions/bloc/subscription_bloc.dart';
import 'package:web_basmati/screens/subscriptions/model/subscription_model.dart';
import 'package:web_basmati/screens/subscriptions/subscriptions_screen.dart';
import 'package:web_basmati/shared/widget/3d_button_widget.dart';
import 'package:web_basmati/shared/widget/flush_messages.dart';

import '../../helper/validator.dart';
import '../../shared/widget/text_field_holder.dart';

class AddSubScreen extends StatefulWidget {
  static const String routeName = "/addSubscription";
  const AddSubScreen({Key? key}) : super(key: key);

  @override
  State<AddSubScreen> createState() => _AddSubScreenState();
}

class _AddSubScreenState extends State<AddSubScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController lowPrice = TextEditingController();
  TextEditingController duration = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  SubscriptionBloc bloc = SubscriptionBloc();
  List<String> dTypes = ["أيام", "شهور"];
  List<String> t = ["day", "month"];
  bool loading = false;
  int currentDType = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state.wait == true) {
              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
            if (state.success == true) {
              Navigator.pushNamedAndRemoveUntil(
                  context, SubscriptionsScreen.routeName, (route) => false);
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
          title: const Text("إضافة إشتراك"),
          toolbarHeight: 70,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 270,
                        height: 100,
                        child: ListTile(
                          title: Text(
                            "اسم الإشتراك",
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
                              decoration: const InputDecoration(
                                  hintText: 'اسم الإشتراك'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 600,
                      height: 320,
                      child: ListTile(
                        title: Text(
                          "الوصف",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        subtitle: TextFieldHolder(
                          width: 600,
                          height: 250,
                          child: TextFormField(
                            maxLines: null,
                            expands: true,
                            controller: des,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                              hintText: "الوصف",
                            ),
                            validator: (value) {
                              if (!Validator.checkDescription(des.text)) {
                                return "الوصف غير صحيح";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      height: 120,
                      child: ListTile(
                        title: Text(
                          "نوع المدة",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        subtitle: TextFieldHolder(
                          width: 270,
                          height: 100,
                          child: DropdownButtonFormField(
                            onChanged: (v) {
                              currentDType = dTypes.indexOf(v.toString());
                              debugPrint(currentDType.toString());
                            },
                            items: dTypes
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toString()),
                                    ))
                                .toList(),
                            value: dTypes[currentDType],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 200,
                      height: 120,
                      child: ListTile(
                        title: Text(
                          "المدة",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        subtitle: TextFieldHolder(
                            width: 270,
                            height: 100,
                            child: TextFormField(
                              controller: duration,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.center,
                              validator: (value) {
                                if (!Validator.checkNumber(duration.text)) {
                                  return "المدة غير صحيحة";
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: 'المدة'),
                            )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 120,
                        child: ListTile(
                          title: Text(
                            "السعر",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          subtitle: TextFieldHolder(
                              width: 270,
                              height: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
                                controller: price,
                                validator: (value) {
                                  if (!Validator.checkPrice(price.text)) {
                                    return "السعر غير صحيح";
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(hintText: '00 ر.س'),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        height: 120,
                        child: ListTile(
                          title: Text(
                            "السعر المخفض",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          subtitle: TextFieldHolder(
                              width: 270,
                              height: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                controller: lowPrice,
                                validator: (value) {
                                  if (lowPrice.text.isEmpty) {
                                    return null;
                                  }
                                  if (!Validator.checkPrice(lowPrice.text)) {
                                    return "السعر غير صحيح";
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.center,
                                decoration:
                                    const InputDecoration(hintText: '00 ر.س'),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: loading
                            ? const CircularProgressIndicator()
                            : MyCustom3DButtonWithText(
                                text: "حفظ",
                                height: 50,
                                width: 100,
                                color: Theme.of(context).primaryColor,
                                borderRadius: 22,
                                function: () {
                                  if (globalKey.currentState!.validate()) {
                                    bloc.add(AddSubscription(
                                        subscriptionData: SubscriptionData(
                                            name: name.text,
                                            price: double.parse(price.text),
                                            description: des.text,
                                            discount:
                                                setDiscount(lowPrice.text) ?? 0,
                                            duration: SubDuration(
                                                unit: t[currentDType],
                                                value: double.parse(
                                                    duration.text)))));
                                  }
                                }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double? setDiscount(String text) {
    if (text.isNotEmpty) {
      return ((double.parse(text) * 100) / double.parse(price.text)) / 100;
    }
    return null;
  }
}
