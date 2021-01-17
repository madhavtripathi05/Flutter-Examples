import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_public_api/insta_public_api.dart';
import 'package:insta_public_api/models/basic_model.dart';

class InstaDetails extends StatefulWidget {
  static const routeName = '/insta-details';
  @override
  _InstaDetailsState createState() => _InstaDetailsState();
}

class _InstaDetailsState extends State<InstaDetails> {
  String username = 'flutter_coders';

  /// Helper function
  Widget makeText(String text) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget build(BuildContext context) {
    /// Initialize with your username
    final ipa = InstaPublicApi(username, postsLimit: 150);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Example App'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Get.defaultDialog(
                    title: 'Enter a public username',
                    content: Column(
                      children: [
                        TextField(onChanged: (val) => username = val),
                        SizedBox(height: 20),
                        RaisedButton(
                            child: Text('Search'),
                            onPressed: () {
                              setState(() {});
                              Get.back();
                            })
                      ],
                    ));
              })
        ],
      ),
      body: FutureBuilder(
        /// Get All posts details
        future: ipa.getAllPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          /// Wait Until data loads
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          /// List of Post
          List<Post> posts = snapshot.data;
          return ListView(children: [
            SizedBox(height: 20),
            FutureBuilder(
              future: ipa.getBasicInfo(),
              builder:
                  (BuildContext context, AsyncSnapshot<BasicInfo> snapshot) {
                final info = snapshot.data;
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                return Column(
                  children: [
                    makeText('${info.fullName}'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(info.profilePic, height: 100)),
                        makeText('Posts\n${info.noOfPosts}'),
                        makeText('Followers\n${info.followers}'),
                        makeText('Following\n${info.following}'),
                      ],
                    ),
                  ],
                );
              },
            ),
            ...posts
                .map(
                  (p) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 450,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: p.hasNestedImages
                              ? ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                      ...p.images
                                          .map(
                                            (i) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: ClipRRect(
                                                child: Image.network(
                                                  i.displayUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: p.images.first ==
                                                        i
                                                    ? BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10))
                                                    : p.images.last == i
                                                        ? BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))
                                                        : BorderRadius.all(
                                                            Radius.zero),
                                              ),
                                            ),
                                          )
                                          .toList()
                                    ])
                              : ClipRRect(
                                  child: Image.network(p.displayUrl,
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_border_rounded,
                              color: Colors.red),
                          Text(' ${p.likes}'),
                          SizedBox(width: 10),
                          Icon(Icons.comment, color: Colors.blue),
                          Text(' ${p.comments}'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('${p.caption}')
                    ],
                  ),
                )
                .toList()
          ]);
        },
      ),
    );
  }
}
