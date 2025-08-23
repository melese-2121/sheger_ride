import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sheger Ride - Home"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          "Welcome to Sheger Ride 🚖",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
