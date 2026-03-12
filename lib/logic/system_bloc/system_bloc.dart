import 'package:flutter_bloc/flutter_bloc.dart';
import 'system_event.dart';
import 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc() : super(SystemInitial()) {
    
    // Initial check for app status
    on<SystemAppStarted>((event, emit) async {
      // It is better to emit SystemInitial first instead of moving directly to Normal.
      // This allows the first message from the Isolate to set the correct state.
      emit(SystemInitial()); 
    });

    // Check for internet connectivity changes
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        // Only return to SystemNormal if the previous state was NoInternet
        if (state is SystemNoInternet) {
           emit(SystemNormal());
        }
      } else {
        emit(SystemNoInternet());
      }
    });

    // Handle server status updates received from the Background Isolate
    on<ServerStatusUpdated>((event, emit) {
      // Essential for debugging the incoming status from the isolate
      print("SystemBloc Received Status: ${event.status}");

      if (event.status == 'maintenance') {
        emit(SystemMaintenance());
      } else if (event.status == 'update') {
        emit(SystemUpdateRequired("https://play.google.com/store/apps/details?id=n2n"));
      } else if (event.status == 'server_down') {
        emit(SystemServerError());
      } else if (event.status == 'normal') {
        // Transition to Normal only when the server signals a healthy state
        emit(SystemNormal());
      }
      // Note: No 'else' block here to prevent state changes from unknown messages
    });
  }
}