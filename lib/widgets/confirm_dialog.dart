import 'package:flutter/material.dart';

Future<bool> confirm(BuildContext context) async {
  bool? ans;
  ans = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22)
          ),
          content: Container(
            height: 100,
            width: 200,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22)
            ),
            child: Text(
              "هل أنت متأكد ؟",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context , false);
            }, child:  Text("لا" , style: TextStyle(fontSize: 18 , color: Theme.of(context).textTheme.bodyText2!.color),)),
            TextButton(onPressed: (){
              Navigator.pop(context , true);
            }, child: const Text("نعم" , style: TextStyle(fontSize: 18))),
          ],
        );
      });
  ans ??= false;
  return ans;
}
