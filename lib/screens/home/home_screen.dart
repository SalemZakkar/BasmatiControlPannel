import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/helper/helper_export.dart';
import 'package:web_basmati/screens/home/widget/table_title.dart';
import 'package:web_basmati/screens/home/widget/user_info_card.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';

import '../../shared/widget/flush_messages.dart';
import '../../shared/widget/text_field_holder.dart';
import 'bloc/home_bloc.dart';

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
  String currentEmployees = "غير محدد";
  var employeesType = ["غير محدد", "عميل", "مشرف"];
  TextEditingController controller = TextEditingController();

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
                          controller: controller,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                  onTap: () {
                                    if (Validator.checkNumber(controller.text)) {
                                      context
                                          .read<HomeBloc>()
                                          .add(GetUserInfoByTypeEvent(
                                            searchByPhone: true,
                                            phoneNumber: controller.text.toString(),
                                            type: "",
                                          ));
                                    } else {
                                      print("is not valid");
                                    }
                                  },
                                  child: const Icon(Icons.search)),

                              // prefix: Icon(Icons.search),
                              contentPadding: const EdgeInsets.all(10),
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
                              if (current != "غير محدد") {
                                context.read<HomeBloc>().add(GetUserInfoByTypeEvent(
                                    searchByPhone: false,
                                    phoneNumber: "",
                                    type: current));
                              }
                            },
                          ),
                        ),
                      ),
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
                        "نوع الحساب",
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
                            value: currentEmployees,
                            items: employeesType.map((String data) {
                              return DropdownMenuItem(
                                value: data,
                                child: Text(data),
                              );
                            }).toList(),
                            onChanged: (data) {
                              setState(() {
                                currentEmployees = data.toString();
                              });
                              if (currentEmployees != "غير محدد") {
                                context.read<HomeBloc>().add(GetUserInfoByTypeEvent(
                                      searchByPhone: false,
                                      phoneNumber: "",
                                      type: currentEmployees,
                                    ));
                              }
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
                    child: BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state.stateStatusUserInfo.failure == true) {
                          showErrorMessageFlush(
                              context,
                              errorParse(
                                  state.stateStatusUserInfo.errorMessage.toString()),
                              state.stateStatusUserInfo.errorMessage ?? "");
                        }
                      },
                      builder: (context, state) {
                        if (state.stateStatusUserInfo.failure == true) {
                          return const Text("");
                        } else if (state.stateStatusUserInfo.success == true) {
                          if (state.userInfoTypeList.data!.isEmpty) {
                            return Text(state.userInfoTypeList.data!.length.toString());
                          } else {
                            return Scrollbar(
                              thumbVisibility: true,
                              interactive: false,
                              child: ListView.builder(
                                itemCount: state.userInfoTypeList.data!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return UserInfoCard(
                                    data: state.userInfoTypeList.data![index],
                                  );
                                },
                              ),
                            );
                          }
                        } else if (state.stateStatusUserInfo.inProgress == true) {
                          return const Center(child: CircularProgressIndicator());
                        } else {
                          return const Text("");
                        }
                      },
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
