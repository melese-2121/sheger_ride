import 'package:flutter/material.dart';

class RoutePlannerView extends StatelessWidget {
  const RoutePlannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Route Planner Page",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
