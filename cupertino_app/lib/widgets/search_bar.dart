import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      child: Row(
        children: [
          const Icon(CupertinoIcons.search),
          SizedBox(width: 8),
          Expanded(child: CupertinoTextField(controller: controller)),
          SizedBox(width: 8),
          GestureDetector(
            onTap: controller.clear,
            child: const Icon(CupertinoIcons.clear_thick_circled),
          ),
        ],
      ),
    );
  }
}
