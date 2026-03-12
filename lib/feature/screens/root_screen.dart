import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n2n/feature/maintenance_screen.dart';
import 'package:n2n/feature/screens/home_screen.dart';
import 'package:n2n/feature/screens/server_error_Screen.dart';
import 'package:n2n/feature/screens/update_required_screen.dart';
import 'package:n2n/logic/system_bloc/system_bloc.dart';
import 'package:n2n/logic/system_bloc/system_state.dart';

// Import the new standard screens you created
import 'no_internet_screen.dart';


class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemBloc, SystemState>(
      builder: (context, state) {
        // 1. Initial state when the system is checking status (Splash/Loading)
        if (state is SystemInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // You can replace this with your custom Splash Screen
            ),
          );
        }

        // 2. If there is no internet connection
        if (state is SystemNoInternet) {
          return const NoInternetScreen();
        } 
        
        // 3. If the system is under maintenance
        else if (state is SystemMaintenance) {
          return const MaintenanceScreen();
        } 
        
        // 4. If an app update is required
        else if (state is SystemUpdateRequired) {
          return const UpdateRequiredScreen();
        } 
        
        // 5. If a server error occurs
        else if (state is SystemServerError) {
          return const ServerErrorScreen();
        }

        // 6. If everything is fine (Normal State)
        return const HomeScreen(); 
      },
    );
  }
}