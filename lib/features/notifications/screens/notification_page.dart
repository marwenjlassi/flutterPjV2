import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/notifications/providers/notification_provider.dart';
import 'package:exam_flutter/features/notifications/models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () => context.read<NotificationProvider>().markAllAsRead(),
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(color: Colors.grey[500], fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppConstants.spacing16),
            itemCount: provider.notifications.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getNotificationColor(notification.type).withValues(alpha: 0.1),
                  child: Icon(
                    _getNotificationIcon(notification.type),
                    color: _getNotificationColor(notification.type),
                  ),
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.message),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM d, h:mm a').format(notification.timestamp),
                      style: const TextStyle(fontSize: 12, color: AppConstants.lightText),
                    ),
                  ],
                ),
                onTap: () => provider.markAsRead(notification.id),
                tileColor: notification.isRead ? null : Colors.orange.withValues(alpha: 0.05),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
        return Icons.shopping_bag_outlined;
      case NotificationType.promotion:
        return Icons.local_offer_outlined;
      case NotificationType.system:
        return Icons.info_outline;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.orderStatus:
        return AppConstants.primaryOrange;
      case NotificationType.promotion:
        return Colors.green;
      case NotificationType.system:
        return Colors.blue;
    }
  }
}
