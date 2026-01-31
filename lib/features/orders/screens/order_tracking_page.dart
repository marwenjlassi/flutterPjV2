import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/features/orders/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderTrackingPage extends StatefulWidget {
  final OrderModel order;

  const OrderTrackingPage({super.key, required this.order});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    _determineStep();
  }

  void _determineStep() {
    switch (widget.order.status) {
      case 'Pending':
        activeStep = 0;
        break;
      case 'Confirmed':
        activeStep = 1;
        break;
      case 'Preparing':
        activeStep = 2;
        break;
      case 'On the way':
        activeStep = 3;
        break;
      case 'Delivered':
        activeStep = 4;
        break;
      default:
        activeStep = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.order.id.substring(widget.order.id.length - 5)}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppConstants.primaryOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
              ),
              child: Row(
                children: [
                  const Icon(Icons.delivery_dining, size: 40, color: AppConstants.primaryOrange),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estimated Delivery',
                        style: TextStyle(color: AppConstants.lightText),
                      ),
                      Text(
                        DateFormat('HH:mm').format(widget.order.date.add(const Duration(minutes: 45))),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Stepper
            EasyStepper(
              activeStep: activeStep,
              lineStyle: const LineStyle(
                lineLength: 50,
                lineType: LineType.normal,
                lineThickness: 3,
                lineSpace: 1,
                lineWidth: 10,
                unreachedLineType: LineType.dashed,
              ),
              stepShape: StepShape.circle,
              stepBorderRadius: 15,
              borderThickness: 2,
              padding: const EdgeInsets.all(20),
              loadingAnimation: 'fade',
              steps: const [
                EasyStep(
                  icon: Icon(Icons.receipt_long),
                  title: 'Order Placed',
                ),
                EasyStep(
                  icon: Icon(Icons.check_circle_outline),
                  title: 'Confirmed',
                ),
                EasyStep(
                  icon: Icon(Icons.soup_kitchen),
                  title: 'Preparing',
                ),
                EasyStep(
                  icon: Icon(Icons.local_shipping_outlined),
                  title: 'On the way',
                ),
                EasyStep(
                  icon: Icon(Icons.home_outlined),
                  title: 'Delivered',
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
            const SizedBox(height: 40),

            // Order Details
            const Text(
              'Order Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...widget.order.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${item.quantity}x ${item.food.title}'),
                      Text('\$${item.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  '\$${widget.order.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppConstants.primaryOrange),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
