// import 'package:flutter/material.dart';
//
import 'package:flutter/material.dart';

class SlideHorizontalTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset(0.0, 0.0);
    var tween = Tween(begin: begin, end: end);
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
//
// // class _SlideUpTransitionBuilder extends StatelessWidget{
// //   _SlideUpTransitionBuilder({required this.child , required Animation<double> routeAnimation}) :
// //         _scaleAnimation = CurvedAnimation(
// //           parent: routeAnimation,
// //           curve: Curves.linear,
// //         ).drive(_scaleTween),
// //         _slideAnimation = CurvedAnimation(
// //           parent: routeAnimation,
// //           curve: Curves.linear,
// //         ).drive(_kBottomUpTween);
// //   final Animation<Offset> _slideAnimation;
// //   final Animation<double> _scaleAnimation;
// //
// //   static final Animatable<double> _scaleTween =
// //   Tween<double>(begin: 0.0, end: 1);
// //   static final Animatable<Offset> _kBottomUpTween = Tween<Offset>(
// //     begin: const Offset(0.0, 1.0),
// //     end: const Offset(0.0, 0.0),
// //   );
// //
// //   final Widget child;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SlideTransition(
// //       position: _slideAnimation,
// //       child: child,
// //     );
// //   }
// // }
