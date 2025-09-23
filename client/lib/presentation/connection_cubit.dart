import 'package:vircon_client/domain/connect_to_server_usecase.dart';
import 'package:vircon_client/domain/disconnect_from_server_usecase.dart';
import 'package:vircon_client/domain/send_input_to_server_usecase.dart';
import 'package:vircon_client/domain/snapshot_model.dart';

import 'package:bloc/bloc.dart';

enum ConnectionState {
  notConnected,
  failedToConnect,
  connecting,
  connected,
  disconnecting,
  disconnected,
}

class ConnectionCubit extends Cubit<ConnectionState> {
  final ConnectToServerUseCase _connect;
  final SendInputToServerUseCase _send;
  final DisconnectFromServerUseCase _disconnect;

  ConnectionCubit(this._connect, this._send, this._disconnect)
    : super(ConnectionState.notConnected);

  bool canConnect() {
    return state == ConnectionState.notConnected ||
        state == ConnectionState.disconnected;
  }

  Future<void> connect(String host, int port) async {
    if (state == ConnectionState.notConnected ||
        state == ConnectionState.disconnected) {
      emit(ConnectionState.connecting);
      if (await _connect(host, port)) {
        emit(ConnectionState.connected);
      } else {
        emit(ConnectionState.failedToConnect);
      }
    }
  }

  Future<void> sendInput(Snapshot ss) async {
    await _send(ss);
  }

  Future<void> disconnect() async {
    if (state == ConnectionState.connected) {
      emit(ConnectionState.disconnecting);
      await _disconnect();
      emit(ConnectionState.disconnected);
    }
  }
}
