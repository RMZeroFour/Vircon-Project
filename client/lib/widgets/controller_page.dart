import 'package:vircon_client/data/socket_connection_repository.dart';
import 'package:vircon_client/data/socket_connection_service.dart';
import 'package:vircon_client/domain/connection_repository.dart';
import 'package:vircon_client/domain/snapshot_model.dart';
import 'package:vircon_client/domain/connect_to_server_usecase.dart';
import 'package:vircon_client/domain/send_input_to_server_usecase.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

class ControllerPage extends StatefulWidget {
  final String host;
  final String port;

  const ControllerPage({super.key, required this.host, required this.port});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  late final ConnectionRepository _connection;
  late final ConnectToServerUseCase _connect;
  late final SendInputToServerUseCase _send;
  late final Future<bool> _connectFuture;

  @override
  void initState() {
    super.initState();

    _connection = SocketConnectionRepository(SocketConnectionService());
    _connect = ConnectToServerUseCase(_connection);
    _send = SendInputToServerUseCase(_connection);

    _connectFuture = _connect(widget.host, int.parse(widget.port));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controller')),
      body: FutureBuilder(
        future: _connectFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done &&
              asyncSnapshot.hasData &&
              asyncSnapshot.data!) {
            final Random rng = Random();
            Timer.periodic(
              const Duration(milliseconds: 100),
              (_) async => await _send(generateRandomSnapshot(rng)),
            );

            return Text('Connected to ${widget.host}:${widget.port}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Snapshot generateRandomSnapshot(Random rng) {
    return Snapshot(
      a: rng.nextBool(),
      b: rng.nextBool(),
      x: rng.nextBool(),
      y: rng.nextBool(),
      l1: rng.nextBool(),
      r1: rng.nextBool(),
      l2: rng.nextBool(),
      r2: rng.nextBool(),
      dUp: rng.nextBool(),
      dDown: rng.nextBool(),
      dLeft: rng.nextBool(),
      dRight: rng.nextBool(),
      select: rng.nextBool(),
      start: rng.nextBool(),
      leftJs: Axes(
        x: rng.nextInt(65536) - 32768,
        y: rng.nextInt(65536) - 32768,
      ),
      rightJs: Axes(
        x: rng.nextInt(65536) - 32768,
        y: rng.nextInt(65536) - 32768,
      ),
    );
  }
}
