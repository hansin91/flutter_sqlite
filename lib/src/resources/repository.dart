import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source> [
    newsDbProvider,
    newsApiProvider
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<Item> fetchItem(int id) async {
    Item item;
    Source source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      cache.addItem(item);
    }
    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<Item> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(Item item);
}
