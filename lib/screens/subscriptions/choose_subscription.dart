import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';
import 'package:web_basmati/screens/subscriptions/add_sub_screen.dart';
import 'package:web_basmati/screens/subscriptions/bloc/subscription_bloc.dart';
import 'package:web_basmati/screens/subscriptions/widget/subscription_card.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';
import 'model/subscription_model.dart';

class ChooseSubscription extends StatefulWidget {
  static const String routeName = "/chooseSubscription";
  const ChooseSubscription({Key? key}) : super(key: key);

  @override
  State<ChooseSubscription> createState() => _ChooseSubscriptionState();
}

class _ChooseSubscriptionState extends State<ChooseSubscription> {
  int skip = 0, limit = 10;
  int? end;
  List<SubscriptionData> data = [];
  bool loading = false;
  ScrollController controller = ScrollController();
  SubscriptionBloc bloc = SubscriptionBloc();
  void refresh() {
    skip = 0;
    limit = 10;
    end = null;
    loading = false;
    data.clear();
  }

  void fetch() {
    if (loading) {
      return;
    }
    if (limit - 10 >= (end ?? double.infinity)) {
      return;
    }
    bloc.add(GetSubscriptions(skip: skip, limit: limit));
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
        BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state.wait == true) {
              setState(() {
                loading = true;
              });
            } else {
              loading = false;
            }
            if (state.success == true) {
              List<SubscriptionData> raw = state.subscriptionModel?.data ?? [];

              setState(() {
                for (int i = 0; i < raw.length; i++) {
                  data.add(raw[i]);
                }
                data = data.toSet().toList();
                skip += 10;
                limit += 10;
              });
            }
          },
          bloc: bloc,
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("إختر باقة اشتراك "),
          toolbarHeight: 70,
        ),
        body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.fail == true) {
              return errorNotification(context, state.errorCode ?? "999", () {
                refresh();
                fetch();
              });
            }
            return Container(
              constraints: const BoxConstraints.expand(),
              alignment: Alignment.center,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    maxCrossAxisExtent: 180),
                itemBuilder: (context, index) {
                  if (index < data.length) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () {
                        Navigator.pop<String>(context , data[index].id);
                      } ,
                      child: Container(
                        width: 180,
                        height: 180,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(22)),
                        alignment: Alignment.center,
                        child: Text(
                          data[index].name.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 20, overflow: TextOverflow.clip),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : null,
                  );
                },
                itemCount: data.length + 1,
              ),
            );
          },
        ),
      ),
    );
  }
}
