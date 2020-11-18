import 'animal.dart';

class AnimalsRepository {
  static List<Animal> animals = [
    Animal('Lion', Category.carnivores,
        'https://upload.wikimedia.org/wikipedia/commons/7/73/Lion_waiting_in_Namibia.jpg'),
    Animal('Elephant', Category.herbivores,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg'),
    Animal('Deer', Category.herbivores,
        'https://upload.wikimedia.org/wikipedia/commons/b/b7/White-tailed_deer.jpg'),
    Animal('Horse', Category.herbivores,
        'https://upload.wikimedia.org/wikipedia/commons/d/de/Nokota_Horses_cropped.jpg'),
    Animal('Tiger', Category.carnivores,
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Bengal_tiger_%28Panthera_tigris_tigris%29_female_3_crop.jpg/1200px-Bengal_tiger_%28Panthera_tigris_tigris%29_female_3_crop.jpg'),
    Animal('Wolf', Category.carnivores,
        'https://cdn.britannica.com/07/5207-050-5BC9F251/Gray-wolf.jpg'),
  ];

  static List<Animal> filterAnimals(Category category) {
    return animals.where((a) => a.category == category).toList();
  }

  static List<Animal> search(String name) {
    return animals
            .where((a) => a.name.toLowerCase().contains(name.toLowerCase()))
            .toList() ??
        [];
  }

  static add(String name, Category category, {String imgUrl}) {
    animals.add(Animal(
      name,
      category,
      imgUrl ??
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1200px-No_image_3x4.svg.png',
    ));
  }
}
