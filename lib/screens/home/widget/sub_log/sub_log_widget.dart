import 'package:flutter/material.dart';
import 'package:web_basmati/screens/home/model/subscription_log_model.dart';

class SubscriptionLogWidget extends StatefulWidget {
  final String id;
  const SubscriptionLogWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<SubscriptionLogWidget> createState() => _SubscriptionLogWidgetState();
}

class _SubscriptionLogWidgetState extends State<SubscriptionLogWidget> {
  int skip = 0, limit = 10;
  int? end;
  List<SubscriptionLogData> data = [];
  bool loading = false;
  ScrollController controller = ScrollController();
  void fetch() {
    if (loading) {
      return;
    }
    if (limit - 10 >= (end ?? double.infinity)) {
      return;
    }
  }

  void reset() {
    skip = 0;
    limit = 0;
    end = null;
    data.clear();
  }

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent) {
        fetch();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
