// import 'package:dockerione/pages/device_details_page.dart';
// import 'package:dockerione/pages/sshandhttptab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device.dart';
import 'device_provider.dart';
import 'device_details.dart';
import 'ssh_subpage.dart';
import 'sshandhttptab.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceProvider = Provider.of<DeviceProvider>(context);
    // final List<Device> devices = deviceProvider.devices;

    return Scaffold(
      appBar: AppBar(
        title: Text('Devices'),
      ),
      body: Consumer<DeviceProvider>(builder: (context, deviceProvider, _) {
        final List<Device> devices = deviceProvider.devices;
        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HttpSSHTab(ipAddress: device.ipAddress),
                      // HttpSSHTab(ipAddress: device.ipAddress),
                      // DeviceDetailPage(ipAddress: device.ipAddress),
                    ),
                  );
                },
                title: Text(
                  device.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TextFormField(
                //   initialValue: device.name,
                //   onChanged: (value) {
                //     device.name = value;
                //   },
                //   style: TextStyle(
                //     fontSize: 18.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   decoration: InputDecoration(
                //     labelText: 'Device Name',
                //     labelStyle: TextStyle(
                //       color: Colors.grey[600],
                //       fontSize: 14.0,
                //     ),
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: (Colors.grey[600])!,
                //       ),
                //     ),
                //     focusedBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.blue,
                //       ),
                //     ),
                //   ),
                // ),
                subtitle: Text(
                  'IP Address: ${device.ipAddress}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        // Edit button pressed
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deviceProvider
                            .removeDevice(device); // Remove the device
                      },
                    ),
                  ],
                ),
              ),
            );

            // return Card(
            //   margin: EdgeInsets.all(10.0),
            //   child: ListTile(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => DeviceDetails(),
            //         ),
            //       );
            //     },
            //     title: TextFormField(
            //       initialValue: device.name,
            //       onChanged: (value) {
            //         device.name = value;
            //       },
            //       decoration: InputDecoration(labelText: 'Device Name'),
            //     ),
            //     subtitle: Text('IP Address: ${device.ipAddress}'),
            //     trailing: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         IconButton(
            //           icon: Icon(Icons.edit),
            //           onPressed: () {
            //             // Edit button pressed
            //           },
            //         ),
            //         IconButton(
            //           icon: Icon(Icons.delete),
            //           onPressed: () {
            //             deviceProvider
            //                 .removeDevice(device); // Remove the device
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          },
        );
      }),
    );
  }
}
