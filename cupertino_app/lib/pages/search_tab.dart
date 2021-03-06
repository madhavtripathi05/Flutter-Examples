import 'package:cupertino_app/model/app_state_model.dart';

import 'package:cupertino_app/widgets/custom_tile.dart';
import 'package:cupertino_app/widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController _controller;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _searchTerm = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(controller: _controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final results = model.searchAnimals(_searchTerm);
    return SafeArea(
      child: Column(
        children: [
          _buildSearchBox(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => CustomTile(results[index]),
              itemCount: results.length,
            ),
          ),
        ],
      ),
    );
  }
}
