import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_basmati/shared/shared_bloc/shared_bloc.dart';

class PhoneCardWidget extends StatefulWidget {
  final String number;
  final int index;
  const PhoneCardWidget({Key? key , required this.number , required this.index}) : super(key: key);

  @override
  State<PhoneCardWidget> createState() => _PhoneCardWidgetState();
}

class _PhoneCardWidgetState extends State<PhoneCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 320,
        height: 60,
        padding: const EdgeInsets.only(right: 26.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.number , style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 22),textDirection: TextDirection.ltr,),
            const Spacer(),
            IconButton(onPressed: (){
              context.read<SharedBloc>().add(RemoveEventAppInfo(id: widget.index));
            }, icon: Icon(Icons.delete , color: Theme.of(context).errorColor,))
          ],
        ),
      ),
    );
  }
}
