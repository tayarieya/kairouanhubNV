import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/request_models.dart';

class RequestDetailsScreen extends ConsumerWidget {
  final JobRequest request;

  const RequestDetailsScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request.service?.name ?? 'Unknown Service',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${request.status}',
              style: TextStyle(
                color: request.status == 'pending' ? Colors.orange : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(request.details),
            const SizedBox(height: 16),
            const Text('City:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(request.city),
            const SizedBox(height: 16),
            const Text('Scheduled Date:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(request.scheduledDate ?? 'Not scheduled'),
          ],
        ),
      ),
    );
  }
}
