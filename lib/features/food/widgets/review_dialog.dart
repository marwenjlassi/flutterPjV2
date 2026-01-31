import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';

class ReviewDialog extends StatefulWidget {
  final String foodTitle;
  final Function(double, String) onSubmit;

  const ReviewDialog({
    super.key,
    required this.foodTitle,
    required this.onSubmit,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 3.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate ${widget.foodTitle}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('How was your food?'),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Leave a comment (optional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(_rating, _commentController.text);
            Navigator.pop(context);
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Thanks!',
              text: 'Your review has been submitted.',
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryOrange,
            foregroundColor: Colors.white,
          ),
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}
