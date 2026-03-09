import 'package:equatable/equatable.dart';

abstract class SystemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SystemInitial extends SystemState {}

class SystemNormal extends SystemState {}

class SystemNoInternet extends SystemState {}

class SystemMaintenance extends SystemState {}

class SystemUpdateRequired extends SystemState {
  final String updateUrl;
  SystemUpdateRequired(this.updateUrl);
  @override
  List<Object?> get props => [updateUrl];
}

class SystemServerError extends SystemState{}
