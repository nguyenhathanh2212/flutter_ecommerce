import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service.dart';

abstract class FBBaseService {
  Future<List<Service>> getServices();
}

class FBService extends FBBaseService {
  final CollectionReference _servicesColection = Firestore.instance.collection('services');

  @override
  Future<List<Service>> getServices() async {
    List<Service> listServices =  List<Service>();

    await _servicesColection.getDocuments().then((ds){
      if (ds != null) {
        ds.documents.forEach((value){
          dynamic item = value.data;
//          Service service = Service(item['id'], item['name'], item['icon_url']);
//          listServices.add(service);
        });
      }
    });

    return listServices;
  }
}
