import 'package:flutter/material.dart';
import '../data/data.dart';

class GridViewBuilderDemo extends StatefulWidget {
  static const routeName = '/grid-view';
  @override
  _GridViewBuilderDemoState createState() => _GridViewBuilderDemoState();
}

class _GridViewBuilderDemoState extends State<GridViewBuilderDemo> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridViewBuilderDemo'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Text('$count'),
            onPressed: () => setState(() => count = (count % 4) + 1),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: count),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return GridTile(
              child: Container(
                  padding: EdgeInsets.all(8),
                  child: Image.network(dataList[index].imgUrl)),
              header: Container(
                color: Colors.white,
                child: Text(
                  dataList[index].name,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
    );
  }
}
