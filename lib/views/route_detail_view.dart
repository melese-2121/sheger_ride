// route_detail_view.dart
import 'package:flutter/material.dart';

class RouteDetailView extends StatelessWidget {
  final String route;
  final String distance;
  final String duration;
  final String price;

  const RouteDetailView({
    super.key,
    required this.route,
    required this.distance,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text("Route Details"),
        backgroundColor: colorScheme.surface,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              route,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text("Distance: $distance", style: theme.textTheme.bodyMedium),
            Text("Duration: $duration", style: theme.textTheme.bodyMedium),
            Text("Price: $price", style: theme.textTheme.bodyMedium),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Booking feature coming soon!")),
                );
              },
              icon: const Icon(Icons.local_taxi),
              label: const Text("Book Ride"),
            ),
          ],
        ),
      ),
    );
  }
}
