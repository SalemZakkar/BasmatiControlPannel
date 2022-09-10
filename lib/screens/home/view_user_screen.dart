import 'package:flutter/material.dart';

class ViewUserScreen extends StatefulWidget {
  static const routeName = '/viewUser';

  const ViewUserScreen({Key? key}) : super(key: key);

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  late Map<bool, Color> buttonColor;
  List states = [true, false];

  @override
  Widget build(BuildContext context) {
    buttonColor = {
      true: Theme.of(context).cardColor,
      false: Theme.of(context).primaryColor
    };
    void press(int r) {
      for (int i = 0; i < 2; i++) {
        setState(() {
          states[i] = i == r;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات المستخدم"),
        toolbarHeight: 70,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 270,
                height: MediaQuery.of(context).size.height - 80,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    ListTile(
                      title: Text(
                        "بشار الصالح",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 25),
                      ),
                      subtitle: Text(
                        "+96612345678",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text(
                        "حالة الحساب",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 25),
                      ),
                      subtitle: Text(
                        "نشط",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                      trailing: SizedBox(
                        width: 80,
                        height: 40,
                        child: TextButton(
                          child: Text(
                            "حظر",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      title: Text(
                        "نوع الحساب",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 25),
                      ),
                      subtitle: Text(
                        "مستخدم عادي",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      ),
                      trailing: SizedBox(
                        width: 100,
                        height: 40,
                        child: TextButton(
                          child: Text(
                            "تعيين كمسؤول",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        press(0);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 45,
                        width: 220,
                        padding: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: buttonColor[states[0]],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        alignment: Alignment.centerRight,
                        child: Text("سجلات الشراء",
                            style: TextStyle(
                                fontSize: 20, color: buttonColor[!states[0]])),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        press(1);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 45,
                        width: 220,
                        padding: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: buttonColor[states[1]],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        alignment: Alignment.centerRight,
                        child: Text("سجلات الإشتراك",
                            style: TextStyle(
                                fontSize: 20, color: buttonColor[!states[1]])),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              width: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Theme.of(context).cardColor),
            )
          ],
        ),
      ),
    );
  }
}
