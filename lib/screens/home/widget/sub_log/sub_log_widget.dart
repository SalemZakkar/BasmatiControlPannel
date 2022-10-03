import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/home/model/subscription_log_model.dart';
import 'package:web_basmati/screens/home/widget/sub_log/add_subscription_button.dart';
import 'package:web_basmati/screens/home/widget/sub_log/sub_card.dart';
import 'package:web_basmati/screens/home/widget/sub_log/table_header.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';

import '../../../../shared/widget/3d_button_widget.dart';
import '../../../../shared/widget/error_notification.dart';

class SubscriptionLogWidget extends StatefulWidget {
  final String id;
  const SubscriptionLogWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<SubscriptionLogWidget> createState() => _SubscriptionLogWidgetState();
}

class _SubscriptionLogWidgetState extends State<SubscriptionLogWidget> {
  int skip = 0, limit = 10;
  int? end;
  HomeBloc bloc = HomeBloc();
  List<SubscriptionLogData> data = [];
  bool loading = false;
  ScrollController controller = ScrollController();
  void fetch() {
    if (loading) {
      return;
    }
    if (limit - 10 >= (end ?? double.infinity)) {
      return;
    }
    bloc.add(GetOrderLogs(limit: limit, skip: skip, sub: true, id: widget.id));
  }

  void reset() {
    skip = 0;
    limit = 10;
    end = null;
    data.clear();
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
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.stateStatusUserInfo.inProgress == true) {
              setState(() {
                loading = true;
              });
            } else {
              setState(() {
                loading = false;
              });
            }
            if (state.stateStatusUserInfo.success == true) {
              List<SubscriptionLogData> raw =
                  state.subscriptionLogModel?.data ?? [];
              end = state.subscriptionLogModel!.totalRecords!.toInt();
              setState(() {
                for (var e in raw) {
                  data.add(e);
                }
                data = data.toSet().toList();
              });
              skip += 10;
              limit += 10;
            }
          },
        ),
        BlocListener<SharedBloc , SharedState>(
          listener: (context , state){
            if(state is ResetUserState){
              reset();
              fetch();
            }
          },
        )
      ],
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                const TableHeader(),
                MyCustom3DButtonWithText(
                    text: "تحديث",
                    height: 40,
                    width: 80,
                    color: Theme.of(context).primaryColor,
                    borderRadius: 22,
                    function: () {
                      reset();
                      fetch();
                    }),
                const SizedBox(
                  width: 30,
                ),
                AddSubscriptionButton(id: widget.id)
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height - 170,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(22)),
            alignment: Alignment.center,
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.stateStatusUserInfo.failure == true) {
                  return errorNotification(context,
                      state.stateStatusUserInfo.errorMessage.toString(), () {
                    reset();
                    fetch();
                  });
                } else {
                  return ListView.builder(
                    itemCount: data.length + 1,
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < data.length) {
                        return SubCard(data: data[index]);
                      }
                      return Visibility(
                        visible: loading,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 80,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
