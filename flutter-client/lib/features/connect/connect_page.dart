import 'package:flutter/material.dart';

import 'package:vircon/features/connect/connect_view.dart';

class ConnectPage extends StatelessWidget {
  final String? host;
  final String? port;

  const ConnectPage({
    super.key,
    this.host,
    this.port,
  });

  @override
  Widget build(BuildContext context) {
    return ConnectView(host, port);
  }
}
