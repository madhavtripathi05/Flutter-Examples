import 'package:flutter/material.dart';
import '../../data/data.dart';

class ListViewBuilderDemo extends StatefulWidget {
  static const routeName = '/list-view';
  @override
  _ListViewBuilderDemoState createState() => _ListViewBuilderDemoState();
}

class _ListViewBuilderDemoState extends State<ListViewBuilderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListViewBuilderDemo'), centerTitle: true),
      body: ListView.builder(
          /* as we won't be sure about how much data is available at 
        the other end, we will simply assign length of List. */
          itemCount: dataList.length,
          /* item builder takes context and index as argument and expects 
          a widget, you can make your own Widget or use ListTile */
          itemBuilder: (context, index) {
            return ListTile(
              // iterating over dataList
              leading: Container(child: Image.network(dataList[index].imgUrl)),
              title: Text('${index + 1}. ' + dataList[index].name),
              subtitle: Text(dataList[index].surname),
            );
          }),
    );
  }
}
