import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_app_ecommerce/src/models/item.dart';

abstract class FBBaseItem {
  Future<List<Item>> getItemByServiceId(String serviceId);
}

class FBItem extends FBBaseItem {
  final CollectionReference _serviceShopColection = Firestore.instance.collection('service_shop');
  final CollectionReference _itemShopColection = Firestore.instance.collection('item_shop');
  final CollectionReference _itemColection = Firestore.instance.collection('items');

  @override
  Future<List<Item>> getItemByServiceId(String serviceId) async {
    List<String> serviceShopIds = List<String>();
    List<String> itemIds = List<String>();
    List<Item> listItems =  List<Item>();

    if (serviceId == null) {
      await _serviceShopColection.getDocuments().then((data) {
        data.documents.forEach((doc) {
          serviceShopIds.add(doc['id']);
        });
      });
    } else {
      await _serviceShopColection.where('service_id', isEqualTo: serviceId).getDocuments().then((data) {
        data.documents.forEach((doc) {
          serviceShopIds.add(doc['id']);
        });
      });
    }


    await Future.forEach(serviceShopIds, (value) async {
      await getListItemId(value).then((data) {
        itemIds = [...data, ...itemIds];
      });
    });

    await getItems(itemIds).then((data) {
      listItems = data;
    });

    return listItems;
  }

  Future<List<String>> getListItemId(String serviceShopId) async {
    List<String> ids = List<String>();

    await _itemShopColection.where('service_shop_id', isEqualTo: serviceShopId).getDocuments().then((data){
      data.documents.forEach((doc) {
        ids.add(doc['item_id']);
      });
    });

    return ids;
  }

  Future<List<Item>> getItems(List<String> itemIds) async {
    List<Item> items = List<Item>();

    await Future.forEach(itemIds, (value) async {
//      await _itemColection.where('id', isEqualTo: value).getDocuments().then((data) {
//        items.add(Item(data.documents[0]['id'], data.documents[0]['name']));
//      });
    });

    return items;
  }
}
