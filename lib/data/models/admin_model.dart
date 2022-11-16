import '../../domain/entities/admin_entity.dart';

class AdminModel extends AdminEntity {
  final String name;
  final String email;

  const AdminModel({required this.name, required this.email})
      : super(name: name, email: email);

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
    };

    return data;
  }
}
