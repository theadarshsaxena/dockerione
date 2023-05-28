import 'package:flutter/material.dart';
import 'package:ssh2/ssh2.dart';

class DeviceDetailPage extends StatefulWidget {
  final String ipAddress;
  const DeviceDetailPage({super.key, required this.ipAddress});

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  String _result = 'xyz';
  bool _sudoEnabled = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _CommandController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<void> onClickCmd(
        String username, String password, String command, bool sudo) async {
      String result = 'xyz';
      String cmd = command;
      if (sudo) {
        cmd = "sudo " + cmd;
      }

      // resetValues();

      var client = SSHClient(
        // host: "ec2-15-207-21-119.ap-south-1.compute.amazonaws.com",
        host: widget.ipAddress,
        port: 22,
        username: username,
        passwordOrKey: password,
      );

      try {
        print(
            "Connecting to SSH... with user: $username and password $password and host ${widget.ipAddress}");
        result = await client.connect() ?? 'Null result';
        if (result == "session_connected") {
          print("Connected");
          result = await client.execute(cmd) ?? 'Null result';
          print("Here are the results: $result");
        }
        await client.disconnect();
      } catch (e) {
        String errorMessage = 'Error: ${e.toString()}';
        result = errorMessage;
        print(errorMessage);
      }

      setState(() {
        _result = result;
      });
    }

    void faaltu() {
      print("hi");
      setState(() {
        _result = "hi";
      });
    }

    // Widget renderButtons() {
    //   return ButtonTheme(
    //     padding: EdgeInsets.all(5.0),
    //     child: ButtonBar(
    //       children: <Widget>[
    //         TextButton(
    //           // onPressed: faaltu,
    //           onPressed: onClickCmd,
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //           ),
    //           child: const Text(
    //             'Test command',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: faaltu,
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //           ),
    //           // onPressed: onClickShell,
    //           // style: buttonStyle,
    //           child: const Text(
    //             'Test shell',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //         TextButton(
    //           onPressed: faaltu,
    //           style: ButtonStyle(
    //             backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    //           ),
    //           // onPressed: onClickSFTP,
    //           // style: buttonStyle,
    //           child: const Text(
    //             'Test SFTP',
    //             style: TextStyle(color: Colors.white),
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 16.0),
          Text("Device IP: " + widget.ipAddress),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text('Run as super user (sudo)'),
              const SizedBox(width: 8.0),
              Switch(
                value: _sudoEnabled,
                onChanged: (value) {
                  setState(() {
                    _sudoEnabled = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: _CommandController,
            decoration: const InputDecoration(
              labelText: 'command',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => onClickCmd(
                _usernameController.text,
                _passwordController.text,
                _CommandController.text,
                _sudoEnabled),
            // () {
            //   String username = _usernameController.text;
            //   String password = _passwordController.text;
            //   // Perform login logic here
            //   print('Username: $username');
            //   print('Password: $password');
            //   if (_sudoEnabled == true)
            //     print("true");
            //   else
            //     print("false");
            // },
            child: const Text('Login'),
          ),
          Text(_result),
        ],
      ),
    )
        //     body: ListView(
        //   shrinkWrap: true,
        //   padding: const EdgeInsets.all(5),
        //   children: <Widget>[
        //     const Text("Edit the connection settings if it does not work"),
        //     TextButton(onPressed: onClickCmd, child: const Text("Edit settings")),
        //     // renderButtons(),
        //     Text(_result),
        //   ],
        // )
        );
  }
}

// class DeviceDetailPage extends StatefulWidget {
//   final String ipAddress;

//   const DeviceDetailPage({required this.ipAddress});

//   @override
//   _DeviceDetailPageState createState() => _DeviceDetailPageState();
// }

// class _DeviceDetailPageState extends State<DeviceDetailPage> {
//   late SSHClient _sshClient;
//   String _deviceInformation = '';
//   String _dockerCommandOutput = '';
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _commandController = TextEditingController();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _connectToDevice();
//   //   _fetchDeviceInformation();
//   // }

//   // @override
//   // void dispose() {
//   //   _disconnectFromDevice();
//   //   super.dispose();
//   // }

//   Future<void> _connectToDevice() async {
//     _sshClient = SSHClient(
//       host: widget.ipAddress,
//       port: 22,
//       username: 'your_username',
//       passwordOrKey: 'your_password_or_private_key',
//     );

//     await _sshClient.connect();
//   }

//   Future<void> _disconnectFromDevice() async {
//     await _sshClient.disconnect();
//   }

//   Future<void> _fetchDeviceInformation() async {
//     await _sshClient.connectSFTP();
//     final response = await _sshClient.execute('command_to_fetch_device_info');
//     setState(() {
//       _deviceInformation = response!;
//     });
//     await _sshClient.disconnectSFTP();
//   }

//   Future<void> _executeDockerCommand(String command) async {
//     final response = await _sshClient.execute('docker $command');
//     setState(() {
//       _dockerCommandOutput = response!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Device Details'),
//       ),
//       body: Column(
//         children: [
//           Container(
//               padding: EdgeInsets.all(10.0),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text(
//                       'Enter SSH Credentials:',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     TextField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         hintText: 'Username',
//                       ),
//                     ),
//                     TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                       ),
//                     ),
//                   ])),
//           SizedBox(height: 10),
//           Text(_deviceInformation),
//           Container(
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Execute Docker Command:',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Enter Docker command',
//                   ),
//                   onSubmitted: (command) {
//                     _executeDockerCommand(command);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Text(_dockerCommandOutput),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
