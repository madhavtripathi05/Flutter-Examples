import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamDemo extends StatefulWidget {
  static const routeName = '/stream-demo';
  @override
  _StreamDemoState createState() => _StreamDemoState();
}

// to Control our Stream
StreamController streamController = StreamController<int>();
// this is our stream
Stream stream = streamController.stream;

class _StreamDemoState extends State<StreamDemo> {
  @override
  void initState() {
    streamController.add(0);
    super.initState();
  }

  // Subscribing to Stream and listening
  StreamSubscription streamSubscription1 =
      streamController.stream.listen((event) {
    print(event);
  });

  @override
  void dispose() {
    // never forget to cancel the Stream Subscription
    flow = false;
    streamSubscription1.cancel();
    streamController.close();
    super.dispose();
  }

  // this will control our stream
  bool flow = false;

  // Future returns all the data at once where Stream gives(yields) continuous flow of data
  // notice the * after async, this is what separates Future from Stream
  Stream<int> getRandomIntegers() async* {
    while (flow) {
      await Future.delayed(Duration(seconds: 1));
      yield Random().nextInt(100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Streams Demo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: getRandomIntegers(),
                builder: (context, snapshot) {
                  return Column(
                    children: <Widget>[
                      Text(
                        !snapshot.hasData
                            ? 'Start Listening to Stream'
                            : 'Data: ${snapshot.data}',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        '${snapshot.connectionState}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                }),
            FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                setState(() => flow = true);
              },
              child: Text('Start Stream'),
            ),
            FlatButton(
              textColor: Colors.white,
              color: Colors.orangeAccent,
              onPressed: () {
                setState(() => flow = false);
              },
              child: Text('Stop Stream'),
            ),
            // FlatButton(
            //   textColor: Colors.white,
            //   color: Colors.red,
            //   onPressed: () {
            //     streamController.close();
            //   },
            //   child: Text('Close Stream'),
            // ),
          ],
        ),
      ),
    );
  }
}
