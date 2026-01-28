import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';

/// Home screen - placeholder after successful authentication
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    
    await authProvider.signOut();
    
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            final user = authProvider.currentUser;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spacing24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppConstants.spacing40),
                  
                  // Welcome header
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.spacing24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppConstants.primaryOrange,
                            AppConstants.accentRed,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: AppConstants.primaryOrange.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome! 👋',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.white,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacing8),
                          Text(
                            user?.name ?? 'User',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppConstants.white,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacing4),
                          Text(
                            user?.email ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing32),
                  
                  // User info card
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacing20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppConstants.spacing12),
                                  decoration: BoxDecoration(
                                    color: AppConstants.primaryOrange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppConstants.primaryOrange,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: AppConstants.spacing16),
                                const Text(
                                  'Account Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppConstants.spacing20),
                            _buildInfoRow(Icons.phone, 'Phone', user?.phone ?? 'Not provided'),
                            const SizedBox(height: AppConstants.spacing12),
                            _buildInfoRow(Icons.calendar_today, 'Member since', 
                              user != null 
                                ? '${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}'
                                : 'N/A'
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing24),
                  
                  // Food delivery placeholder
                  FadeInRight(
                    delay: const Duration(milliseconds: 300),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.spacing24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.restaurant_menu_rounded,
                              size: 80,
                              color: AppConstants.primaryOrange.withOpacity(0.5),
                            ),
                            const SizedBox(height: AppConstants.spacing16),
                            const Text(
                              'Delivery Features',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacing8),
                            Text(
                              'Order and delivery features will be added here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppConstants.lightText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing32),
                  
                  // Logout button
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: CustomButton(
                      text: 'Sign Out',
                      onPressed: () => _handleLogout(context),
                      isOutlined: true,
                      icon: Icons.logout,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppConstants.lightText,
        ),
        const SizedBox(width: AppConstants.spacing12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: AppConstants.lightText,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppConstants.darkText,
            ),
          ),
        ),
      ],
    );
  }
}
