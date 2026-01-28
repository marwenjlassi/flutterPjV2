import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppConstants.primaryOrange,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: AppConstants.spacing24),
            Text(
              user?.name ?? 'User',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? '',
              style: const TextStyle(color: AppConstants.lightText),
            ),
            const SizedBox(height: AppConstants.spacing40),
            _buildProfileItem(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () => Navigator.pushNamed(context, '/edit-profile'),
            ),
            _buildProfileItem(
              icon: Icons.location_on_outlined,
              title: 'Shipment Address',
              onTap: () => Navigator.pushNamed(context, '/address'),
            ),
            _buildProfileItem(
              icon: Icons.payment_outlined,
              title: 'Payment Methods',
              onTap: () => Navigator.pushNamed(context, '/payment-methods'),
            ),
            _buildProfileItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () => Navigator.pushNamed(context, '/help-support'),
            ),
            const SizedBox(height: AppConstants.spacing40),
            CustomButton(
              text: 'Logout',
              onPressed: () {
                authProvider.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              isOutlined: true,
              icon: Icons.logout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryOrange),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
