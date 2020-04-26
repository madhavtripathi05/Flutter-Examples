import 'package:flutter/material.dart';

class ConfirmationAcknowledgement extends StatefulWidget {
  static const routeName = '/confirm-acknowledgement';
  @override
  _ConfirmationAcknowledgementState createState() =>
      _ConfirmationAcknowledgementState();
}

class _ConfirmationAcknowledgementState
    extends State<ConfirmationAcknowledgement> {

  _buildSnackbar(String content) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      action: SnackBarAction(
          label: 'close',
          textColor: Colors.redAccent,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          }),
      content: Text(content),
      duration: Duration(seconds: 5),
    ));
  }

  _buildBottomSheet(String content) {
    _scaffoldKey.currentState.showBottomSheet(
      (content) => Container(
        height: 200,
        padding: EdgeInsets.all(20),
        color: Colors.grey[900],
        child: Column(
          children: <Widget>[
            Text(
              'This is a Bottom Sheet',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                    textColor: Colors.blue,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Ok')),
                FlatButton(
                    textColor: Colors.red,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel')),
              ],
            ),
            SizedBox(height: 20),
            Text('you can also provide additional info here',
                style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  _buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('You want to perform this action?'),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text('Yes')),
          FlatButton(
              textColor: Colors.red,
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel')),
        ],
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Confirmation &\nAcknowledgement',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => _buildSnackbar('This is a Snackbar'),
                child: Text('SnackBar')),
            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => _buildDialog(context),
                child: Text('Alert Dialog')),
            FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () => _buildBottomSheet('This is a Bottom Sheet'),
                child: Text('Bottom Sheet')),
          ],
        ),
      ),
    );
  }
}
