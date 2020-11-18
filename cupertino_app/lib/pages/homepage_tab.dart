import 'package:cupertino_app/model/animal.dart';
import 'package:cupertino_app/model/app_state_model.dart';
import 'package:cupertino_app/widgets/custom_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageTab extends StatefulWidget {
  @override
  _HomePageTabState createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("All"),
    1: Text("Herbivores"),
    2: Text("Carnivores")
  };
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Animals'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
              child: CupertinoSlidingSegmentedControl(
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i;
                      switch (i) {
                        case 0:
                          model.filteredAnimals = model.animals;
                          break;
                        case 1:
                          model.filterAnimals(Category.herbivores);
                          break;
                        case 2:
                          model.filterAnimals(Category.carnivores);
                          break;
                      }
                    });
                  }),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index < model.filteredAnimals.length)
                  return CustomTile(model.filteredAnimals[index]);

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CupertinoButton.filled(
                    child: Text('+ Add'),
                    onPressed: () {
                      var controller = TextEditingController();
                      bool carnivores = false;
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoAlertDialog(
                                title: Text("Add an Animal"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name'),
                                    SizedBox(height: 10),
                                    CupertinoTextField(controller: controller),
                                    SizedBox(height: 20),
                                    Text('Category'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Herbivores'),
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return CupertinoSwitch(
                                              value: carnivores,
                                              activeColor: Colors.red,
                                              trackColor: Colors.green,
                                              onChanged: (val) {
                                                setState(() {
                                                  carnivores = val;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                        Text('Carnivores'),
                                      ],
                                    )
                                  ],
                                ),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    textStyle: TextStyle(color: Colors.red),
                                    isDefaultAction: true,
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: Text("Add"),
                                    onPressed: () {
                                      model.addAnimal(
                                          controller.text ?? 'Animal',
                                          carnivores
                                              ? Category.carnivores
                                              : Category.herbivores);
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ));
                    },
                  ),
                );
              }, childCount: model.filteredAnimals.length + 1),
            ),
          ),
        ],
      );
    });
  }
}
