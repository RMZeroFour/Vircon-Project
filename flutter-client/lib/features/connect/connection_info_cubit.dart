import 'package:flutter_bloc/flutter_bloc.dart';

typedef ConnectionInfo = ({
  String host,
  int port,
});

class ConnectionInfoCubit extends Cubit<ConnectionInfo?> {
  ConnectionInfoCubit() : super(null);

  void set(String host, int port) => emit((host: host, port: port));
  void clear() => emit(null);
}
