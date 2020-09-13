class Student {
  String name;
  String id;
  int age;
  String email;
  String phoneNo;

  Student({
    this.name,
    this.id,
    this.email,
    this.age,
    this.phoneNo,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json["name"],
      id: json["id"],
      email: json["email"],
      age: json["age"],
      phoneNo: json["phoneNo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
        "age": age,
        "phoneNo": phoneNo,
      };
}
