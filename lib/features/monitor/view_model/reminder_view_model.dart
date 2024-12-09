import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/model/models/history_model.dart';
import '../../../core/model/simulated_data/simulated_values.dart';

class ReminderState extends ChangeNotifier {
  List<HistoryModel> _regimenList = generateSimulatedData();
  List<HistoryModel> _historyList = [];

  bool _val = true;
  bool _pillCount = false;
  String _selectedSound = 'Aegean Sea'; // Default sound
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isAlarmOn = true;

  List<HistoryModel> get regimenList => _regimenList;
  List<HistoryModel> get historyList => _historyList;

  bool get val => _val;
  bool get pillCount => _pillCount;
  String get selectedSound => _selectedSound;
  TimeOfDay get selectedTime => _selectedTime;
  bool get isAlarmOn => _isAlarmOn;
  final Map<int, bool> _checkedMap =
      {}; // Map to store checked status of regimens

  int _medcoin = 0; // To store medcoin balance

  int get medcoin => _medcoin;
  double get medcoinToNairaRate =>
      0.1; // 100 Medcoin = 10 Naira, so 1 Medcoin = 0.1 Naira

  ReminderState() {
    _loadMedcoin();
    loadHistoryList();
  }

  Future<void> loadHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJson = prefs.getStringList('history_list') ?? [];
    _historyList = historyJson
        .map((json) => HistoryModel.fromJson(jsonDecode(json)))
        .toList();
    notifyListeners();
  }

  Future<void> _saveHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyJson =
        _historyList.map((model) => jsonEncode(model.toJson())).toList();
    await prefs.setStringList('history_list', historyJson);
  }

  void addHistory(HistoryModel history) {
    _historyList.add(history);
    _saveHistoryList();
    notifyListeners();
  }

  void deductMedcoin(int amount) {
    _medcoin -= amount;
    _saveMedcoin(); // Save the updated medcoin balance
    notifyListeners();
  }

  Future<void> _loadMedcoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _medcoin = prefs.getInt('medcoin') ?? 0;
    notifyListeners();
  }

  Future<void> _saveMedcoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('medcoin', _medcoin);
  }

  double get medcoinInNaira => _medcoin * medcoinToNairaRate;

  void addMedcoin(int amount) {
    _medcoin += amount;
    _saveMedcoin();
    notifyListeners();
  }

  void updateMedcoin(int amount) {
    _medcoin = amount;
    notifyListeners();
  }

  // Method to get the number of checked regimens
  int getCheckedCount() {
    int count = 0;
    for (var i = 0; i < _regimenList.length; i++) {
      if (_checkedMap.containsKey(i) && _checkedMap[i]!) {
        count++;
      }
    }
    return count;
  }

  // Method to check if a regimen at a specific index is checked
  bool isChecked(HistoryModel regimen) {
    int index = _regimenList.indexOf(regimen);
    return _checkedMap[index] ?? false;
  }

  bool areAllSelected() {
    return _regimenList.isNotEmpty &&
        _checkedMap.length == _regimenList.length &&
        _checkedMap.values.every((isChecked) => isChecked);
  }

  // Method to toggle the checked status of a regimen at a specific index
  void toggleChecked(HistoryModel regimen) {
    int index = _regimenList.indexOf(regimen);
    bool isChecked = _checkedMap[index] ?? false;
    _checkedMap[index] = !isChecked;
    notifyListeners();
  }

  void updateRegimenList(List<HistoryModel> updatedList) {
    _regimenList = updatedList;
    notifyListeners();
  }

  void updateVal(bool newVal) {
    _val = newVal;
    notifyListeners();
  }

  void updatePillCount(bool newPillCount) {
    _pillCount = newPillCount;
    notifyListeners();
  }

  void updateSelectedSound(String newSound) {
    _selectedSound = newSound;
    notifyListeners();
  }

  void updateSelectedTime(TimeOfDay newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }

  void updateIsAlarmOn(bool newIsAlarmOn) {
    _isAlarmOn = newIsAlarmOn;
    notifyListeners();
  }

  // Method to select all regimens
  void selectAll() {
    for (var i = 0; i < _regimenList.length; i++) {
      _checkedMap[i] = true;
    }
    notifyListeners();
  }

  void clearCheckedItems() {
    _checkedMap.clear(); // Clear the checked map
    notifyListeners(); // Notify listeners of the state change
  }
}
