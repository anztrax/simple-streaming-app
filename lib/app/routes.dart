import 'package:flutter/widgets.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:simple_streaming_app/core/view/page_transition/fade_transition_route.dart';
import 'package:simple_streaming_app/features/common/view/pages/not_found_page.dart';
import 'package:simple_streaming_app/features/music/view/pages/playlist_page.dart';

typedef CreatePageCallback = Function(BuildContext context, Map<String, dynamic> params);

class Routes {
  fluro.FluroRouter router = fluro.FluroRouter();
  String initialRoute;

  void setupRouter() {
    initialRoute = PlaylistPage.routeName;

    router.define(PlaylistPage.routeName,
      handler: fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params){
          return PlaylistPage();
        }),
      transitionType: fluro.TransitionType.fadeIn
    );
  }

  Route<dynamic> handleOnUnknownRoute(RouteSettings settings) {
    return FadeTransitionRoute(
      page: NotFoundPage()
    );
  }
}