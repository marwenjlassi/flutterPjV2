import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/food/models/promotion_model.dart';

class PromotionCard extends StatelessWidget {
  final PromotionModel promotion;

  const PromotionCard({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/promotion-detail',
            arguments: promotion,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryOrange.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Background Image with Gradient Overlay
              Positioned.fill(
                child: Hero(
                  tag: 'promotion_${promotion.id}',
                  child: Image.asset(
                    promotion.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withValues(alpha: 0.8),
                        Colors.black.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Text Content
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacing24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ZoomIn(
                      delay: const Duration(milliseconds: 400),
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
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FadeInLeft(
                      delay: const Duration(milliseconds: 600),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          promotion.subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    if (promotion.discountCode != null) ...[
                      const SizedBox(height: 16),
                      FadeInUp(
                        delay: const Duration(milliseconds: 800),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Use Code: ${promotion.discountCode}',
                            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
