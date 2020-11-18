class Animal {
  final String name;
  final Category category;
  final String imgUrl;

  const Animal(this.name, this.category, this.imgUrl);
}

enum Category { herbivores, carnivores }
