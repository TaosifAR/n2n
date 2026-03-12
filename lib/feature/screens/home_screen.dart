import 'package:flutter/material.dart';
import 'urgent_report_screen.dart'; // Import your report form screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("n2n Framework", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline_rounded, size: 100, color: Colors.green.shade400),
            const SizedBox(height: 20),
            const Text(
              "System is Active",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              "All modules are running smoothly.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      // The floating action button to trigger the Urgent Help Request
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UrgentReportScreen()),
          );
        },
        backgroundColor: Colors.red.shade600,
        label: const Text("URGENT HELP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.emergency_rounded, color: Colors.white),
      ),
    );
  }
}