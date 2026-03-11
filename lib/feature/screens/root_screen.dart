import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n2n/logic/system_bloc/system_bloc.dart';
import 'package:n2n/logic/system_bloc/system_state.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemState>(
      builder: (context, state) {
        if (state is SystemNoInternet) {
          return const Scaffold(
            body: Center(child: Text("No Internet Connection")),
          );
        } else if (state is SystemMaintenance) {
          return const Scaffold(
            body: Center(child: Text("System Under Maintenance")),
          );
        } else if (state is SystemUpdateRequired) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A new update is required to continue using the app.",
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Open the update URL
                      // You can use url_launcher package to open the URL
                    },
                    child: const Text("Update Now"),
                  ),
                ],
              ),
            ),
          );
        } else if (state is SystemServerError) {
          return const Scaffold(
            body: Center(child: Text("Server Error. Please try again later.")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("n2n Framework")),
          body: const Center(child: Text("Welcome to n2n! Your app is working properly.")),
        );
      },
    );
  }
}
