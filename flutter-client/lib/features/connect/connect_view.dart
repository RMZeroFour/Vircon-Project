import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vircon/features/connect/connection_info_cubit.dart';
import 'package:vircon/features/connect/details_form.dart';

class ConnectView extends StatelessWidget {
  final String? host;
  final String? port;

  const ConnectView(
    this.host,
    this.port, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect'),
      ),
      body: DetailsForm(
        initialHost: host,
        initialPort: port,
        onConnect: (String host, int port) =>
            context.read<ConnectionInfoCubit>().set(host, port),
      ),
    );
  }
}
