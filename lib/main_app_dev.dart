import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_streaming_app/app/app.dart';
import 'package:simple_streaming_app/core/config/config.dart';
import 'package:simple_streaming_app/core/config/env_url.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App(
    config: Config(
      envUrl: EnvUrl.isDevelopment(),
    ) ,
  ));
}