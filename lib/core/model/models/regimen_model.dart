class RegimenDescriptionModel {
  final String medicationForm;
  final String dose;
  final String pillTime;
  final String pillFrequency;
  final String duration;
  final String notes;

  RegimenDescriptionModel({
    required this.medicationForm,
    required this.dose,
    required this.pillTime,
    required this.pillFrequency,
    required this.duration,
    required this.notes,
  });

  factory RegimenDescriptionModel.fromJson(Map<String, dynamic> json) {
    return RegimenDescriptionModel(
      medicationForm: json['medicationForm'],
      dose: json['dose'],
      pillTime: json['pillTime'],
      pillFrequency: json['pillFrequency'],
      duration: json['duration'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationForm': medicationForm,
      'dose': dose,
      'pillTime': pillTime,
      'pillFrequency': pillFrequency,
      'duration': duration,
      'notes': notes,
    };
  }
}
