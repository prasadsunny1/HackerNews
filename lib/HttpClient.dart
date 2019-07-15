import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getOrCache(String url) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey(url)) {
    var cache = prefs.getString(url);
    return cache;
  } else {
    http.Response resp = await http.get(url);
    if (resp.statusCode == 200) {
      prefs.setString(url, resp.body);
      return resp.body;
    } 
  }
}
