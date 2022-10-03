import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:web_basmati/helper/payment_enum.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/home/model/order_details_model.dart';
import 'package:web_basmati/shared/widget/date_time.dart';
import 'package:web_basmati/shared/widget/error_notification.dart';

import 'widget/items_widget.dart';
import 'widget/order_log/order_card_state.dart';
import 'widget/order_log/table_header_state.dart';

class ViewOrderDetails extends StatefulWidget {
  static const String routeName = "/viewOrder";

  const ViewOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetails> createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  HomeBloc bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: const Text("معلومات الطلب"),
          toolbarHeight: 70,
          actions: [
            IconButton(
                onPressed: () {
                  bloc.add(GetOrderDetails(id: id, sub: false));
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is HomeInitial) {
              bloc.add(GetOrderDetails(id: id, sub: false));
            }
            if (state.stateStatusUserInfo.failure == true) {
              return errorNotification(
                  context, state.stateStatusUserInfo.errorMessage ?? "", () {
                bloc.add(GetOrderDetails(id: id, sub: false));
              });
            }
            if (state.stateStatusUserInfo.success == true) {
              List<Statuses> states = state.orderDetailsData?.statuses ?? [];
              List<ProductsOrder> products =
                  state.orderDetailsData?.products ?? [];
              return Container(
                constraints: const BoxConstraints.expand(),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "طريقة الدفع: ",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            state.orderDetailsData?.type == "Online"
                                ? "دفع عبر البطاقة"
                                : "دفع نقدي",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "حالة الطلب: ",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: states.length,
                        itemBuilder: (context, index) {
                          return myCustomItemsWidget(
                              context,
                              getPaymentStatus(states[index].status!),
                              getDate(DateFormat("yyyy-MM-dd")
                                  .parse(states[index].at.toString())));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "التكلفة: ",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            state.orderDetailsData?.totalPrice?.toString() ??
                                "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "ر.س ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 20),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        height: 2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "العروض",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: TableHeaderState(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                return OrderCardState(
                                  productOrder: products[index],
                                );
                              },
                            )),
                      ),

                      // const Align(alignment: Alignment.centerRight, child: ProductCard()),
                    ],
                  ),
                ),
              );
            }
            if (state.stateStatusUserInfo.inProgress == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        ));
  }
}
