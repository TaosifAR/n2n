import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: 0.7,
                      strokeWidth: 2,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Icon(Icons.handyman_rounded, size: 50, color: Colors.orange.shade700),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "Maintenance in Progress",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3436)),
              ),
              const SizedBox(height: 15),
              const Text(
                "We are performing some scheduled updates to improve your experience. Hang tight!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black45, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}