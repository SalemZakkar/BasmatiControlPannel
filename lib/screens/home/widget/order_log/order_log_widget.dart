import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/home/widget/order_log/order_card.dart';
import 'package:web_basmati/screens/home/widget/order_log/table_header.dart';
import 'package:web_basmati/shared/widget/3d_button_widget.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';

import '../../model/order_logs_model.dart';

class OrderLogWidget extends StatefulWidget {
  final String id;
  const OrderLogWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderLogWidget> createState() => _OrderLogWidgetState();
}

class _OrderLogWidgetState extends State<OrderLogWidget> {
  HomeBloc bloc = HomeBloc();
  int skip = 0, limit = 10;
  int? end;
  List<OrderLogData> data = [];
  bool loading = false;
  ScrollController controller = ScrollController();
  void fetch() {
    if (loading) {
      return;
    }
    if (limit - 10 >= (end ?? double.infinity)) {
      return;
    }
    bloc.add(GetOrderLogs(limit: limit, skip: skip, sub: false));
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
              List<OrderLogData> raw = state.orderLogsModel?.data ?? [];
              end = state.orderLogsModel!.totalRecords!.toInt();
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
                    })
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height - 150,
            padding: const EdgeInsets.symmetric(vertical: 20),
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
                        return OrderLogCard(
                          data: data[index],
                        );
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
