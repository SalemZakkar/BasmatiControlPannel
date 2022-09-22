import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/text_field_holder.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  TextEditingController phone = TextEditingController();
  List<String> userSub = ["غير محدد", "مشترك", "غير مشترك"];
  List<String> userType = ["عميل", "مسؤول"];
  int currentUser = 0;
  int currentType = 0;
  void get(BuildContext context, int skip, int limit) {
    context.read<HomeBloc>().add(GetUserEvent(
        type: currentType,
        skip: skip,
        limit: limit,
        phone: phone.text,
        sub: currentUser));
  }

  void refresh() {
    debugPrint("Refresh");
    context.read<SharedBloc>().add(ResetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<SharedBloc, SharedState>(
      listener: (context, state) {
        if (state is GetUsersState) {
          get(context, state.skip, state.limit);
        }
      },
      child: Container(
        width: size.width * 0.85,
        height: 95,
        alignment: Alignment.topRight,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 280,
              height: 140,
              child: ListTile(
                title: Text(
                  "رقم الهاتف",
                  style: Theme.of(context).textTheme.headline1,
                ),
                subtitle: TextFieldHolder(
                  height: 60,
                  width: 280,
                  child: TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    controller: phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9)
                    ],
                    decoration: const InputDecoration(
                        hintText: "رقم الهاتف", suffix: Text("  966+")),
                    onEditingComplete: () {
                      if (phone.text.trim().isNotEmpty) {
                        refresh();
                      }
                    },
                    onChanged: (v) {
                      if (v.isEmpty) {
                        refresh();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 140,
              child: ListTile(
                title: Text(
                  "نوع الإشتراك",
                  style: Theme.of(context).textTheme.headline1,
                ),
                subtitle: Align(
                  alignment: Alignment.centerRight,
                  child: TextFieldHolder(
                    height: 60,
                    width: 200,
                    child: DropdownButtonFormField(
                      items: userSub
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: SizedBox(
                                  child: Text(e),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        currentUser = userSub.indexOf(value.toString());
                      },
                      value: userSub[currentUser],
                    ),
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
            const SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: IconButton(
                onPressed: () {
                  refresh();
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//
// Container(
// width: size.width * 0.8,
// height: 90,
// alignment: Alignment.centerRight,
// color: Theme.of(context).scaffoldBackgroundColor,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// width: 330,
// height: 80,
// color: Theme.of(context).scaffoldBackgroundColor,
// child: ListTile(
// title: Text(
// "رقم الهاتف",
// style: Theme.of(context).textTheme.headline1,
// ),
// subtitle: TextFieldHolder(
// height: 40,
// width: 300,
// child: TextFormField(
// controller: controller,
// textDirection: TextDirection.ltr,
// decoration: InputDecoration(
// prefixIcon: GestureDetector(
// onTap: () {
// if (Validator.checkNumber(
// controller.text)) {
// context
//     .read<HomeBloc>()
//     .add(GetUserInfoByTypeEvent(
// searchByPhone: true,
// phoneNumber:
// controller.text.toString(),
// type: "",
// ));
// } else {}
// },
// child: const Icon(Icons.search)),
//
// // prefix: Icon(Icons.search),
// contentPadding: const EdgeInsets.all(10),
// hintText: "أدخل رقم الهاتف"),
// ),
// ),
// // trailing: Padding(
//   padding: const EdgeInsets.only(top: 27),
//   child: IconButton(
//     onPressed: () {},
//     icon: Icon(
//       Icons.search,
//       color: Theme.of(context).primaryColor,
//     ),
//   ),
// ),
// ),
// ),
// const SizedBox(
// width: 20,
// ),
// Container(
// width: 300,
// height: 80,
// color: Theme.of(context).scaffoldBackgroundColor,
// alignment: Alignment.topCenter,
// child: ListTile(
// title: Text(
// "نوع الإشتراك",
// style: Theme.of(context).textTheme.headline1,
// ),
// subtitle: TextFieldHolder(
// width: 300,
// height: 40,
// child: Container(
// width: 300,
// height: 40,
// decoration: BoxDecoration(
// color: Theme.of(context).cardColor,
// borderRadius: BorderRadius.circular(12)),
// padding: const EdgeInsets.only(right: 10),
// child: DropdownButtonFormField(
// focusNode: focusNode,
// value: current,
// items: userType.map((String data) {
// return DropdownMenuItem(
// value: data,
// child: Text(data),
// );
// }).toList(),
// onChanged: (data) {
// setState(() {
// current = data.toString();
// });
// if (current != "غير محدد") {
// context.read<HomeBloc>().add(
// GetUserInfoByTypeEvent(
// searchByPhone: false,
// phoneNumber: "",
// type: current));
// }
// },
// ),
// ),
// ),
// ),
// ),
// const SizedBox(
// width: 20,
// ),
// Container(
// width: 300,
// height: 80,
// color: Theme.of(context).scaffoldBackgroundColor,
// alignment: Alignment.topCenter,
// child: ListTile(
// title: Text(
// "نوع الحساب",
// style: Theme.of(context).textTheme.headline1,
// ),
// subtitle: TextFieldHolder(
// width: 300,
// height: 40,
// child: Container(
// width: 300,
// height: 40,
// decoration: BoxDecoration(
// color: Theme.of(context).cardColor,
// borderRadius: BorderRadius.circular(12)),
// padding: const EdgeInsets.only(right: 10),
// child: DropdownButtonFormField(
// focusNode: focusNode,
// value: currentEmployees,
// items: employeesType.map((String data) {
// return DropdownMenuItem(
// value: data,
// child: Text(data),
// );
// }).toList(),
// onChanged: (data) {
// setState(() {
// currentEmployees = data.toString();
// });
// if (currentEmployees != "غير محدد") {
// context
//     .read<HomeBloc>()
//     .add(GetUserInfoByTypeEvent(
// searchByPhone: false,
// phoneNumber: "",
// type: currentEmployees,
// ));
// }
// },
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
