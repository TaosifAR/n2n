import 'package:equatable/equatable.dart';

/// Base class for all states related to the system's health and connectivity.
abstract class SystemState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// The starting state before any checks (Internet or Server) are completed.
class SystemInitial extends SystemState {}

/// The state when everything is functional (Internet is up, Server is online).
class SystemNormal extends SystemState {}

/// Triggered when the device loses internet connectivity.
class SystemNoInternet extends SystemState {}

/// Triggered when the server is undergoing maintenance.
class SystemMaintenance extends SystemState {}

/// Triggered when a critical app update is required.
class SystemUpdateRequired extends SystemState {
  final String updateUrl;

  SystemUpdateRequired(this.updateUrl);

  @override
  List<Object?> get props => [updateUrl];
}

/// Triggered when the server returns an error or is unreachable.
class SystemServerError extends SystemState {}