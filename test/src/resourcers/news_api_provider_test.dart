import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([3,4,51,23,20]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [3,4,51,23,20]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
