// Why Asynchronous Programming?
// An Asynchronous operation allows other operations to execute before it completes.
/*
* Examples: Waiting for a page to load,
* getting data from an API endpoint,
* updating entries to a Database
*/
// Future, async, await Keywords
/*
 * Future: Object which is Expected to be resolved in 'FUTURE'.
 * if it completes with success control goes to .then() 
 * and perform different operations,
 * else .catchError() where you can handle the errors.
 */

import 'package:flutter/material.dart';

class AsyncAwait extends StatefulWidget {
  static const routeName = '/async-await';
  @override
  _AsyncAwaitState createState() => _AsyncAwaitState();
}

class _AsyncAwaitState extends State<AsyncAwait> {
  bool _isLoading1 = false;
  bool _isLoading2 = false;
  bool _isCompleted = false;
  String date = 'tap on get Date';
  String past = 'tap on change past';

  Future<String> getDateTime() async {
    //Suppose there's a function which takes a while to complete
    String dateTime = await Future<String>.delayed(
        Duration(seconds: 2), () => DateTime.now().toString());
    return dateTime;
    // returns YYYY-MM-DD HH:MM:SS.milliseconds
  }

// This Function doesn't return a value so it's void
  Future<void> getDate() async {
    // lets extract first 10 characters using Substring Method.
    // .then will assign value after 1 second
    setState(() => _isLoading1 = true);
    String date = await getDateTime().then((val) => val.substring(0, 10));
    print(date);
    setState(() => this.date = date);
    setState(() => _isLoading1 = false);
  }

  Future<String> changePast() async {
// let's throw an error from this function
    try {
      await Future.delayed(
          Duration(seconds: 2),
          () =>
              throw "You can't change the Past\nbecause it's already a Future :)");
    } catch (e) {
      //will return the exception
      return e;
    }
    // this will never be executed
    return 'you changed the past';
  }

  Future<void> life() async {
    setState(() => _isLoading2 = true);
    String past;
// .catchError is invoked when an error occurs
    past = await changePast().then((val) => val).catchError((err) => err);

    print(past);
    setState(() => this.past = past);
    setState(() => _isLoading2 = false);
    setState(() => _isCompleted = true);
  }

/* 
*  NOTE: if you won't specify main as async,
*  or wait for methods to complete, last line (Non-Futures)
*  will be executed first and then both functions will be executed.
*  if you want to run pure in Dart
*  void main() async {
*    // get current date
*    await getDate();
*    // Pun intended
*    await life();
*
*    print('Waiting for all the functions to complete!');
* }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A  sync/Await/Future'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('get Date'),
              onPressed: getDate,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            _isLoading1
                ? CircularProgressIndicator()
                : Text(
                    date,
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
            SizedBox(height: 10),
            FlatButton(
              child: Text('change Past'),
              onPressed: life,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            _isLoading2
                ? CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  )
                : Text(
                    past,
                    style: TextStyle(fontSize: 15, color: Colors.orangeAccent),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 10),
            _isCompleted
                ? Text('All Functions executed!',
                    style: TextStyle(color: Colors.green))
                : Text('Waiting to complete all Functions!',
                    style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
