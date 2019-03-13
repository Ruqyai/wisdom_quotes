import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisdom Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Wisdom Quotes'),
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
  int _counter = 0;
  Map<String, dynamic> data = {
    "id": 17,
    "post_id": "81784898975",
    "author": {
      "id": 16,
      "avatar_url": "",
      "name": "Steve Jobs",
      "company": "Apple",
      "twitter_username": ""
    },
    "content":
        "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do.",
    "permalink": "http://startupquote.com/post/81784898975",
    "picture_url":
        "http://41.media.tumblr.com/0915e5401eb9a4e0e01e27c525198562/tumblr_n3keo0aVDc1qz6pqio1_r1_1280.png",
    "tags": [
      {"id": 23, "label": "classic"},
      {"id": 29, "label": "work"},
      {"id": 31, "label": "life"},
      {"id": 32, "label": "enthusiasm"}
    ]
  };
  void _incrementCounter() {
    setState(() {
      _counter++;
      getData();
    });
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://wisdomapi.herokuapp.com/v1/random"),
        headers: {"Accept": "application/json"});
    data = jsonDecode(response.body);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          new SizedBox(
              width: 900.0,
              height: 500.0,
              child: Image.network('${data['picture_url']}')),
          new Padding(
            padding: new EdgeInsets.only(left: 10.0, top: 10.0, bottom: 5.0),
            child: new Container(
                decoration: new BoxDecoration(),
                child: new ListTile(
                    title: new Text('${data['author']['name']}'),
                    subtitle: new Text('${data['content']}'),
                    isThreeLine: true)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
