import 'package:flutter/material.dart';

class SafeAreaLayout extends StatelessWidget{
  final Widget child;

  SafeAreaLayout({
    @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: this.child,
    );
  }
}