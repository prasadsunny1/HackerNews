import 'package:hackernews_sunny/models/NewsItem.dart';
import 'package:hackernews_sunny/models/TopNewsList.dart';
import 'HttpClient.dart' as client;
import 'dart:async';
import 'UrlStore.dart';
import 'dart:convert';

class HnService {
  Future<List<int>> getTopStoriesList() async {
    var resp = await client.getOrCache(UrlTopNews);
    if (resp != null) {
      List<int> listOfNewscode = topNewsListFromJson(resp);
      return listOfNewscode;
    }
    return null;
  }

  Future<NewsItem> fetchItem(int itemCode) async {
    var url = UrlNewsDetail + itemCode.toString() + ".json";
    var resp = await client.getOrCache(url);
    if (resp != null) {
      NewsItem listOfNewscode = NewsItem.fromJson(json.decode(resp));
      return listOfNewscode;
    }
    return null;
  }
}
