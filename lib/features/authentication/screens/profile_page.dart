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
            _buildProfileItem(Icons.person_outline, 'Edit Profile'),
            _buildProfileItem(Icons.location_on_outlined, 'Shipping Address'),
            _buildProfileItem(Icons.payment_outlined, 'Payment Methods'),
            _buildProfileItem(Icons.help_outline, 'Help & Support'),
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

  Widget _buildProfileItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryOrange),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
