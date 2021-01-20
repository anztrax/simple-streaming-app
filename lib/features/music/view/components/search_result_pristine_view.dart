import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';

class SearchResultPristineView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('HI selamat datang di aplikasi kami', style: TextStyle(
              color: ColorTheme.neutralDarkGrey,
              fontSize: 16.0,
            ), textAlign: TextAlign.center),
            SizedBox(
              height: 8.0,
            ),
            Text('Selamat mendengarkan & mencari lagu kesukaan kamu', style: TextStyle(
              color: ColorTheme.neutralBlueGrey,
              fontSize: 14.0
            ))
          ],
        ),
      ),
    );
  }
}