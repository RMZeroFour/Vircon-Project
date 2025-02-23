import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vircon/features/connect/connect.dart';
import 'package:vircon/features/controller/client_socket_bloc.dart';
import 'package:vircon/features/controller/controller_view.dart';
import 'package:vircon/features/controller/snapshot_batcher.dart';

class ControllerPage extends StatelessWidget {
  const ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final ConnectionInfo info = context.read<ConnectionInfoCubit>().state!;
        final SnapshotBatcher batcher =
            SnapshotBatcher(Duration(milliseconds: 100));
        return ClientSocketBloc(info.host, info.port, batcher)
          ..add(SendConnectionRequest());
      },
      child: ControllerView(),
    );
  }
}
