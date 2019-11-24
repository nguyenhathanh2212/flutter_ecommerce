import '../service/service_service.dart';
import '../models/service.dart';
import 'dart:async';

class ServiceBloc {
  final ServiceService _serviceService = ServiceService();
  StreamController<Service> _serviceController = StreamController<Service>.broadcast();
  Stream get serviceStream => _serviceController.stream;


  void getServices() async {
    Service service = await _serviceService.getAll();

    _serviceController.sink.add(service);
  }

  void dispose() {
    _serviceController.close();
  }
}

final serviceBloc = ServiceBloc();
