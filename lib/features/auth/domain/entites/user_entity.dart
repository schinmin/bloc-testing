class User {
  final int id;

  final String name;
  final String company;
  final String address;

  final String email;
  final String? token;

  User({
    required this.id,
    required this.company,
    required this.address,
    required this.name,
    required this.email,
    this.token,
  });
}
