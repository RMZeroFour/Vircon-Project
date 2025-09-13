import 'package:vircon_client/widgets/connect_page.dart';
import 'package:vircon_client/widgets/controller_page.dart';

import 'package:flutter/material.dart';

class VirconApp extends StatelessWidget {
  const VirconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      routes: {'/': (context) => ConnectPage()},
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, String>;
        final routes = <String, WidgetBuilder>{
          '/': (context) => ConnectPage(),
          '/controller': (context) =>
              ControllerPage(host: args['host']!, port: args['port']!),
        };
        return MaterialPageRoute(builder: routes[settings.name]!);
      },
    );
  }
}
