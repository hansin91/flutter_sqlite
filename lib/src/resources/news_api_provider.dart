import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final baseUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response =  await client.get('$baseUrl/topstories.json?print=pretty');
    final ids = json.decode(response.body);
    return ids;
  }


  fetchItem(int id) async {
    final response = await client.get('$baseUrl/item/$id.json?print=pretty');
    final parsedJson = json.decode(response.body);

    return Item.fromJson(parsedJson);
  }
}