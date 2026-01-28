import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';

/// Welcome screen - first screen shown when app opens
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppConstants.primaryOrange,
              AppConstants.accentRed,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing24,
                vertical: AppConstants.spacing40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hero image with animation
                  FadeInDown(
                    duration: const Duration(milliseconds: 1200),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                        child: Image.asset(
                          'assets/images/food_delivery.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing40),
                  
                  // App title with animation
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      'Food Delivery',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing12),
                  
                  // Subtitle with animation
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      'Delicious meals delivered\nright to your door',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.95),
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing40),
                  
                  // Features list with staggered animation
                  FadeInLeft(
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 800),
                    child: _buildFeature(Icons.delivery_dining, 'Fast & Reliable Delivery'),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing16),
                  
                  FadeInLeft(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 800),
                    child: _buildFeature(Icons.restaurant_menu, 'Wide Variety of Cuisines'),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing16),
                  
                  FadeInLeft(
                    delay: const Duration(milliseconds: 1200),
                    duration: const Duration(milliseconds: 800),
                    child: _buildFeature(Icons.verified, 'Top Quality Guaranteed'),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing48),
                  
                  // Get Started button with bounce animation
                  BounceInUp(
                    delay: const Duration(milliseconds: 1400),
                    duration: const Duration(milliseconds: 1000),
                    child: CustomButton(
                      text: 'Get Started',
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signin');
                      },
                      icon: Icons.arrow_forward,
                      width: double.infinity,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing16),
                  
                  // Skip to sign up link
                  FadeIn(
                    delay: const Duration(milliseconds: 1600),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      child: Text(
                        'or create a new account',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppConstants.spacing12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: AppConstants.spacing16),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
