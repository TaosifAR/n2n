class AppSettings {
  final bool isMaintenance;
  final String latestVersion;
  final bool isUpdateRequired;
  final String serverStatus;

  AppSettings({
    required this.isMaintenance,
    required this.latestVersion,
    required this.isUpdateRequired,
    required this.serverStatus,
  });
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      isMaintenance: json['is_maintenance'] ?? false,
      latestVersion: json['latest_version'] ?? '1.0.0',
      isUpdateRequired: json['is_update_required'] ?? false,
      serverStatus: json['server_status'] ?? 'online',
    );
  }
}
