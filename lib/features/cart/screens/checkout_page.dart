import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/cart/providers/cart_provider.dart';
import 'package:exam_flutter/features/orders/providers/order_provider.dart';
import 'package:exam_flutter/features/notifications/providers/notification_provider.dart';
import 'package:exam_flutter/features/notifications/models/notification_model.dart';
import 'package:exam_flutter/features/orders/models/order_model.dart';
import 'package:exam_flutter/features/profile/providers/profile_provider.dart';
import 'package:exam_flutter/features/profile/models/address_model.dart';
import 'package:exam_flutter/features/profile/models/payment_method_model.dart';
import 'package:quickalert/quickalert.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedAddressId;
  String? _selectedPaymentId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profile = context.read<ProfileProvider>();
      if (profile.addresses.isNotEmpty) {
        setState(() => _selectedAddressId = profile.addresses.first.id);
      }
      if (profile.paymentMethods.isNotEmpty) {
        setState(() => _selectedPaymentId = profile.paymentMethods.first.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final profileProvider = context.watch<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/address'),
                  child: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (profileProvider.addresses.isEmpty)
              _buildEmptyState(
                'No addresses saved',
                Icons.location_off,
                () => Navigator.pushNamed(context, '/address'),
              )
            else
              ...profileProvider.addresses.map((address) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildSelectionCard(
                      title: address.title,
                      subtitle: address.address,
                      icon: Icons.location_on_outlined,
                      isSelected: _selectedAddressId == address.id,
                      onTap: () => setState(() => _selectedAddressId = address.id),
                    ),
                  )),

            const SizedBox(height: 32),

            // Payment Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/payment-methods'),
                  child: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (profileProvider.paymentMethods.isEmpty)
              _buildEmptyState(
                'No payment methods saved',
                Icons.credit_card_off,
                () => Navigator.pushNamed(context, '/payment-methods'),
              )
            else
              ...profileProvider.paymentMethods.map((method) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _buildSelectionCard(
                      title: method.type,
                      subtitle: method.number,
                      icon: Icons.credit_card,
                      isSelected: _selectedPaymentId == method.id,
                      onTap: () => setState(() => _selectedPaymentId = method.id),
                    ),
                  )),

            const SizedBox(height: 32),

            // Order Summary
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildSummaryRow('Subtotal', '\$${cartProvider.totalAmount.toStringAsFixed(2)}'),
            _buildSummaryRow('Delivery Fee', '\$2.00'),
            const Divider(height: 24),
            _buildSummaryRow(
              'Total',
              '\$${(cartProvider.totalAmount + 2.0).toStringAsFixed(2)}',
              isTotal: true,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppConstants.spacing20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: (_selectedAddressId == null || _selectedPaymentId == null)
              ? null
              : () => _handlePayment(context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
          ),
          child: const Text(
            'PAY & PLACE ORDER',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[400], size: 40),
            const SizedBox(height: 12),
            Text(message, style: TextStyle(color: Colors.grey[600])),
            const Text('Tap to add one', style: TextStyle(color: AppConstants.primaryOrange, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isSelected ? AppConstants.primaryOrange : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppConstants.primaryOrange.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppConstants.primaryOrange : AppConstants.lightText),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: AppConstants.lightText, fontSize: 12)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppConstants.primaryOrange),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppConstants.primaryOrange : null,
            ),
          ),
        ],
      ),
    );
  }

  void _handlePayment(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    final orderProvider = context.read<OrderProvider>();
    final notificationProvider = context.read<NotificationProvider>();
    final profileProvider = context.read<ProfileProvider>();

    final selectedAddress = profileProvider.addresses.firstWhere((a) => a.id == _selectedAddressId);

    // Create order
    orderProvider.addOrder(
      OrderModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        items: cartProvider.items.values.toList(),
        totalAmount: cartProvider.totalAmount + 2.0,
        date: DateTime.now(),
        status: 'Pending',
        deliveryAddress: selectedAddress.title,
      ),
    );

    // Add notification
    notificationProvider.addNotification(
      title: 'Commande confirmée !',
      message: 'Votre commande est en route vers votre adresse (${selectedAddress.title}).',
      type: NotificationType.orderStatus,
    );

    // Clear cart
    cartProvider.clear();

    // Show success alert
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success!',
      text: 'Your order has been placed successfully.',
      onConfirmBtnTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      },
    );
  }
}

