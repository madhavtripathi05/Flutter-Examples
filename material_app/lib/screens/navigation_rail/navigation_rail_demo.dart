import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NavigationRailDemo extends StatefulWidget {
  static const routeName = '/navigation-rail-demo';
  @override
  _NavigationRailDemoState createState() => _NavigationRailDemoState();
}

class Video {
  String title;
  String subtitle;
  String imgUrl;
  Video(this.title, this.subtitle, this.imgUrl);
}

class _NavigationRailDemoState extends State<NavigationRailDemo> {
  int _index = 0;
  TextStyle coloredTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  List<Map<String, Color>> items = [
    {'Continue Watching': Colors.blueAccent},
    {'Trending': Colors.orangeAccent},
    {'Favorites': Colors.redAccent},
    {'History': Colors.greenAccent},
  ];

  List<Video> videos = [
    Video('Video 1', 'this is a Subtitle of video 1',
        'https://picsum.photos/400/300'),
    Video('Video 2', 'this is a Subtitle of video 2',
        'https://picsum.photos/401/300'),
    Video('Video 3', 'this is a Subtitle of video 3',
        'https://picsum.photos/402/300'),
    Video('Video 4', 'this is a Subtitle of video 4',
        'https://picsum.photos/403/300'),
    Video('Video 5', 'this is a Subtitle of video 5',
        'https://picsum.photos/404/300'),
    Video('Video 6', 'this is a Subtitle of video 6',
        'https://picsum.photos/405/300'),
    Video('Video 7', 'this is a Subtitle of video 7',
        'https://picsum.photos/406/300'),
    Video('Video 8', 'this is a Subtitle of video 8',
        'https://picsum.photos/407/300'),
    Video('Video 9', 'this is a Subtitle of video 9',
        'https://picsum.photos/408/300'),
    Video('Video 10', 'this is a Subtitle of video 10',
        'https://picsum.photos/409/300'),
  ];

  Card buildVideoItem(int i) {
    return Card(
      color: Colors.white.withOpacity(0.75),
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      margin: EdgeInsets.all(8),
      child: ListTile(
        trailing: Icon(
          FlutterIcons.play_arrow_mdi,
          color: Colors.black,
        ),
        leading: CircleAvatar(backgroundImage: NetworkImage(videos[i].imgUrl)),
        title: Text(
          "${videos[i].title}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        subtitle: Text(
          "${videos[i].subtitle}",
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: items[_index].values.first,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      '${items[_index].keys.first}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  for (int i = 0; i < Random().nextInt(10); i++) ...[
                    buildVideoItem(i)
                  ]
                ],
              ),
            ),
            VerticalDivider(width: 1),
            NavigationRail(
              backgroundColor: Colors.white.withOpacity(0.75),
              selectedIndex: _index,
              groupAlignment: 0.0,
              onDestinationSelected: (int index) {
                setState(() => _index = index);
              },
              labelType: NavigationRailLabelType.selected,
              leading: Icon(
                FlutterIcons.user_ant,
                color: Colors.purple,
              ),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(
                    Icons.play_circle_outline,
                    color: Colors.blue,
                  ),
                  selectedIcon: Icon(
                    Icons.play_circle_filled,
                    color: Colors.blueAccent,
                  ),
                  label: Text(
                    'Continue\nwatching',
                    style: coloredTextStyle(Colors.blueAccent),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    FlutterIcons.fire_sli,
                    color: Colors.orange,
                  ),
                  selectedIcon: Icon(
                    FlutterIcons.fire_faw5s,
                    color: Colors.orangeAccent,
                  ),
                  label: Text(
                    'Trending',
                    style: coloredTextStyle(Colors.orangeAccent),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  selectedIcon: Icon(Icons.favorite, color: Colors.redAccent),
                  label: Text(
                    'Favorites',
                    style: coloredTextStyle(Colors.redAccent),
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    Icons.history,
                    color: Colors.green,
                  ),
                  selectedIcon: Icon(FlutterIcons.history_faw5s,
                      color: Colors.greenAccent),
                  label: Text(
                    'History',
                    style: coloredTextStyle(Colors.greenAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
