import 'package:flutter/material.dart';

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
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(
              '/controller',
              arguments: {'host': _hostField.text, 'port': _portField.text},
            ),
            child: const Text('Connect'),
          ),
        ],
      ),
    );
  }
}
