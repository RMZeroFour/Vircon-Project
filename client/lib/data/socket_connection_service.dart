import 'package:vircon_client/domain/snapshot_model.dart';

import 'package:async/async.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class SocketConnectionService {
  static final Duration socketTimeout = Duration(seconds: 5);
  static final (int, int) clientVersion = (0, 1);
  static final String clientName = 'Vircon Flutter Client';

  _BinarySocket? _socket;

  Future<bool> connect(String host, int port) async {
    final socket = await Socket.connect(host, port, timeout: socketTimeout);
    _socket = _BinarySocket(socket);

    if (await _performHandshake()) {
      return true;
    }

    await _socket!.close();
    _socket = null;
    return false;
  }

  Future<void> send(Snapshot ss) async {
    await _socket!.send(_packSnapshotToBytes(ss));
  }

  Future<void> disconnect() async {
    await _socket!.send(Uint8List.fromList(List.filled(10, 0xFF)));
    await _socket!.close();
    _socket = null;
  }

  Future<bool> _performHandshake() async {
    await _socket!.send(
      Uint8List.fromList([clientVersion.$1, clientVersion.$2]),
    );
    final accepted = (await _socket!.read(1))[0] != 0;

    if (accepted) {
      final nameBytes = utf8.encode(clientName);
      await _socket!.send(Uint8List.fromList([nameBytes.length]));
      await _socket!.send(nameBytes);

      final playerNum = (await _socket!.read(1))[0];
      print('Connected as player $playerNum');

      return true;
    }

    return false;
  }

  Uint8List _packSnapshotToBytes(Snapshot ss) {
    final buttons = [
      ss.a,
      ss.b,
      ss.x,
      ss.y,
      ss.l1,
      ss.r1,
      ss.l2,
      ss.r2,
      ss.dUp,
      ss.dDown,
      ss.dLeft,
      ss.dRight,
      ss.select,
      ss.start,
    ];

    int bitfield = 0;
    for (var i = 0; i < buttons.length; i++) {
      if (buttons[i]) {
        bitfield |= (1 << i);
      }
    }

    final bytes = Uint8List(10);
    final buffer = ByteData.sublistView(bytes);

    buffer.setUint16(0, bitfield, Endian.big);
    buffer.setInt16(2, ss.leftJs.x, Endian.big);
    buffer.setInt16(4, ss.leftJs.y, Endian.big);
    buffer.setInt16(6, ss.rightJs.x, Endian.big);
    buffer.setInt16(8, ss.rightJs.y, Endian.big);

    return bytes;
  }
}

class _BinarySocket {
  final Socket _socket;
  final StreamQueue _queue;

  _BinarySocket(this._socket) : _queue = StreamQueue(_socket);

  Future<void> send(Uint8List data) async {
    _socket.add(data);
    await _socket.flush();
  }

  Future<Uint8List> read(int count) async {
    final bytes = (await _queue.take(
      count,
    )).expand((e) => e).cast<int>().toList();
    return Uint8List.fromList(bytes);
  }

  Future<void> close() async {
    await _queue.cancel();
    await _socket.close();
  }
}
