import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/profile/providers/profile_provider.dart';
import 'package:exam_flutter/features/profile/models/payment_method_model.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          if (profile.paymentMethods.isEmpty) {
            return const Center(child: Text('No payment methods saved.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.spacing16),
            itemCount: profile.paymentMethods.length,
            itemBuilder: (context, index) {
              final method = profile.paymentMethods[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPaymentCard(context, method),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: ElevatedButton.icon(
          onPressed: () => _showAddCardForm(context),
          icon: const Icon(Icons.add_card),
          label: const Text('ADD NEW CARD'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, PaymentMethodModel method) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: method.isSelected ? AppConstants.primaryOrange : Colors.grey[200]!,
          width: method.isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.credit_card,
            color: method.isSelected ? AppConstants.primaryOrange : AppConstants.lightText,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.type,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  method.number,
                  style: const TextStyle(color: AppConstants.lightText, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            method.expiry,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showAddCardForm(BuildContext context) {
    final typeController = TextEditingController();
    final numberController = TextEditingController();
    final expiryController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Card',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Card Type (e.g. Visa, MasterCard)',
                hintText: 'Enter card type',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: '**** **** **** ****',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryController,
              decoration: const InputDecoration(
                labelText: 'Expiry Date',
                hintText: 'MM/YY',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (typeController.text.isNotEmpty && numberController.text.isNotEmpty) {
                  final newMethod = PaymentMethodModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    type: typeController.text,
                    number: numberController.text,
                    expiry: expiryController.text,
                  );
                  context.read<ProfileProvider>().addPaymentMethod(newMethod);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('SAVE CARD'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
