import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/models/promotion_model.dart';

class PromotionDetailPage extends StatelessWidget {
  final PromotionModel promotion;

  const PromotionDetailPage({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'promotion_${promotion.id}',
                child: Image.asset(
                  promotion.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryOrange,
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      ),
                      child: Text(
                        promotion.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      promotion.subtitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: const Text(
                      'Profitez de cette offre exceptionnelle dès maintenant ! Cette promotion est valable pour une durée limitée sur une sélection de restaurants partenaires.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.lightText,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (promotion.discountCode != null)
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: Container(
                        padding: const EdgeInsets.all(AppConstants.spacing20),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                          border: Border.all(color: AppConstants.primaryOrange, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Code Promo',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppConstants.primaryOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  promotion.discountCode!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Code copié !')),
                                );
                              },
                              child: const Text('COPIER'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  FadeInUp(
                    delay: const Duration(milliseconds: 800),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: const Text('VOIR LES RESTAURANTS'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
