import 'package:flutter/material.dart';

class UniquePageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  UniquePageRoute({required this.builder})
      : super(
    transitionDuration: Duration(milliseconds: 600),
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return builder(context);
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return Stack(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutBack,
              ),
            ),
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 0.8,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutBack,
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      );
    },
  );
}