import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';

class ItemNewImage extends StatefulWidget {
  final Uint8List bytes;
  final int index;

  const ItemNewImage({Key? key, required this.bytes, required this.index})
      : super(key: key);

  @override
  State<ItemNewImage> createState() => _ItemNewImageState();
}

class _ItemNewImageState extends State<ItemNewImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: SizedBox(
        width: 160,
        height: 160,
        child: Stack(
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(22)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.memory(
                  widget.bytes,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  context
                      .read<ItemsBloc>()
                      .add(RemoveItemEvent(i: widget.index));
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Theme.of(context).errorColor,
                ))
          ],
        ),
      ),
    );
  }
}
