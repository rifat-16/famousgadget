class AddressModel {
  final String id;
  final String name;
  final String label; // Home, Office
  final String phone;
  final String street;
  final String city;
  final String district;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.name,
    this.label = 'Home',
    required this.phone,
    required this.street,
    required this.city,
    required this.district,
    this.isDefault = false,
  });

  String get fullAddress => '$street, $district, $city';
}
