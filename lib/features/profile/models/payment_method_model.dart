class PaymentMethodModel {
  final String id;
  final String type; // Visa, MasterCard, etc.
  final String number;
  final String expiry;
  final bool isSelected;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.number,
    required this.expiry,
    this.isSelected = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'number': number,
        'expiry': expiry,
        'isSelected': isSelected,
      };

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) => PaymentMethodModel(
        id: json['id'],
        type: json['type'],
        number: json['number'],
        expiry: json['expiry'],
        isSelected: json['isSelected'] ?? false,
      );
}
