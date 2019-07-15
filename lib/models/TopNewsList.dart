// To parse this JSON data, do
//
//     final topNewsList = topNewsListFromJson(jsonString);

import 'dart:convert';

List<int> topNewsListFromJson(String str) => new List<int>.from(json.decode(str).map((x) => x));

String topNewsListToJson(List<int> data) => json.encode(new List<dynamic>.from(data.map((x) => x)));
