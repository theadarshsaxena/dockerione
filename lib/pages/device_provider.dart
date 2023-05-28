import 'package:flutter/foundation.dart';
import '../models/device.dart';

class DeviceProvider with ChangeNotifier {
  List<Device> _devices = [];

  List<Device> get devices => _devices;

  void addDevice(Device device) {
    _devices.add(device);
    notifyListeners();
  }

  void removeDevice(Device device) {
    _devices.remove(device);
    notifyListeners();
  }
}
