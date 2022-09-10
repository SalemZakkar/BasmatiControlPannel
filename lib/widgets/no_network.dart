import 'package:flutter/material.dart';

Widget errorNotification(BuildContext context , String error , VoidCallback callback) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.hide_source , color: Theme.of(context).errorColor,size: 50,),
        const SizedBox(height: 20,),
        Text(error , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red , fontSize: 22),),
        const SizedBox(height: 20,),
        TextButton(onPressed: (){
          callback.call();
        }, child: Text("اعادة المحاولة" , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.red , fontSize: 18),),)

      ],
    ),
  );
}
