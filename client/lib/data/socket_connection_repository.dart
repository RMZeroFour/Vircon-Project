import 'package:vircon_client/data/socket_connection_service.dart';
import 'package:vircon_client/domain/connection_repository.dart';
import 'package:vircon_client/domain/snapshot_model.dart';

class SocketConnectionRepository implements ConnectionRepository {
  final SocketConnectionService _service;

  const SocketConnectionRepository(this._service);

  @override
  Future<bool> connect(String host, int port) => _service.connect(host, port);

  @override
  Future<void> sendInput(Snapshot ss) => _service.send(ss);

  @override
  Future<void> disconnect() => _service.disconnect();
}