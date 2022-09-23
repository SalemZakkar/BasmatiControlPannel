import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/screens_export.dart';
import 'package:web_basmati/shared/widget/confirm_dialog.dart';

import '../../../shared/widget/flush_messages.dart';

class DeleteButton extends StatefulWidget {
  final String id;
  const DeleteButton({Key? key, required this.id}) : super(key: key);

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  HomeBloc homeBloc = HomeBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state.stateStatusUserInfo.inProgress == true) {
          setState(() {
            loading = true;
          });
        } else {
          setState(() {
            loading = false;
          });
        }
        if (state.stateStatusUserInfo.success == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
        if (state.stateStatusUserInfo.failure == true) {
          showErrorMessageFlush(
              context, state.stateStatusUserInfo.errorMessage ?? "999");
        }
      },
      child: Container(
        height: 70,
        width: 60,
        alignment: Alignment.center,
        child: loading
            ? CircularProgressIndicator(
                color: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () async {
                  if (await confirm(context)) {
                    homeBloc.add(DeleteUserEvent(id: widget.id));
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}
