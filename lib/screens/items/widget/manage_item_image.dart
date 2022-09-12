import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';
import 'package:web_basmati/web_services/web_services_export.dart';

import '../../../helper/error_message.dart';
import '../../../shared/widget/flush_messages.dart';

class ManageItemImage extends StatefulWidget {
  final String? id;
  final String itemId;
  const ManageItemImage({Key? key, required this.id, required this.itemId})
      : super(key: key);

  @override
  State<ManageItemImage> createState() => _ManageItemImageState();
}

class _ManageItemImageState extends State<ManageItemImage> {
  final ItemsBloc itemsBloc = ItemsBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsBloc, ItemsState>(
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
        if (state is ItemSuccess) {
          context.read<ItemsBloc>().add(ItemGetDetails(id: widget.itemId));
        }
        if (state is ItemsFail) {
          showErrorMessageFlush(context, errorParse(state.code), state.code);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.network(
                          "${EndPoints.baseUrl}/${EndPoints.imagePath}/${widget.id}",
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, chunk) {
                            if (chunk == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: chunk.expectedTotalBytes != null
                                      ? chunk.cumulativeBytesLoaded /
                                          chunk.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
              ),
              IconButton(
                  onPressed: () {
                    itemsBloc.add(DeleteImageEvent(
                        id: widget.id!, itemId: widget.itemId));
                  },
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Theme.of(context).errorColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, Uint8List> bytes = {};
