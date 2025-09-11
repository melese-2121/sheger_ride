import 'package:flutter/material.dart';
import 'package:sheger_ride/widgets/app_button.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Map background (placeholder for now)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[900]!, Colors.grey[800]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.map_outlined,
                size: 140,
                color: Colors.white24,
              ),
            ),
          ),

          // Glassmorphism Search Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white24, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Where to?",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating buttons (Current Location + Menu)
          Positioned(
            bottom: 120,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "locationBtn",
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.my_location, color: Colors.black),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  heroTag: "menuBtn",
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.layers, color: Colors.black),
                ),
              ],
            ),
          ),

          // Bottom Sheet style card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.location_pin, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Set your destination",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 120,
                        height: 40,
                        child: AppButton(
                          label: "Confirm",
                          onPressed: () {},
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
