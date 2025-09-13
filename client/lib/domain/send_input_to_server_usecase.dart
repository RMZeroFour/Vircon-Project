import 'package:vircon_client/domain/connection_repository.dart';
import 'package:vircon_client/domain/snapshot_model.dart';

class SendInputToServerUseCase {
  final ConnectionRepository _repository;

  const SendInputToServerUseCase(this._repository);

  Future<void> call(Snapshot ss) => _repository.sendInput(ss);
}