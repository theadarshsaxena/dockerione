import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HTTPDetailTab extends StatefulWidget {
  final String ipAddress;
  const HTTPDetailTab({super.key, required this.ipAddress});

  @override
  State<HTTPDetailTab> createState() => _HTTPDetailTabState();
}

class _HTTPDetailTabState extends State<HTTPDetailTab> {
  String _result = 'Execute to get output';
  TextEditingController _CommandController = TextEditingController();
  fetchHttpRequest(String cmd) async {
    final Map<String, String> _queryParameters = <String, String>{
      'x': cmd,
    };
    var host =
        Uri.http(widget.ipAddress, '/cgi-bin/program.py', _queryParameters);
    print(host);
    var response = await http.get(host);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _result = response.body;
      });
    } else {
      _result = 'Request failed with status: ${response.statusCode}.';
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Device IP: " + widget.ipAddress),
            const SizedBox(
              height: 16,
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
              onPressed: () => fetchHttpRequest(_CommandController.text),
              child: const Text('Execute!!'),
            ),
            Text(
              "Output: ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16.0),
            Text(_result),
            SizedBox(height: 20),
            Text(
              "Docker commands help:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10.0),
            Text(
              "Container Related:",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 2.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _CommandController.text = "docker ps",
                    child: const Text('List running containers'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _CommandController.text = "docker ps -a",
                    child: const Text('list all containers'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker stop <container id>",
                    child: const Text('Stop a container'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker start <container id>",
                    child: const Text('Start a container'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker rm <container id>",
                    child: const Text('Delete a container'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker logs <container id>",
                    child: const Text('Logs of container'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Image Related:",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 2.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker list images",
                    child: const Text('List images'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker pull <image name>",
                    child: const Text('Pull image'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _CommandController.text = "docker rmi <image name>",
                    child: const Text('Delete an image'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Real world applications:",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 2.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _CommandController.text =
                        "docker run -d --name my-apache-app -p 80:8080 httpd:latest",
                    child: const Text('Launch a web server'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _CommandController.text = "docker ps -a",
                    child: const Text('list all containers'),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _CommandController.text =
                        "docker run -d --name my-apache-app -p 80:8080 httpd:latest",
                    child: const Text('Run web server'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
