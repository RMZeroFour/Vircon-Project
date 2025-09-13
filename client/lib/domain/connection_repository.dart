import 'package:vircon_client/domain/snapshot_model.dart';

abstract class ConnectionRepository {
  Future<bool> connect(String host, int port);
  Future<void> sendInput(Snapshot ss);
  Future<void> disconnect();
}