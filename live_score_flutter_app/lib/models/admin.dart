import 'dart:html';

class Admin {
  String name;
  String email;
  String collegeName;

  Admin({required this.name, required this.email, required this.collegeName});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'collegeName': collegeName,
    };
  }
}
