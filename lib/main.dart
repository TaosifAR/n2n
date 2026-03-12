import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:n2n/core/background/bacground_service.dart';
import 'package:n2n/feature/screens/root_screen.dart';
import 'package:n2n/logic/system_bloc/system_bloc.dart';
import 'package:n2n/logic/system_bloc/system_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final receivePort = ReceivePort();
  // Spawning the background monitor isolate
  await Isolate.spawn(BackgrouondMonitor.start, receivePort.sendPort);
  runApp(MyApp(receivePort: receivePort));
}

class MyApp extends StatelessWidget {
  final ReceivePort receivePort;
  const MyApp({super.key, required this.receivePort});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false, // Ensure Bloc is created immediately
      create: (context) {
        final bloc = SystemBloc();

        // 1. Listen for messages coming from the background isolate
        receivePort.listen((message) {
          debugPrint("ISOLATE MESSAGE: $message"); // Debug Print
          if (message is String) {
            bloc.add(ServerStatusUpdated(message));
          }
        });

        // 2. Monitor internet connectivity changes
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
          final bool isConnected = !results.contains(ConnectivityResult.none);
          debugPrint("CONNECTIVITY: isConnected = $isConnected");
          bloc.add(ConnectivityChanged(isConnected));
        });

        // Trigger initial app start logic
        return bloc..add(SystemAppStarted());
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootScreen(),
      ),
    );
  }
}