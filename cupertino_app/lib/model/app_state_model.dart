import 'package:flutter/cupertino.dart';

import 'animal.dart';
import 'animal_repository.dart';

// For maintaining the state of App
class AppStateModel extends ChangeNotifier {
  CupertinoThemeData _themeData;

  CupertinoThemeData getTheme() => _themeData;

  setTheme(CupertinoThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  List<Animal> animals;
  List<Animal> searchResults;
  List<Animal> filteredAnimals;

  void loadAnimals() {
    animals = AnimalsRepository.animals;
    filteredAnimals = AnimalsRepository.animals;
    searchResults = AnimalsRepository.animals;
    notifyListeners();
  }

  List<Animal> searchAnimals(String name) {
    return AnimalsRepository.search(name);
  }

  void addAnimal(String name, Category category) {
    AnimalsRepository.add(name, category);
    loadAnimals();
  }

  void filterAnimals(Category c) {
    filteredAnimals = AnimalsRepository.filterAnimals(c);
    notifyListeners();
  }
}
