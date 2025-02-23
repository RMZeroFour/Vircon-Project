import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vircon/features/controller/snapshot.dart';
import 'package:vircon/features/controller/snapshot_batcher.dart';

// States
sealed class ClientSocketState {}

class ClientSocketInitial extends ClientSocketState {}

class ClientSocketConnecting extends ClientSocketState {}

class ClientSocketFailedToConnect extends ClientSocketState {}

class ClientSocketHandshaking extends ClientSocketState {}

class ClientSocketFailedHandshake extends ClientSocketState {
  final String reason;
  ClientSocketFailedHandshake(this.reason);
}

class ClientSocketConnected extends ClientSocketState {}

class ClientSocketTerminated extends ClientSocketState {}

// Events
sealed class ClientSocketEvent {}

class SendConnectionRequest extends ClientSocketEvent {}

class SendTerminationRequest extends ClientSocketEvent {}

// class ServerClosedConnection extends ClientSocketEvent {}

class ClientSocketBloc extends Bloc<ClientSocketEvent, ClientSocketState> {
  final String host;
  final int port;
  final SnapshotBatcher batcher;

  Socket? _socket;
  StreamSubscription<Snapshot>? _batcherSub;

  static const int reconnectionAttempts = 3;
  static const String clientName = "vircon Flutter Client";

  ClientSocketBloc(this.host, this.port, this.batcher)
      : super(ClientSocketInitial()) {
    on<SendConnectionRequest>(_onSendConnectionRequest);
    on<SendTerminationRequest>(_onSendTerminationRequest);
  }

  @override
  Future<void> close() {
    if (_socket != null) {
      add(SendTerminationRequest());
    }
    return super.close();
  }

  Future _onSendConnectionRequest(
      ClientSocketEvent event, Emitter<ClientSocketState> emit) async {
    _batcherSub?.cancel();
    _socket?.destroy();

    emit(ClientSocketConnecting());

    for (int i = 0; i < reconnectionAttempts; i++) {
      try {
        _socket = await Socket.connect(host, port);
        break;
      } catch (_) {
        _socket?.destroy();
        _socket = null;
      }
    }

    if (_socket != null) {
      emit(ClientSocketHandshaking());
      await _performHandshake(emit);
    } else {
      emit(ClientSocketFailedToConnect());
    }
  }

  Future _onSendTerminationRequest(
      ClientSocketEvent event, Emitter<ClientSocketState> emit) async {
    _batcherSub?.cancel();

    _socket?.destroy();
    _socket = null;

    emit(ClientSocketTerminated());
  }

  Future _performHandshake(Emitter<ClientSocketState> emit) async {
    try {
      const int version = 1;
      _socket!.add([version]);
      _socket!.flush();

      final received = await _socket!
          .take(1)
          .fold([], (current, next) => [...current, ...next]);
      
      final bool versionSupported = received[0] == 0;
      if (!versionSupported) {
        emit(ClientSocketFailedHandshake('Version Not Supported'));
        return;
      }

      final bool gamepadAvailable = received[1] == 0;
      if (!gamepadAvailable) {
        emit(ClientSocketFailedHandshake('No Gamepad Available'));
        return;
      }

      _socket!.add([clientName.length]);
      _socket!.write(clientName);
      _socket!.flush();

      emit(ClientSocketConnected());
      _batcherSub = batcher.stream.listen(_sendSnapshot);
    } catch (_) {
      add(SendConnectionRequest());
    }
  }

  Future _sendSnapshot(Snapshot ss) async {
    int buttons = 0;
    buttons |= (ss.a ? 1 : 0) << 0;
    buttons |= (ss.b ? 1 : 0) << 1;
    buttons |= (ss.x ? 1 : 0) << 2;
    buttons |= (ss.y ? 1 : 0) << 3;
    buttons |= (ss.l1 ? 1 : 0) << 4;
    buttons |= (ss.r1 ? 1 : 0) << 5;
    buttons |= (ss.l2 ? 1 : 0) << 6;
    buttons |= (ss.r2 ? 1 : 0) << 7;
    buttons |= (ss.up ? 1 : 0) << 8;
    buttons |= (ss.down ? 1 : 0) << 9;
    buttons |= (ss.left ? 1 : 0) << 10;
    buttons |= (ss.right ? 1 : 0) << 11;
    buttons |= (ss.select ? 1 : 0) << 12;
    buttons |= (ss.start ? 1 : 0) << 13;

    int axes = 0;
    axes |= (ss.lx & 0xFFFF) << 0;
    axes |= (ss.ly & 0xFFFF) << 16;
    axes |= (ss.rx & 0xFFFF) << 32;
    axes |= (ss.ry & 0xFFFF) << 48;

    final Uint8List bytes = Uint8List(10);
    final ByteData bytesView = ByteData.view(bytes.buffer);
    bytesView.setUint16(0, buttons, Endian.little);
    bytesView.setUint64(2, axes, Endian.little);

    try {
      _socket!.add(bytes);
      await _socket!.flush();
    } catch (_) {
      add(SendConnectionRequest());
    }
  }
}
