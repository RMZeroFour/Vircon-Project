import 'package:vircon_client/data/socket_connection_repository.dart';
import 'package:vircon_client/data/socket_connection_service.dart';
import 'package:vircon_client/domain/connection_repository.dart';
import 'package:vircon_client/domain/connect_to_server_usecase.dart';
import 'package:vircon_client/domain/disconnect_from_server_usecase.dart';
import 'package:vircon_client/domain/send_input_to_server_usecase.dart';
import 'package:vircon_client/presentation/connection_cubit.dart';
import 'package:vircon_client/widgets/connect_page.dart';
import 'package:vircon_client/widgets/controller_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class VirconRepositoriesProvider extends StatelessWidget {
  const VirconRepositoriesProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ConnectionRepository>(
          create: (context) =>
              SocketConnectionRepository(SocketConnectionService()),
        ),
      ],
      child: VirconBlocsProvider(),
    );
  }
}

class VirconBlocsProvider extends StatelessWidget {
  const VirconBlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCubit>(
          create: (context) {
            final repo = context.read<ConnectionRepository>();
            return ConnectionCubit(
              ConnectToServerUseCase(repo),
              SendInputToServerUseCase(repo),
              DisconnectFromServerUseCase(repo),
            );
          },
        ),
      ],
      child: VirconApp(),
    );
  }
}

class VirconApp extends StatelessWidget {
  const VirconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        '/': (context) => ConnectPage(),
        '/controller': (context) => ControllerPage(),
      },
    );
  }
}
