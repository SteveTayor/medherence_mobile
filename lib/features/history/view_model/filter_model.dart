import 'package:flutter/material.dart';

enum Status { all, taken, late, missed }

class FilterViewModel extends ChangeNotifier {
  Status status = Status.all;
  DateTime _selectedDate = DateTime.now();
  DateTime _secondSelectedDate = DateTime.now()
      .add(const Duration(days: 1)); // Default: 1 day after selectedDate
  TextEditingController dropDownSearchController = TextEditingController();
  String suggestion = "";
  String? selectedMedication;
  List<String> regimenNames = [];

  DateTime get selectedDate => _selectedDate;
  DateTime get secondSelectedDate => _secondSelectedDate;

  // Method to format DateTime as "yyyy-MM-dd"
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void setStatus(Status? value) {
    if (value != null) {
      status = value;
      notifyListeners();
    }
  }

  updateSelectedDate(DateTime pickedDate) {
    _selectedDate = pickedDate;
    notifyListeners();
  }

  updateSecondSelectedDate(DateTime pickedDate) {
    _secondSelectedDate = pickedDate;
    notifyListeners();
  }

  void setRegimenNames(List<String> names) {
    regimenNames = names;
    notifyListeners();
  }

  // Get suggestions based on the pattern
  List<String> getSuggestions(String pattern) {
    List<String> matches = regimenNames
        .where((s) => s.toLowerCase().contains(pattern.toLowerCase()))
        .toList();
    return matches;
  }
}
