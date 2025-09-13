import 'package:vircon_client/domain/connection_repository.dart';

class DisconnectFromServerUseCase {
  final ConnectionRepository _repository;

  const DisconnectFromServerUseCase(this._repository);

  Future<void> call() => _repository.disconnect();
}