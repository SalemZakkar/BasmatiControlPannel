import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_basmati/helper/helper_export.dart';

import '../../../shared/widget/text_field_holder.dart';

class ItemsSearchBar extends StatefulWidget {
  const ItemsSearchBar({Key? key}) : super(key: key);

  @override
  State<ItemsSearchBar> createState() => _ItemsSearchBarState();
}

class _ItemsSearchBarState extends State<ItemsSearchBar> {
  TextEditingController name = TextEditingController();
  TextEditingController low = TextEditingController();
  TextEditingController high = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
                    if (value.isEmpty) {}
                  },
                  onFieldSubmitted: (value) {
                    if (Validator.checkName(name.text)) {}
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
                        onChanged: (value) {},
                        onFieldSubmitted: (value) {},
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
                        onChanged: (value) {},
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        controller: high,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: "الحد الأعلى"),
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {},
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
                  onPressed: () {}, icon: const Icon(Icons.search_rounded))),
        ],
      ),
    );
  }
}
