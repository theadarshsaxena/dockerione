import 'package:dockerione/pages/ssh_subpage.dart';
import 'package:flutter/material.dart';
import 'http_subpage.dart';

class HttpSSHTab extends StatelessWidget {
  final String ipAddress;
  const HttpSSHTab({Key? key, required this.ipAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(
                text: "ssh",
              ),
              Tab(text: "http")
            ]),
            title: const Text('Docker Orchestration'),
          ),
          body: TabBarView(children: [
            // call device details page
            DeviceDetailPage(ipAddress: ipAddress),
            HTTPDetailTab(ipAddress: ipAddress),
          ]),
        ));
  }
}
