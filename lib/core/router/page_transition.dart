import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class PageTransition {
  static CustomTransitionPage cupertino({
    required GoRouterState state,
    Object? arguments,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      name: state.name,
      arguments: arguments,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: false,
          child: child,
        );
      },
      child: child,
    );
  }
}
