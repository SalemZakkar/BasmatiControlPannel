import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/widget/app_bar.dart';
import 'package:web_basmati/screens/home/widget/table_title.dart';
import 'package:web_basmati/screens/home/widget/user_info_card.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';
import 'bloc/home_bloc.dart';
import 'model/user_info_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int skip = 0, limit = 10;
  int? end;
  bool loading = false;
  List<UserMainData> data = [];
  ScrollController controller = ScrollController();
  void fetch() {
    if (loading) {
      return;
    }
    if (data.length >= (end ?? double.infinity)) {
      return;
    }
    debugPrint("READ");
    context
        .read<SharedBloc>()
        .add(GetUsersSharedEvent(skip: skip, limit: limit));
  }

  @override
  void initState() {
    fetch();
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("معلومات المستخدمين"),
        toolbarHeight: 80,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<SharedBloc, SharedState>(
            listener: (context, state) {
              if (state is ResetUserState) {
                debugPrint("RESET");
                setState(() {
                  data.clear();
                  skip = 0;
                  limit = 10;
                  end = null;
                  loading = false;
                });
                fetch();
              }
            },
          ),
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.stateStatusUserInfo.success == true) {
                end = state.userInfoTypeList.totalRecords?.toInt() ?? 0;
                List<UserMainData> nData = state.userInfoTypeList.data ?? [];
                setState(() {
                  for (var v in nData) {
                    data.add(v);
                  }
                  data = data.toSet().toList();
                });
                skip += 10;
                limit += 10;
              }
              if (state.stateStatusUserInfo.inProgress == true) {
                setState(() {
                  loading = true;
                });
              } else {
                setState(() {
                  loading = false;
                });
              }
            },
          )
        ],
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeSearchBar(),
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
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.stateStatusUserInfo.failure == true) {
                            return errorNotification(context,
                                state.stateStatusUserInfo.errorMessage ?? "999",
                                () {
                              setState(() {
                                data.clear();
                                skip = 0;
                                limit = 10;
                              });
                              fetch();
                            });
                          }
                          return Scrollbar(
                            thumbVisibility: true,
                            interactive: false,
                            controller: controller,
                            child: ListView.builder(
                              controller: controller,
                              itemCount: data.length + 1,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index < data.length) {
                                  return UserInfoCard(
                                    data: data[index],
                                  );
                                } else {
                                  return SizedBox(
                                    height: 40,
                                    width: 60,
                                    child: (loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Center()),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
