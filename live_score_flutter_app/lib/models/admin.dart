class Admin {
  String name;
  String email;
  String collegeName;

  Admin({required this.name, required this.email, required this.collegeName});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'collegeName': collegeName,
    };
  }

  static Admin fromJson(Map<String, dynamic> jsonData) {
    return Admin(
        name: jsonData['name'],
        email: jsonData['email'],
        collegeName: jsonData['collegeName']);
  }
}
