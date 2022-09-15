import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/helper/error_message.dart';
import 'package:web_basmati/screens/items/items_screen.dart';
import 'package:web_basmati/screens/items/model/item_details_model.dart';
import 'package:web_basmati/screens/items/widget/manage_item_image.dart';

import '../../helper/validator.dart';
import '../../shared/widget/confirm_dialog.dart';
import '../../shared/widget/custom_button_widget.dart';
import '../../shared/widget/error_notification.dart';
import '../../shared/widget/flush_messages.dart';
import '../../shared/widget/text_field_holder.dart';
import 'bloc/items_bloc.dart';

class ManageItem extends StatefulWidget {
  static const String routeName = "/manageItemScreen";
  final String id;
  const ManageItem({Key? key, required this.id}) : super(key: key);

  @override
  State<ManageItem> createState() => _AddItemState();
}

class _AddItemState extends State<ManageItem> {
  ItemsBloc itemsBloc = ItemsBloc();
  ItemsBloc imagesBloc = ItemsBloc();
  ItemsBloc deleteBloc = ItemsBloc();
  String error = "";
  bool loading = false;
  bool mainError = false;
  bool imageError = false;
  bool loaded = false;
  bool uploading = false;
  bool deleting = false;
  String imageErrorText = "";
  bool active = false, fav = false;
  List<String> images = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController itemName = TextEditingController();
  TextEditingController itemDes = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController old = TextEditingController();
  TextEditingController warranty = TextEditingController();
  void refresh() {
    itemsBloc = ItemsBloc();
    imagesBloc = ItemsBloc();
    // deleteBloc = ItemsBloc();
  }

  void pickFile() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
        dialogTitle: "اختر صورة",
        withData: true,
        type: FileType.image,
        allowMultiple: false);
    if (res != null) {
      imagesBloc
          .add(UploadImageEvent(id: widget.id, bytes: res.files.single.bytes!));
    }
  }

  @override
  void dispose() {
    itemName.dispose();
    itemDes.dispose();
    price.dispose();
    old.dispose();
    warranty.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<ItemsBloc>().add(ItemGetDetails(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات المنتج"),
        toolbarHeight: 80,
        actions: [
          BlocListener<ItemsBloc, ItemsState>(
            bloc: deleteBloc,
            listener: (context, state) {
              if (state is ItemsFail) {
                showErrorMessageFlush(
                    context, errorParse(state.code), state.code);
              }
              if (state is ItemSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, ItemsScreen.routeName, (route) => false);
              }
              if (state is ItemsLoading) {
                setState(() {
                  deleting = true;
                });
              } else {
                setState(() {
                  deleting = false;
                });
              }
            },
            child: Container(
              width: 100,
              alignment: Alignment.center,
              child: deleting
                  ? CircularProgressIndicator(
                      color: Theme.of(context).errorColor,
                    )
                  : IconButton(
                      onPressed: () async {
                        if (await confirm(context)) {
                          deleteBloc.add(DeleteEvent(id: widget.id));
                        } else {}
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      )),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is! GetItemDetailsSuccess) {
            if (loaded) {
              loaded = false;
            }
          }
          if (state is ItemsFail) {
            return errorNotification(context, state.code, () {
              context.read<ItemsBloc>().add(ItemGetDetails(id: widget.id));
            });
          } else if (state is ItemsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetItemDetailsSuccess) {
            if (!loaded) {
              itemName = TextEditingController(
                  text: state.itemDetailsModel.data!.name!);
              itemDes = TextEditingController(
                  text: state.itemDetailsModel.data!.description!);
              price = TextEditingController(
                  text: state.itemDetailsModel.data!.fullPrice!
                      .toStringAsFixed(2));
              if (state.itemDetailsModel.data?.price != null) {
                old = TextEditingController(
                    text: (state.itemDetailsModel.data!.price!
                        .toStringAsFixed(2)));
              }
              if (state.itemDetailsModel.data?.warranty?.value != null) {
                warranty = TextEditingController(
                    text: state.itemDetailsModel.data?.warranty?.value
                        .toString());
              }

              images = state.itemDetailsModel.data?.images ?? [];
              active = state.itemDetailsModel.data?.isActive ?? false;
              fav = state.itemDetailsModel.data?.isSpecial ?? false;
              loaded = true;
            }

            return Form(
              key: key,
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: size.width,
                        height: 140,
                        child: Container(
                          height: 100,
                          width: 330,
                          alignment: Alignment.centerRight,
                          child: ListTile(
                            title: Text(
                              "اسم المنتج",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            subtitle: TextFieldHolder(
                              width: 330,
                              height: 80,
                              child: TextFormField(
                                controller: itemName,
                                onTap: () {
                                  itemDes.selection = TextSelection(
                                      baseOffset: itemDes.selection.baseOffset,
                                      extentOffset:
                                          itemDes.selection.extentOffset,
                                      affinity: TextAffinity.upstream,
                                      isDirectional: true);
                                },
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "أدخل اسم المنتج"),
                                validator: (value) {
                                  if (!Validator.checkName(value ?? "")) {
                                    return "الإسم غير صحيح";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: images.isEmpty ? 0 : 200,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: (images.isEmpty
                            ? const SizedBox()
                            : ReorderableListView.builder(
                                footer: const SizedBox(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return ManageItemImage(
                                    id: images[index],
                                    itemId: widget.id,
                                    key: Key(index.toString()),
                                  );
                                },
                                itemCount: images.length,
                                onReorder: (old, n) {
                                  if (old < n) {
                                    n -= 1;
                                  }
                                  String url = images.removeAt(old);
                                  images.insert(n, url);
                                })),
                      ),
                      BlocListener<ItemsBloc, ItemsState>(
                        bloc: imagesBloc,
                        listener: (context, state) {
                          if (state is ItemsLoading) {
                            setState(() {
                              uploading = true;
                              imageError = false;
                            });
                          } else {
                            setState(() {
                              uploading = false;
                            });
                          }
                          if (state is! ItemsFail) {
                            setState(() {
                              imageError = false;
                            });
                          }
                          if (state is ItemSuccess) {
                            context
                                .read<ItemsBloc>()
                                .add(ItemGetDetails(id: widget.id));
                          }
                          if (state is ItemsFail) {
                            //                 showErrorMessageFlush(context, errorParse(state.code), state.code);
                            setState(() {
                              imageErrorText = errorParse(state.code);
                              imageError = true;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            images.length < 4
                                ? (uploading
                                    ? const CircularProgressIndicator()
                                    : Container(
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              imageError = false;
                                            });
                                            pickFile();
                                          },
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent),
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          child: Container(
                                            width: 130,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                                      ))
                                : const SizedBox(),
                            const SizedBox(
                              width: 20,
                            ),
                            imageError
                                ? Text(
                                    imageErrorText,
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                                    textAlign: TextAlign.start,
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
                      Container(
                        width: size.width,
                        height: 80,
                        alignment: Alignment.centerRight,
                        child: ListTile(
                          title: Text(
                            "تفعيل ؟",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          subtitle: Row(
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: active,
                                  onChanged: (value) {
                                    setState(() {
                                      active = true;
                                    });
                                  }),
                              Text(
                                "نعم",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Radio(
                                  value: false,
                                  groupValue: active,
                                  onChanged: (value) {
                                    setState(() {
                                      active = false;
                                    });
                                  }),
                              Text(
                                "لا",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width,
                        height: 80,
                        alignment: Alignment.centerRight,
                        child: ListTile(
                          title: Text(
                            "أهم العروض ؟",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          subtitle: Row(
                            children: [
                              Radio(
                                  value: true,
                                  groupValue: fav,
                                  onChanged: (value) {
                                    setState(() {
                                      fav = true;
                                    });
                                  }),
                              Text(
                                "نعم",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Radio(
                                  value: false,
                                  groupValue: fav,
                                  onChanged: (value) {
                                    setState(() {
                                      fav = false;
                                    });
                                  }),
                              Text(
                                "لا",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
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
                          BlocListener(
                            listener: (context, state) {
                              if (state is ItemSuccess) {
                                context.read<ItemsBloc>().add(ResetItems());
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ItemsScreen.routeName, (route) => false);
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
                              if (state is ItemsFail) {
                                setState(() {
                                  error = errorParse(state.code);
                                  mainError = true;
                                });
                              }
                            },
                            bloc: itemsBloc,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 19),
                                //   child: IconButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           active = !active;
                                //         });
                                //       },
                                //       icon: active
                                //           ? const Icon(
                                //               Icons.circle,
                                //               color: Colors.green,
                                //             )
                                //           : const Icon(
                                //               Icons.hide_source,
                                //               color: Colors.red,
                                //             )),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 19),
                                //   child: IconButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           fav = !fav;
                                //         });
                                //       },
                                //       icon: fav
                                //           ? const Icon(
                                //               Icons.favorite,
                                //               color: Colors.red,
                                //             )
                                //           : const Icon(
                                //               Icons.favorite_border,
                                //               color: Colors.red,
                                //             )),
                                // ),
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
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          function: () {
                                            // if (images.isEmpty) {
                                            //   setState(() {
                                            //     imageError = true;
                                            //     imageErrorText =
                                            //         "الرجاء اضافة صور";
                                            //   });
                                            // }
                                            if (key.currentState!.validate()) {
                                              ItemDetailsModel data =
                                                  ItemDetailsModel(
                                                      data: DetailsData(
                                                          id: widget.id,
                                                          name: itemName.text,
                                                          description:
                                                              itemDes.text,
                                                          fullPrice:
                                                              double.parse(
                                                                  price.text),
                                                          price:
                                                              double.tryParse(
                                                                  old.text),
                                                          images: images,
                                                          isActive: active,
                                                          isSpecial: fav,
                                                          warranty: Warranty(
                                                              unit: "month",
                                                              value: double
                                                                  .tryParse(warranty
                                                                      .text))));
                                              itemsBloc.add(UpdateProductEvent(
                                                  itemDetailsModel: data));
                                            }
                                          },
                                        )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: mainError
                                        ? Text(
                                            error,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          )
                                        : const SizedBox())
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            debugPrint(state.toString());
            return const SizedBox();
          }
        },
      ),
    );
  }
}
