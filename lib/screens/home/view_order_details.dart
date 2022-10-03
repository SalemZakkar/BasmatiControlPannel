import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/widget/product_card.dart';

class ViewOrderDetails extends StatefulWidget {
  static const String routeName = "/viewOrder";
  const ViewOrderDetails({Key? key}) : super(key: key);

  @override
  State<ViewOrderDetails> createState() => _ViewOrderDetailsState();
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("معلومات الطلب"),
          toolbarHeight: 70,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "حالة الطلب: ",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "مدفوع",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
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
                      "نقدا",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                      "1234",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "العروض",
                    style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 25),
                  ),
                ),
                const SizedBox(height: 20,),
                //TODO HOSSAM
                const Align(
                  alignment: Alignment.centerRight,
                  child: ProductCard()
                ),
              ],

            ),
          ),
        ));
  }
}
