import 'package:equatable/equatable.dart';

class PromotionModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? discountCode;
  final String? restaurantId;

  const PromotionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.discountCode,
    this.restaurantId,
  });

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, discountCode, restaurantId];

  static List<PromotionModel> get samplePromotions => [
    const PromotionModel(
      id: '1',
      title: '50% OFF',
      subtitle: 'On all Italian Pizzas today!',
      imageUrl: 'assets/images/italian.png',
      discountCode: 'PIZZA50',
    ),
    const PromotionModel(
      id: '2',
      title: 'FREE DELIVERY',
      subtitle: 'Order your favorite Sushi now.',
      imageUrl: 'assets/images/japanese.png',
    ),
    const PromotionModel(
      id: '3',
      title: 'NEW ARRIVAL',
      subtitle: 'Try our gourmet French desserts.',
      imageUrl: 'assets/images/french.png',
      discountCode: 'SWEET10',
    ),
    const PromotionModel(
      id: '4',
      title: 'SPICY DEAL',
      subtitle: 'Authentic Indian flavors at your door.',
      imageUrl: 'assets/images/indian.png',
    ),
  ];
}
