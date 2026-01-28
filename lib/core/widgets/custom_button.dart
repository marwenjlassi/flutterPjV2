import 'package:flutter/material.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/theme/app_theme.dart';

/// Custom button widget with gradient background
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56,
      decoration: BoxDecoration(
        gradient: isOutlined ? null : AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: isOutlined
            ? Border.all(
                color: AppConstants.primaryOrange,
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacing24,
              vertical: AppConstants.spacing16,
            ),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppConstants.white,
                        ),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: isOutlined
                              ? AppConstants.primaryOrange
                              : AppConstants.white,
                          size: 20,
                        ),
                        const SizedBox(width: AppConstants.spacing8),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: isOutlined
                              ? AppConstants.primaryOrange
                              : AppConstants.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
