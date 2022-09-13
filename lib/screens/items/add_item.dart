import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/helper/helper_export.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/screens/items/widget/new_item_image.dart';

import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/text_field_holder.dart';

class AddItem extends StatefulWidget {
  static const String routeName = "/addItemScreen";

  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<Uint8List> bytes = [];
  int status = 0;
  String error = "";
  bool loading = false;
  bool mainError = false;
  String text = "";
  bool imageError = false;
  late Widget functionWidget;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController itemName = TextEditingController();
  TextEditingController itemDes = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController old = TextEditingController();
  TextEditingController warranty = TextEditingController();
  @override
  void dispose() {
    itemName.dispose();
    itemDes.dispose();
    price.dispose();
    old.dispose();
    warranty.dispose();
    super.dispose();
  }

  //final ItemsBloc itemsBloc = ItemsBloc();
  @override
  Widget build(BuildContext context) {
    void pickFile() async {
      FilePickerResult? res = await FilePicker.platform.pickFiles(
          type: FileType.image,
          dialogTitle: "اختر صورة",
          allowMultiple: false,
          withData: true);
      if (res != null) {
        setState(() {
          bytes.add(res.files.single.bytes!);
        });
      }
    }

    void cancelFile(int i) {
      setState(() {
        bytes.removeAt(i);
      });
    }

    return BlocProvider<ItemsBloc>(
      create: (context) => ItemsBloc(),
      child: BlocConsumer<ItemsBloc, ItemsState>(
        listener: (context, state) {
          if (state is ItemSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, ItemsScreen.routeName, (route) => false);
          }
          if (state is RemoveItemState) {
            cancelFile(state.i);
          }
          if (state is ItemsFail) {
            setState(() {
              mainError = true;
              error = errorParse(state.code);
            });
          }
          if (state is ItemsLoading) {
            setState(() {
              loading = true;
              mainError = false;
            });
          } else {
            setState(() {
              loading = false;
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("إضافة منتج"),
            ),
            body: Form(
              key: key,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 330,
                        height: 100,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Text(
                            "اسم المنتج",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          subtitle: TextFieldHolder(
                            height: 70,
                            width: 300,
                            child: TextFormField(
                              controller: itemName,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "أدخل اسم المنتج"),
                              validator: (value) {
                                if (!Validator.checkName(value ?? "")) {
                                  return "الإسم غير صالح";
                                }
                                return null;
                              },
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
                        height: 20,
                      ),
                      Container(
                        height: bytes.isEmpty ? 0 : 220,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: (bytes.isEmpty
                            ? const SizedBox()
                            : ReorderableListView.builder(
                                footer: const SizedBox(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ItemNewImage(
                                    bytes: bytes[index],
                                    index: index,
                                    key: Key(index.toString()),
                                  );
                                },
                                itemCount: bytes.length,
                                onReorder: (old, n) {
                                  if (old < n) {
                                    n -= 1;
                                  }
                                  Uint8List i = bytes.removeAt(old);
                                  bytes.insert(n, i);
                                })),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          bytes.length < 4
                              ? Container(
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageError = false;
                                      });
                                      pickFile();
                                    },
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    child: Container(
                                      width: 130,
                                      height: 45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "إضافة صورة",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          imageError
                              ? Text(
                                  "رجاءً أضف صورة",
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 250,
                        alignment: Alignment.centerRight,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: ListTile(
                          title: Text(
                            "وصف المنتج",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFieldHolder(
                                  height: 200,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFormField(
                                    controller: itemDes,
                                    // textAlign: TextAlign.start,

                                    textAlignVertical: TextAlignVertical.top,
                                    decoration: const InputDecoration(
                                        hintText: "تفاصيل المنتج"),
                                    maxLines: null,

                                    expands: true,
                                    validator: (value) {
                                      if (!Validator.checkDescription(
                                          value ?? "")) {
                                        return "التفاصيل غير صالحة";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: ListTile(
                            title: Text(
                              "الضمان",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(),
                            ),
                            subtitle: Align(
                              alignment: Alignment.centerRight,
                              child: TextFieldHolder(
                                width: 340,
                                height: 70,
                                child: TextFormField(
                                  controller: warranty,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                  validator: (value) {
                                    if (value == null) {
                                      return null;
                                    } else {
                                      if (value.isEmpty ||
                                          value.trim().isEmpty) {
                                        return null;
                                      }
                                    }
                                    if (!Validator.checkPrice(value)) {
                                      return "الضمان غير صحيح";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'المدة بالشهور (اختياري)'),
                                ),
                              ),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180,
                            child: ListTile(
                                title: Text(
                                  "السعر",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextFieldHolder(
                                    width: 240,
                                    height: 70,
                                    child: TextFormField(
                                      controller: price,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.ltr,
                                      validator: (value) {
                                        if (!Validator.checkPrice(
                                            value ?? "")) {
                                          return "السعر غير صحيح";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: '00 ر.س'),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 180,
                            child: ListTile(
                                title: Text(
                                  "السعر المخفض",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(),
                                ),
                                subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextFieldHolder(
                                    width: 240,
                                    height: 70,
                                    child: TextFormField(
                                      controller: old,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.ltr,
                                      validator: (value) {
                                        if (value == null) {
                                          return null;
                                        } else {
                                          if (value.isEmpty ||
                                              value.trim().isEmpty) {
                                            return null;
                                          }
                                        }
                                        if (!Validator.checkPrice(value)) {
                                          return "السعر غير صحيح";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'إختياري'),
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: (loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MyCustomButton(
                                    height: 40,
                                    borderRadius: 22,
                                    color: Theme.of(context).primaryColor,
                                    width: 100,
                                    customWidget: Text(
                                      "حفظ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    function: () {
                                      // if (bytes.isEmpty) {
                                      //   setState(() {
                                      //     imageError = true;
                                      //   });
                                      // }
                                      if (key.currentState!.validate()) {
                                        ItemDetailsModel details =
                                            ItemDetailsModel(
                                                data: DetailsData(
                                                    isSpecial: false,
                                                    isActive: true,
                                                    price: double.tryParse(
                                                        old.text),
                                                    fullPrice: double.parse(
                                                        price.text),
                                                    name: itemName.text,
                                                    description: itemDes.text,
                                                    warranty: Warranty(
                                                        unit: "month",
                                                        value: double.tryParse(
                                                            warranty.text))));
                                        context.read<ItemsBloc>().add(
                                            ItemAddEvent(
                                                itemModel: details,
                                                bytes: bytes));
                                      }
                                    },
                                  )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: (mainError
                                ? Text(
                                    error,
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  )
                                : const SizedBox()),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
