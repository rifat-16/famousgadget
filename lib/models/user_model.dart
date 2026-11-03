class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String country;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.city = 'Dhaka',
    this.country = 'BD',
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    }
    return 'U';
  }
}
