import 'package:flutter/material.dart';
import 'package:web_basmati/config/config_export.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';
import 'package:web_basmati/screens/items/model/get_items_model.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

class MyCustomCategoryWidget extends StatefulWidget {
  final ItemData data;
  const MyCustomCategoryWidget({Key? key, required this.data})
      : super(key: key);

  @override
  State<MyCustomCategoryWidget> createState() => _MyCustomCategoryWidgetState();
}

class _MyCustomCategoryWidgetState extends State<MyCustomCategoryWidget> {
  final ItemsBloc itemsBloc = ItemsBloc();
  String calc(double price , double discount)
  {
    String old = (price + (( discount) * price / (1 - discount))).toStringAsFixed(2);
    return old;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
              width: 230,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: widget.data.image == null
                    ? Image.asset(
                        AppAssets.noImage,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        "${EndPoints.baseUrl}${EndPoints.imagePath}/${widget.data.image}",
                        height: 200.0,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, widget, chunk) {
                          if (chunk == null) return widget;
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              value: (chunk.expectedTotalBytes != null
                                  ? chunk.cumulativeBytesLoaded /
                                      chunk.expectedTotalBytes!
                                  : null),
                            ),
                          );
                        },
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).errorColor,
                            ),
                          );
                        },
                      ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.data.name ?? "n/a",
                style: Theme.of(context).textTheme.headline2,
                textScaleFactor: 0.8,
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                (widget.data.discount?.toDouble() == 0
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          calc(widget.data.price!.toDouble(), widget.data.discount!.toDouble()),
                          style: const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )),
                Text(widget.data.price?.toStringAsFixed(2) ?? "n/a",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 15)),
                const SizedBox(
                  width: 4,
                ),
                Text('ر.س ',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 15)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
