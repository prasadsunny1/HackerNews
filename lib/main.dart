import 'package:flutter/material.dart';
import 'package:hackernews_sunny/HnService.dart';
import 'package:hackernews_sunny/models/NewsItem.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HnListWidget(),
    );
  }
}

class HnListWidget extends StatefulWidget {
  @override
  _HnListWidgetState createState() => _HnListWidgetState();
}

class _HnListWidgetState extends State<HnListWidget> {
  HnService hnService = new HnService();

  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hnService.getTopStoriesList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is List<int>) {
            List<int> list = snapshot.data as List<int>;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int position) {
                return FutureBuilder(
                  future: hnService.fetchItem(list[position]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var item = snapshot.data as NewsItem;
                      return ListTile(
                        title: Text(item.title),
                        onTap: _launchUrl(item.url),
                      );
                    } else {
                      return ListTile(
                        title: Text("Loading.."),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text("No Data"),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
