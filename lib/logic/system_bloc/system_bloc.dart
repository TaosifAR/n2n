import 'package:flutter_bloc/flutter_bloc.dart';
import 'system_event.dart';
import 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc() : super(SystemInitial()) {
    //initial check for app status
    on<SystemAppStarted>((event, emit) async {
      emit(SystemNormal());
    });

    //check for connectivity changes
    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(SystemNormal());
      } else {
        emit(SystemNoInternet());
      }
    });

    //check for server status updates
    on<ServerStatusUpdated>((event, emit) {
      if (event.status == 'maintenance') {
        emit(SystemMaintenance());
      }else if (event.status == 'update'){
        emit(SystemUpdateRequired("https://play.google.com/store/apps/details?id=n2n"))

      } else if (event.status == 'server_down'){
        emit(SystemServerError());
      }else{
        emit(SystemNormal());
      }
    });
  }
}
