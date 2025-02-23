import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vircon/features/connect/connect.dart';
import 'package:vircon/features/controller/client_socket_bloc.dart';
import 'package:vircon/features/controller/gamepad.dart';

class ControllerView extends StatelessWidget {
  const ControllerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ConnectionInfoCubit, ConnectionInfo?>(
          builder: (context, state) =>
              Text('Controller (${state?.host}:${state?.port})'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: BlocBuilder<ClientSocketBloc, ClientSocketState>(
                builder: (context, state) {
                  return switch (state) {
                    ClientSocketInitial() =>
                      CircularProgressIndicator.adaptive(),
                    ClientSocketConnecting() =>
                      CircularProgressIndicator.adaptive(),
                    ClientSocketFailedToConnect() => Column(
                        children: [
                          Text('Failed to connect'),
                          IconButton(
                            onPressed: () => context
                                .read<ClientSocketBloc>()
                                .add(SendConnectionRequest()),
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ClientSocketHandshaking() =>
                      CircularProgressIndicator.adaptive(),
                    ClientSocketFailedHandshake() => Column(
                        children: [
                          Text(state.reason),
                          IconButton(
                            onPressed: () => context
                                .read<ClientSocketBloc>()
                                .add(SendConnectionRequest()),
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ClientSocketConnected() => Gamepad(),
                    ClientSocketTerminated() => Icon(Icons.close),
                  };
                },
              ),
            ),
          ),
          BlocListener<ClientSocketBloc, ClientSocketState>(
            listener: (context, state) {
              if (state is ClientSocketTerminated) {
                context.read<ConnectionInfoCubit>().clear();
              }
            },
            child: ElevatedButton(
              onPressed: () => context
                  .read<ClientSocketBloc>()
                  .add(SendTerminationRequest()),
              child: const Text('Disconnect'),
            ),
          ),
        ],
      ),
    );
  }
}
