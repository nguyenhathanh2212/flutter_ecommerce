import '../models/item.dart';
import 'dart:async';
import 'package:simple_app_ecommerce/src/service/item_service.dart';

class ItemBloc {
  final ItemService _itemService = ItemService();
  StreamController<Item> _itemController = StreamController<Item>.broadcast();
  Stream get itemStream => _itemController.stream;
  Map<int, Item> listServiceItems = Map<int, Item>();

  void getItemByServiceId(int serviceId) async {
    Item listItems;
    int keyTemp = serviceId == null ? 0 : serviceId;

    if (listServiceItems.containsKey(keyTemp)) {
      listItems = listServiceItems[keyTemp];
    } else {
      listItems =  keyTemp == 0 ? await _itemService.getAll() : await _itemService.getByServiceId(serviceId);
      listServiceItems[keyTemp] = listItems;
    }

    _itemController.sink.add(listItems);
  }

  void dispose() {
    _itemController.close();
  }
}

final itemBloc = ItemBloc();
