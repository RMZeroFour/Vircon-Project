import 'package:vircon_client/domain/connect_to_server_usecase.dart';
import 'package:vircon_client/domain/disconnect_from_server_usecase.dart';
import 'package:vircon_client/domain/send_input_to_server_usecase.dart';
import 'package:vircon_client/domain/snapshot_model.dart';

import 'package:bloc/bloc.dart';

import 'dart:async';

sealed class ConnectionState {}

final class NotConnected extends ConnectionState {}

final class FailedToConnect extends ConnectionState {
  final String reason;
  FailedToConnect({required this.reason});
}

final class Connecting extends ConnectionState {
  final String host;
  final int port;
  Connecting({required this.host, required this.port});
}

final class Connected extends ConnectionState {
  final String host;
  final int port;
  Snapshot snapshot = Snapshot();
  Connected({required this.host, required this.port});
}

final class Disconnecting extends ConnectionState {}

class ConnectionCubit extends Cubit<ConnectionState> {
  final ConnectToServerUseCase _connect;
  final SendInputToServerUseCase _send;
  final DisconnectFromServerUseCase _disconnect;

  Timer? _timer;

  ConnectionCubit(this._connect, this._send, this._disconnect)
    : super(NotConnected());

  Future<void> connect(String host, int port) async {
    if (state is NotConnected || state is FailedToConnect) {
      emit(Connecting(host: host, port: port));
      if (await _connect(host, port)) {
        emit(Connected(host: host, port: port));
        _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
          if (state is Connected) {
            _send((state as Connected).snapshot);
          }
        });
      } else {
        emit(FailedToConnect(reason: ''));
      }
    }
  }

  Future<void> disconnect() async {
    if (state is Connected) {
      emit(Disconnecting());
      _timer!.cancel();
      _timer = null;
      await _disconnect();
      emit(NotConnected());
    }
  }
}
