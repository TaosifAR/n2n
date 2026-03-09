import 'package:equatable/equatable.dart';

abstract class SystemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SystemAppStarted extends SystemEvent {}

class CheckSystemStatus extends SystemEvent {}

class ConnectivityChanged extends SystemEvent {
  final bool isConnected;

  ConnectivityChanged(this.isConnected);
  @override
  List<Object?> get props => [isConnected];
}

class ServerStatusUpdated extends SystemEvent {
  final String status;
  ServerStatusUpdated(this.status);
  @override
  List<Object?> get props => [status];
}
