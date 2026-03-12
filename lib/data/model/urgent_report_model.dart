import 'package:equatable/equatable.dart';

class UrgentHelpRequest extends Equatable {
  final String reporterName;
  final String reporterPhone;
  final String reporterEmail;
  final String subjectCategory;
  final String estimatedAge;
  final bool isLifeThreatening;
  final String description;
  final double lat;
  final double long;
  final String landmark;

  const UrgentHelpRequest({
    required this.reporterName,
    required this.reporterPhone,
    required this.reporterEmail,
    required this.subjectCategory,
    required this.estimatedAge,
    required this.isLifeThreatening,
    required this.description,
    required this.lat,
    required this.long,
    required this.landmark,
  });

  /// Converts the Model to JSON to send to your Fake API
  Map<String, dynamic> toJson() {
    return {
      'reporter_name': reporterName,
      'reporter_phone': reporterPhone,
      'reporter_email': reporterEmail,
      'subject_category': subjectCategory,
      'estimated_age': estimatedAge,
      'is_life_threatening': isLifeThreatening,
      'description': description,
      'lat': lat,
      'long': long,
      'landmark': landmark,
    };
  }

  @override
  List<Object?> get props => [
        reporterName,
        reporterPhone,
        reporterEmail,
        subjectCategory,
        estimatedAge,
        isLifeThreatening,
        description,
        lat,
        long,
        landmark,
      ];
}