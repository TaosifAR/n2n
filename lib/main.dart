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
  await Isolate.spawn(BackgrouondMonitor.start, receivePort.sendPort);
  runApp(MyApp(receivePort: receivePort));
}

class MyApp extends StatelessWidget {
  final ReceivePort receivePort;
  const MyApp({super.key, required this.receivePort});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = SystemBloc();
        receivePort.listen((message){
          if(message is String){
            bloc..add(ServerStatusUpdated(message));
          }
        });
        return bloc..add(SystemAppStarted());

      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const RootScreen(),
      ),
    );
  }
}
