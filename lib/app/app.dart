import 'package:flutter/material.dart';
import 'package:simple_streaming_app/app/bloc_container.dart';
import 'package:simple_streaming_app/app/dependency_injection_objects.dart';
import 'package:simple_streaming_app/app/routes.dart';
import 'package:simple_streaming_app/core/config/config.dart';
import 'package:simple_streaming_app/core/view/layout/safearea_layout.dart';
import 'package:simple_streaming_app/core/view/theme/color_theme.dart';
import 'package:simple_streaming_app/features/common/view/components/connectivity_layout.dart';


class App extends StatelessWidget{
  Routes routes;
  static final String _TITLE_TEXT = 'Simple Music Player';

  App({
    Config config
  }) {
    DependencyInjectionObject().init(
      config: config,
    );
    routes = Routes();
    routes.setupRouter();
  }

  @override
  Widget build(BuildContext context) {

    return BlocContainer(
      child: MaterialApp(
        title: _TITLE_TEXT,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateTitle: (BuildContext context) {
          return _TITLE_TEXT;
        },
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Container(
              color: ColorTheme.white,
              child: SafeAreaLayout(
                child: child,
              ),
            ),
          );
        },
        debugShowCheckedModeBanner: false,
        initialRoute: routes.initialRoute,
        onGenerateRoute: routes.router.generator,
        onUnknownRoute: routes.handleOnUnknownRoute,
      ),
    );
  }
}