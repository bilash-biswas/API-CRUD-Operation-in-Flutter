class UserModel {
  final String id;
  final String name;
  final String email;
  final String create_at;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.create_at
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"].toString(),
        name: json["name"],
        email: json["email"],
        create_at: json["create_at"].toString()
    );
  }
}