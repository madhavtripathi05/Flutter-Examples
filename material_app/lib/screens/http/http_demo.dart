import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpDemo extends StatefulWidget {
  static const routeName = '/http-demo';
  @override
  _HttpDemoState createState() => _HttpDemoState();
}

const url = "https://jsonplaceholder.typicode.com";

class Post {
  // initial data
  int userId = 0;
  int id = 0;
  String title = "title";
  String body = "body";

  Post({this.body, this.id, this.title, this.userId});
  // converting Map and assigning to variables
  fromMap(data) {
    title = data["title"] ?? 'deleted';
    id = data["id"] ?? 0;
    userId = data["userId"] ?? 0;
    body = data["body"] ?? 'deleted';
  }

  // converting data to Map
  Map<String, Object> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}

class _HttpDemoState extends State<HttpDemo> {
  Post post = Post();
  bool _isLoading = false;
  int statusCode = 0;
  Map<String, Object> data = {};

  Future<void> getData() async {
    setState(() => _isLoading = true);
    http.Response response = await http.get('$url/posts/1');
    setState(() {
      statusCode = response.statusCode;
      data = jsonDecode(response.body);
      post.fromMap(data);
      _isLoading = false;
    });
  }

  Future<void> postData() async {
    setState(() => _isLoading = true);
    http.Response response = await http.post('$url/posts',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: jsonEncode(
            Post(body: 'this is new Description', title: 'New Title').toMap()));
    setState(() {
      statusCode = response.statusCode;
      data = jsonDecode(response.body);
      post.fromMap(data);
      _isLoading = false;
    });
  }

  Future<void> deleteData() async {
    setState(() => _isLoading = true);
    http.Response response = await http.delete('$url/posts/1');
    setState(() {
      statusCode = response.statusCode;
      data = jsonDecode(response.body);
      post.fromMap(data);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'URL : $url',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: 10),
            FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async => await getData(),
                child: Text('GET')),
            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () async => await postData(),
                child: Text('POST')),
            FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async => await deleteData(),
                child: Text('DELETE')),
            _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Status Code : $statusCode',
                          style: TextStyle(
                              color: statusCode >= 500
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Title : ${post.title}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description : ${post.body}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
