import 'package:flutter/material.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacing24),
        children: [
          const Text(
            'Comment pouvons-nous vous aider ?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildSupportItem(
            icon: Icons.question_answer_outlined,
            title: 'FAQ',
            subtitle: 'Questions fréquemment posées',
          ),
          _buildSupportItem(
            icon: Icons.chat_outlined,
            title: 'Chat en direct',
            subtitle: 'Parlez à un conseiller maintenant',
          ),
          _buildSupportItem(
            icon: Icons.email_outlined,
            title: 'Email',
            subtitle: 'support@foodieapp.com',
          ),
          _buildSupportItem(
            icon: Icons.phone_outlined,
            title: 'Téléphone',
            subtitle: '+33 1 23 45 67 89',
          ),
          const SizedBox(height: 40),
          const Text(
            'FAQ Populaires',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildFaqItem('Comment suivre ma commande ?'),
          _buildFaqItem('Quels sont les délais de livraison ?'),
          _buildFaqItem('Comment annuler une commande ?'),
          _buildFaqItem('Puis-je modifier mon adresse après commande ?'),
        ],
      ),
    );
  }

  Widget _buildSupportItem({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: AppConstants.primaryOrange),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildFaqItem(String question) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontSize: 14)),
      children: const [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Vous pouvez trouver ces informations dans la section "Mes Commandes" ou en contactant notre support client.',
            style: TextStyle(color: AppConstants.lightText),
          ),
        ),
      ],
    );
  }
}
