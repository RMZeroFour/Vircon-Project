import 'package:vircon_client/presentation/connection_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart' hide ConnectionState;

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  late final TextEditingController _hostField;
  late final TextEditingController _portField;

  @override
  void initState() {
    super.initState();

    _hostField = TextEditingController();
    _portField = TextEditingController();
  }

  @override
  void dispose() {
    _hostField.dispose();
    _portField.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connect')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _hostField,
            decoration: const InputDecoration(hintText: 'Host'),
          ),
          TextFormField(
            controller: _portField,
            decoration: const InputDecoration(hintText: 'Port'),
          ),
          BlocConsumer<ConnectionCubit, ConnectionState>(
            listener: (context, state) {
              if (state is Connected) {
                Navigator.of(context).pushNamed('/controller');
              }
            },
            builder: (context, state) {
              if (state is NotConnected) {
                return ElevatedButton(
                  onPressed: () => context.read<ConnectionCubit>().connect(
                    _hostField.text,
                    int.parse(_portField.text),
                  ),
                  child: const Text('Connect'),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
