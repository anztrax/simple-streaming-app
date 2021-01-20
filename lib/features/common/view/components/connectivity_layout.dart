import 'dart:async';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';

typedef ConnectivityLayoutChildBuilder = Widget Function(BuildContext context);
typedef ConnectionOnlineCallback = Function();
class ConnectivityLayout extends StatefulWidget{
  final ConnectivityLayoutChildBuilder builder;
  final ConnectionOnlineCallback onAbleToReconnectInternet;

  ConnectivityLayout({
    @required this.builder,
    @required this.onAbleToReconnectInternet
  });

  @override
  State<StatefulWidget> createState() {
    return _ConnectivityLayoutState();
  }
}

class _ConnectivityLayoutState extends State<ConnectivityLayout>{
  StreamSubscription networkSubscription;
  ConnectivityResult connectivityResult;
  bool displayStatus = true;

  @override
  void initState() {
    networkSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(connectivityResult == ConnectivityResult.none && result != ConnectivityResult.none){
        widget.onAbleToReconnectInternet();
      }

      setState(() {
        connectivityResult = result;
        displayStatus = true;

        if(result != ConnectivityResult.none){
          startTimer();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if(networkSubscription != null){
      networkSubscription.cancel();
    }
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 5), (){
      setState(() {
        displayStatus = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: widget.builder(context),
          ),
          showConnectivityIndicatorView()
        ],
      ),
    );
  }

  Widget showConnectivityIndicatorView(){
    String text = '';
    Color backgroundColor;
    bool isConnectivityNone = connectivityResult == ConnectivityResult.none;
    bool showContainer = isConnectivityNone ? true : displayStatus;
    if(isConnectivityNone){
      text = 'Internet terputus';
      backgroundColor = ColorTheme.red;
    }else{
      text = 'Terhubung ke internet';
      backgroundColor = ColorTheme.green;
    }

    return (showContainer)
      ? Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: 2.0
        ),
        child: Text(text, style: TextStyle(
          color: ColorTheme.white,
          fontSize: 12.0
        ), textAlign: TextAlign.center),
      )
      : SizedBox();
  }

}