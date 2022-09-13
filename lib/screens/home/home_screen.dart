import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/widget/table_title.dart';
import 'package:web_basmati/screens/home/widget/user_info_card.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';

import '../../shared/widget/text_field_holder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String current = "غير محدد";
  var userType = ["غير محدد", "مشترك", "غير مشترك"];
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("معلومات المستخدمين"),
        toolbarHeight: 80,
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.8,
              height: 90,
              alignment: Alignment.centerRight,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 330,
                    height: 80,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ListTile(
                      title: Text(
                        "رقم الهاتف",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: TextFieldHolder(
                        height: 40,
                        width: 300,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: "أدخل رقم الهاتف"),
                        ),
                      ),
                      // trailing: Padding(
                      //   padding: const EdgeInsets.only(top: 27),
                      //   child: IconButton(
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.search,
                      //       color: Theme.of(context).primaryColor,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 300,
                    height: 80,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    alignment: Alignment.topCenter,
                    child: ListTile(
                      title: Text(
                        "نوع الإشتراك",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      subtitle: TextFieldHolder(
                        width: 300,
                        height: 40,
                        child: Container(
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.only(right: 10),
                          child: DropdownButtonFormField(
                            focusNode: focusNode,
                            value: current,
                            items: userType.map((String data) {
                              return DropdownMenuItem(
                                value: data,
                                child: Text(data),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                current = data.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TableTitle(),
                  Container(
                    // width: size.width*0.75,
                    height: size.height * 0.56,
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    alignment: Alignment.topRight,
                    child: Scrollbar(
                      thumbVisibility: true,
                      interactive: false,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return const UserInfoCard();
                        },
                        itemCount: 20,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
