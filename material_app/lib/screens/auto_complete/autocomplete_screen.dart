import 'package:flutter/material.dart';
import 'package:material_app/services/analytics_service.dart';
import '../../services/countries_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';

class AutoCompleteScreen extends StatelessWidget {
  //* create a text editing controller
  final countryController = TextEditingController();

  static const routeName = '/auto-complete-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Complete Demo'),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TypeAheadField(
                  //* decorate and assign controller to TextField
                  textFieldConfiguration: TextFieldConfiguration(
                      decoration: InputDecoration(
                          hintText: "Search a Country",
                          hintStyle: TextStyle(color: Colors.black45),
                          border: InputBorder.none),
                      controller: countryController),

                  //* call getSuggestions() and pass the input
                  suggestionsCallback: (String input) {
                    return CountriesService.getSuggestions(input);
                  },

                  //* you can return any widget that you want
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion));
                  },

                  //* getting the default suggestionsBox
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  //* assigning suggestion to countryController
                  onSuggestionSelected: (String suggestion) {
                    countryController.text = suggestion;
                    AnalyticsService().logSearch(suggestion);
                  },
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.black54,
              )
            ],
          ),
        ),
        //* there's also a CupertinoTypeAheadField
      ]),
    );
  }
}
