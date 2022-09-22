import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/items/bloc/items_bloc.dart';

class ItemBlocWrapper extends StatefulWidget {
  final Widget child;
  const ItemBlocWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<ItemBlocWrapper> createState() => _ItemBlocWrapperState();
}

class _ItemBlocWrapperState extends State<ItemBlocWrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ItemsBloc>(
        create: (context) => ItemsBloc(),
      )
    ], child: widget.child);
  }
}
