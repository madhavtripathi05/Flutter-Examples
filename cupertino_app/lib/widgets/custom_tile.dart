import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/animal.dart';

class CustomTile extends StatelessWidget {
  final Animal a;
  CustomTile(this.a);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Color(0xccfafafa),
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              a.imgUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Text(a.name),
              Text(a.category.toString().substring(9).toUpperCase()),
            ],
          ),
          CircleAvatar(
            backgroundColor:
                a.category == Category.herbivores ? Colors.green : Colors.red,
            radius: 7,
          )
        ]),
      ),
    );
  }
}
