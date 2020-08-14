import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import 'repository.dart';

final baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response =  await client.get('$baseUrl/topstories.json?print=pretty');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }


  Future<Item> fetchItem(int id) async {
    final response = await client.get('$baseUrl/item/$id.json?print=pretty');
    final parsedJson = json.decode(response.body);

    return Item.fromJson(parsedJson);
  }
}

final newsApiProvider = NewsApiProvider();