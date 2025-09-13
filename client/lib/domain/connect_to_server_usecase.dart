import 'package:vircon_client/domain/connection_repository.dart';

class ConnectToServerUseCase {
  final ConnectionRepository _repository;

  const ConnectToServerUseCase(this._repository);

  Future<bool> call(String host, int port) => _repository.connect(host, port);
}