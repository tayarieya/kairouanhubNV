import 'package:flutter/material.dart';
import '../requests/data/models/request_models.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final Service service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(service.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.work, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(
              service.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              service.summary ?? 'No description available.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            // Add more details like price, provider info etc.
            const Text('Provider Info:', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Various providers available.'),
          ],
        ),
      ),
    );
  }
}
