import 'package:vircon_client/domain/snapshot_model.dart';
import 'package:vircon_client/presentation/connection_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart' hide ConnectionState;

class ControllerPage extends StatelessWidget {
  Snapshot _snapshot = Snapshot();

  ControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller')),
      body: BlocConsumer<ConnectionCubit, ConnectionState>(
        listener: (context, state) {
          if (state == ConnectionState.disconnected) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state == ConnectionState.connected) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().sendInput(
                    _snapshot = _snapshot.copyWith(dLeft: !_snapshot.dLeft),
                  ),
                  child: const Text('Left'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().sendInput(
                    _snapshot.copyWith(dRight: !_snapshot.dRight),
                  ),
                  child: const Text('Right'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().sendInput(
                    _snapshot = _snapshot.copyWith(dUp: !_snapshot.dUp),
                  ),
                  child: const Text('Up'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().sendInput(
                    _snapshot = _snapshot.copyWith(dDown: !_snapshot.dDown),
                  ),
                  child: const Text('Down'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().disconnect(),
                  child: const Text('Disonnect'),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
