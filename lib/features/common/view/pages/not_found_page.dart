import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';

class NotFoundPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Halaman tidak dapat ditemukan :(', style: TextStyle(
            color: ColorTheme.neutralDarkGrey,
            fontSize: 16.0
          ), textAlign: TextAlign.center),
        ),
      )
    );
  }
}

