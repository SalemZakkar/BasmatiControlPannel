import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/items/add_item.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';
import 'package:web_basmati/screens/items/manage_item.dart';
import 'package:web_basmati/screens/navigation_screen/drawer.dart';

import '../../helper/helper_export.dart';
import '../../shared/widget/error_notification.dart';
import '../../shared/widget/text_field_holder.dart';
import '../home/home_exports.dart';
import 'model/get_items_model.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = '/itemScreen';

  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  int skip = 0, limit = 10;
  int? end;
  bool loading = false;
  ScrollController scrollController = ScrollController();
  List<ItemData> items = [];
  TextEditingController name = TextEditingController();
  TextEditingController low = TextEditingController();
  TextEditingController high = TextEditingController();
  final ItemsBloc itemsBloc = ItemsBloc();
  @override
  void initState() {
    itemsBloc.add(ItemGetEvent(skip: skip.toString(), limit: limit.toString()));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          end != null &&
          items.length < end!) {
        skip += 10;
        limit += 10;
        fetch(context);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void fetch(BuildContext context) {
    if (loading) {
      return;
    }
    String? lower, higher;
    if (Validator.checkPrice(low.text)) {
      lower = low.text;
    }
    if (Validator.checkPrice(high.text)) {
      higher = high.text;
    }
    itemsBloc.add(ItemGetEvent(
        skip: skip.toString(),
        limit: limit.toString(),
        low: lower,
        high: higher,
        name: (Validator.checkName(name.text) ? name.text : null)));
  }

  @override
  Widget build(BuildContext context) {
    void reset() {
      setState(() {
        items.clear();
        end = null;
        skip = 0;
        limit = 10;
      });
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("إدارة المنتجات"),
        toolbarHeight: 80,
        actions: [
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.1),
            child: Container(
              width: 130,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AddItem.routeName);
                },
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  width: 130,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        "إضافة منتج",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.95,
            height: 90,
            alignment: Alignment.centerRight,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: 80,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Text(
                      "أدخل إسم المنتج",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    subtitle: TextFieldHolder(
                      height: 40,
                      width: 300,
                      child: TextFormField(
                        controller: name,
                        textDirection: TextDirection.rtl,
                        onChanged: (value) {
                          if (!Validator.checkName(name.text)) {
                            reset();
                            fetch(context);
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (Validator.checkName(value)) {
                            reset();
                            fetch(context);
                          }
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "أدخل إسم المنتج"),
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
                      "السعر",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    subtitle: Row(
                      children: [
                        TextFieldHolder(
                          height: 40,
                          width: 100,
                          child: TextFormField(
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "الحد الأدنى"),
                              keyboardType: TextInputType.number,
                              controller: low,
                              onChanged: (value) {
                                if (!Validator.checkPrice(value)) {
                                  reset();
                                  fetch(context);
                                }
                              },
                              onFieldSubmitted: (value) {
                                if (Validator.checkPrice(value)) {
                                  reset();
                                  fetch(context);
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                        ),
                        Text(
                          "  -  \n",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        TextFieldHolder(
                          height: 40,
                          width: 100,
                          child: TextFormField(
                              onChanged: (value) {
                                if (!Validator.checkPrice(value)) {
                                  reset();
                                  fetch(context);
                                }
                              },
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              controller: high,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "الحد الأعلى"),
                              keyboardType: TextInputType.number,
                              onFieldSubmitted: (value) {
                                if (Validator.checkPrice(value)) {
                                  reset();
                                  fetch(context);
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: IconButton(
                        onPressed: () {
                          reset();
                          fetch(context);
                        },
                        icon: const Icon(Icons.search_rounded))),
              ],
            ),
          ),
          const SizedBox(height: 10.0),

          /// Grid View For Items
          BlocConsumer<ItemsBloc, ItemsState>(
            bloc: itemsBloc,
            listener: (context, state) {
              if (state is ItemsLoading) {
                setState(() {
                  loading = true;
                });
              } else {
                setState(() {
                  loading = false;
                });
              }
              if (state is GetItemSuccess) {
                end = state.data.totalRecords?.toInt() ?? 0;
                setState(() {
                  for (int i = 0; i < state.data.data!.length; i++) {
                    items.add(state.data.data![i]);
                  }
                });
              }
            },
            builder: (context, state) {
              if (state is ItemsFail) {
                items.clear();
                skip = 0;
                limit = 10;
                end = null;
                return Expanded(
                    child: errorNotification(context, state.code, () {
                  itemsBloc.add(ItemGetEvent(skip: "0", limit: "10"));
                }));
              }
              return Expanded(
                child: GridView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: items.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 200),
                    itemBuilder: (context, index) {
                      if (index < items.length) {
                        return GestureDetector(
                            onTap: () async {
                              printLog(
                                  stateID: "732456",
                                  data: "show category",
                                  isSuccess: true);
                              Navigator.pushNamed(context, ManageItem.routeName,
                                  arguments:
                                      ManageItem(id: items[index].id ?? ""));
                            },
                            child: MyCustomCategoryWidget(
                              data: items[index],
                            ));
                      } else {
                        return loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : const SizedBox();
                      }
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
