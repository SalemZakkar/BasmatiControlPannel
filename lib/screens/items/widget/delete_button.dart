import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widget/confirm_dialog.dart';
import '../../../shared/widget/flush_messages.dart';
import '../bloc/items_bloc.dart';
import '../items_screen.dart';

class ItemDeleteButton extends StatefulWidget {
  final String id;
  const ItemDeleteButton({Key? key, required this.id}) : super(key: key);

  @override
  State<ItemDeleteButton> createState() => _ItemDeleteButtonState();
}

class _ItemDeleteButtonState extends State<ItemDeleteButton> {
  bool deleting = false;
  ItemsBloc deleteBloc = ItemsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemsBloc, ItemsState>(
      bloc: deleteBloc,
      listener: (context, state) {
        if (state is ItemsFail) {
          showErrorMessageFlush(context, state.code);
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
    );
  }
}
