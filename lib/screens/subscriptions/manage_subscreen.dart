import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/subscriptions/bloc/subscription_bloc.dart';
import 'package:web_basmati/screens/subscriptions/model/subscription_model.dart';
import 'package:web_basmati/screens/subscriptions/subscriptions_screen.dart';
import 'package:web_basmati/screens/subscriptions/widget/delete_button.dart';

import '../../helper/validator.dart';
import '../../shared/widget/3d_button_widget.dart';
import '../../shared/widget/flush_messages.dart';
import '../../shared/widget/text_field_holder.dart';

class ManageSubscriptionScreen extends StatefulWidget {
  static const String routeName = "/manageSubscription";
  const ManageSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<ManageSubscriptionScreen> createState() =>
      _ManageSubscriptionScreenState();
}

class _ManageSubscriptionScreenState extends State<ManageSubscriptionScreen> {
  bool active = false;
  bool loading = false;
  SubscriptionBloc bloc = SubscriptionBloc();
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController lowPrice = TextEditingController();
  TextEditingController duration = TextEditingController();
  List<String> t = ["day", "month"];
  List<String> dTypes = ["أيام", "شهور"];
  int currentDType = 0;
  bool loaded = false;
  @override
  void initState() {
    super.initState();
  }

  double calcDiscount(double d, String price) {
    return double.parse(price) - (double.parse(price) * d);
  }

  late SubscriptionData data;
  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      data = ModalRoute.of(context)?.settings.arguments as SubscriptionData;
      name = TextEditingController(text: data.name.toString());
      des = TextEditingController(text: data.description.toString());
      duration = TextEditingController(text: data.duration?.value?.toString());
      currentDType = t.indexOf(data.duration!.unit!);
      price = TextEditingController(text: data.price?.toStringAsFixed(2));
      active = data.isActive!;
      if (data.discount != 0) {
        lowPrice = TextEditingController(
            text: calcDiscount(data.discount!.toDouble(), price.text)
                .toStringAsFixed(2));
      }
      loaded = true;
    }
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
          title: const Text("تعديل إشتراك"),
          toolbarHeight: 70,
          actions: [
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SubDeleteButton(id: data.id.toString()))
          ],
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
                            controller: des,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            validator: (value) {
                              if (!Validator.checkDescription(des.text)) {
                                return "الوصف غير صحيح";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "الوصف",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: active,
                          onChanged: (value) {
                            setState(() {
                              active = !active;
                            });
                          }),
                      Text(
                        "تفعيل",
                        style: Theme.of(context).textTheme.headline1,
                      )
                    ],
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
                                controller: price,
                                validator: (value) {
                                  if (!Validator.checkPrice(price.text)) {
                                    return "السعر غير صحيح";
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textAlign: TextAlign.center,
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
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
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
                                    bloc.add(EditSubscription(
                                        subscriptionData: SubscriptionData(
                                            name: name.text,
                                            id: data.id,
                                            isActive: active,
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
