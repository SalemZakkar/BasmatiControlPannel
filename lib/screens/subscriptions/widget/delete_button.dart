import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/screens/subscriptions/bloc/subscription_bloc.dart';
import 'package:web_basmati/shared/widget/confirm_dialog.dart';

import '../../../shared/widget/flush_messages.dart';
import '../subscriptions_screen.dart';

class SubDeleteButton extends StatefulWidget {
  final String id;
  const SubDeleteButton({Key? key, required this.id}) : super(key: key);

  @override
  State<SubDeleteButton> createState() => _SubDeleteButtonState();
}

class _SubDeleteButtonState extends State<SubDeleteButton> {
  bool loading = false;
  SubscriptionBloc bloc = SubscriptionBloc();
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<SubscriptionBloc, SubscriptionState>(
            listener: (context, state) {
              if (state.wait == true) {
                setState(() {
                  loading = true;
                });
              } else {
                setState(() {
                  loading = false;
                });
              }
              if (state.success == true) {
                Navigator.pushNamedAndRemoveUntil(
                    context, SubscriptionsScreen.routeName, (route) => false);
              }
              if (state.fail == true) {
                showErrorMessageFlush(context, state.errorCode ?? "999");
              }
            },
            bloc: bloc,
          )
        ],
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).errorColor,
              ))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () async {
                  if (await confirm(context)) {
                    bloc.add(DeleteSubscription(id: widget.id));
                  }
                },
              ));
  }
}
