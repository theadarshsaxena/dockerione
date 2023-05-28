import 'package:flutter/material.dart';
import 'package:ssh2/ssh2.dart';
// import 'dart:io';

class DeviceDetails extends StatelessWidget {
  const DeviceDetails({Key? key}) : super(key: key);
  void connectToServer() async {
    String result = '';
    var ssh = new SSHClient(
      host: 'your-server-ip',
      port: 22,
      username: 'your-username',
      passwordOrKey: 'your-password',
    );

    try {
      result = await ssh.connect() ?? 'Null result';
      print('Connected to server.');
      if (result == "session_connected") {
        result = await ssh.execute("ps") ?? 'Null result';
        print('Cmd run successfully');
      }
      // Execute commands or interact with the Docker engine here

      await ssh.disconnect();
      print('Disconnected from server.');
    } catch (e) {
      print('Error connecting to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Details')),
      body: const Center(
        child: Text('Device Details'),
      ),
    );
  }
}
