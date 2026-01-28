import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/profile/providers/profile_provider.dart';
import 'package:exam_flutter/features/profile/models/address_model.dart';
import 'package:quickalert/quickalert.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipment Address'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          if (profile.addresses.isEmpty) {
            return const Center(child: Text('No addresses saved.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppConstants.spacing16),
            itemCount: profile.addresses.length,
            itemBuilder: (context, index) {
              final address = profile.addresses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildAddressCard(context, address),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: ElevatedButton.icon(
          onPressed: () => _showAddAddressForm(context),
          icon: const Icon(Icons.add),
          label: const Text('ADD NEW ADDRESS'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, AddressModel address) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: address.isDefault ? AppConstants.primaryOrange : Colors.grey[200]!,
          width: address.isDefault ? 2 : 1,
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
            Icons.location_on,
            color: address.isDefault ? AppConstants.primaryOrange : AppConstants.lightText,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  address.address,
                  style: const TextStyle(color: AppConstants.lightText, fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            onPressed: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                text: 'Voulez-vous vraiment supprimer cette adresse ?',
                confirmBtnText: 'Supprimer',
                cancelBtnText: 'Annuler',
                confirmBtnColor: Colors.red,
                onConfirmBtnTap: () {
                  context.read<ProfileProvider>().removeAddress(address.id);
                  Navigator.pop(context);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Adresse supprimée.',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddAddressForm(BuildContext context) {
    final titleController = TextEditingController();
    final addressController = TextEditingController();

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
              'Add New Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Label (e.g. Home, Office)',
                hintText: 'Enter address label',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Full Address',
                hintText: 'Enter your full address',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && addressController.text.isNotEmpty) {
                  final newAddress = AddressModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    address: addressController.text,
                  );
                  context.read<ProfileProvider>().addAddress(newAddress);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('SAVE ADDRESS'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
