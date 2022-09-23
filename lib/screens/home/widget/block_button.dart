import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/flush_messages.dart';

class BlockButton extends StatefulWidget {
  final bool active;
  final String id;
  const BlockButton({Key? key, required this.active, required this.id})
      : super(key: key);

  @override
  State<BlockButton> createState() => _BlockButtonState();
}

class _BlockButtonState extends State<BlockButton> {
  bool loading = false;
  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, right: 20),
        child: BlocListener<HomeBloc, HomeState>(
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
              if (state.stateStatusUserInfo.failure == true) {
                showErrorMessageFlush(
                    context, state.stateStatusUserInfo.errorMessage.toString());
              }
              if (state.stateStatusUserInfo.success == true) {
                context.read<SharedBloc>().add(ResetUserEvent());
              }
            },
            child: loading
                ? const CircularProgressIndicator()
                : InkWell(
                    onTap: () {
                      homeBloc.add(UserActivation(
                          id: widget.id, active: !widget.active));
                    },
                    child: Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.active
                              ? Colors.red
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(22)),
                      child: Text(
                        widget.active ? "حظر الحساب" : "الغاء الحظر",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )));
  }
}
