import 'package:flutter/material.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';

/// Header widget for authentication screens
class AuthHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;

  const AuthHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon = Icons.fastfood_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Food delivery icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppConstants.primaryOrange.withOpacity(0.2),
                AppConstants.accentRed.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            icon,
            size: 50,
            color: AppConstants.primaryOrange,
          ),
        ),
        
        const SizedBox(height: AppConstants.spacing24),
        
        // Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppConstants.darkText,
          ),
          textAlign: TextAlign.center,
        ),
        
        if (subtitle != null) ...[
          const SizedBox(height: AppConstants.spacing8),
          
          // Subtitle
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 14,
              color: AppConstants.lightText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
