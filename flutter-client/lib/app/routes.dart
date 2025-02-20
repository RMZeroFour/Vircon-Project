import 'package:flutter/material.dart';

import 'package:beamer/beamer.dart';

import 'package:vircon/features/connect/connect.dart';
import 'package:vircon/features/controller/controller.dart';

class ConnectRoute {
  static const String route = '/';

  static const String host = 'host';
  static const String port = 'port';
}

class ControllerRoute {
  static const String route = '/controller';
}

class AppLocations extends BeamLocation<BeamState> {
  AppLocations(super.routeInformation);

  @override
  List<String> get pathPatterns {
    return [
      ConnectRoute.route,
      ControllerRoute.route,
    ];
  }

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uri.path == ConnectRoute.route)
        BeamPage(
          key: ValueKey(ConnectRoute.route),
          title: 'Connect To Vircon Server',
          child: ConnectPage(),
        ),
      if (state.uri.path == ControllerRoute.route)
        BeamPage(
          key: ValueKey(ControllerRoute.route),
          title: 'Vircon Controller',
          child: ControllerPage(),
        ),
    ];
  }
}
