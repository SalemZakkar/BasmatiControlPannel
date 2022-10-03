import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/home/bloc/home_bloc.dart';
import 'package:web_basmati/screens/subscriptions/choose_subscription.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';
import 'package:web_basmati/shared/widget/confirm_dialog.dart';
import 'package:web_basmati/shared/widget/flush_messages.dart';

class AddSubscriptionButton extends StatefulWidget {
  final String id;
  const AddSubscriptionButton({Key? key, required this.id}) : super(key: key);

  @override
  State<AddSubscriptionButton> createState() => _AddSubscriptionButtonState();
}

class _AddSubscriptionButtonState extends State<AddSubscriptionButton> {
  bool loading = false;
  HomeBloc bloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            bloc: bloc,
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
                context.read<SharedBloc>().add(ResetUserEvent());
                showSuccessFlushMessage(context, "تم اضافة الاشتراك بنجاح");
              }
              if (state.stateStatusUserInfo.failure == true) {
                showErrorMessageFlush(
                    context, state.stateStatusUserInfo.errorMessage ?? "999");
              }
            },
          )
        ],
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : IconButton(
                onPressed: () async {
                  var data = await Navigator.pushNamed(
                      context, ChooseSubscription.routeName);
                  if (data == null) {
                    return;
                  }
                  if (await confirm(context)) {
                    bloc.add(
                        Subscribe(id: widget.id, sId: data.toString()));
                  }
                },
                icon: const Icon(Icons.add)));
  }
}
