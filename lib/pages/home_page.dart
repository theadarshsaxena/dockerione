import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device.dart';
import 'device_provider.dart';

class Homepage extends StatelessWidget {
  final String title;

  const Homepage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: true);
    final textController = TextEditingController();
    void _addDevice(String ipAddress) {
      print('IP Address entered:');
      final device = Device(
        id: DateTime.now().millisecondsSinceEpoch,
        name: 'Device ${deviceProvider.devices.length + 1}',
        ipAddress: ipAddress,
      );
      deviceProvider.addDevice(device);
    }

    // final _ipUrlRegex =
    // r'^(http(s)?:\/\/)?[^\s\/$.?#].[^\s]*(:[0-9]+)?(\/[^\s]*)?$';
    final _ipx =
        r'^(((http|https):\/\/)?([A-Za-z0-9-]+\.){1,}[A-Za-z]{2,}(:[0-9]+)?(\/.*)?)$|^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(:[0-9]+)?(\/.*)?)$';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Docker iOne',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Made with love by Adarsh',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: 'Enter IP Address or Hostname',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid IP address or hostname.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final input = textController.text.trim();
                String? isValid = RegExp(_ipx).stringMatch(input);
                if (textController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please enter a valid IP address or hostname.')),
                  );
                }
                // else if (textController.text.isNotEmpty) {
                //   _addDevice(textController.text);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Device Added Successfully')),
                //   );
                //   textController.clear();
                // }
                else if (isValid != null) {
                  _addDevice(textController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Device Added Successfully')),
                  );
                  textController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Please enter a valid IP address or hostname.')),
                  );
                }
              },
              child: Text('Add device'),
            ),
          ],
        ),
      ),
    );
  }
}
