class AddressModel {
  final String id;
  final String title;
  final String address;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.address,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'address': address,
        'isDefault': isDefault,
      };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'],
        title: json['title'],
        address: json['address'],
        isDefault: json['isDefault'] ?? false,
      );
}
