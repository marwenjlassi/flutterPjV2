import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/orders/providers/order_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: orderProvider.orders.isEmpty
          ? const Center(child: Text('No orders yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacing16),
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: AppConstants.spacing16),
                  child: ExpansionTile(
                    title: Text('Order #${order.id.substring(order.id.length - 5)}'),
                    subtitle: Text(DateFormat('MMM dd, yyyy - HH:mm').format(order.date)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: order.status == 'Pending' ? Colors.orange.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            order.status,
                            style: TextStyle(
                              color: order.status == 'Pending' ? Colors.orange : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.track_changes, color: AppConstants.primaryOrange),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/order-tracking',
                              arguments: order,
                            );
                          },
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppConstants.spacing16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                            ...order.items.map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${item.quantity}x ${item.food.title}'),
                                  Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                                ],
                              ),
                            )),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('\$${order.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppConstants.primaryOrange)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('Delivery Address:', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(order.deliveryAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
