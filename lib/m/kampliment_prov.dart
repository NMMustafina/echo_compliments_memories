import 'package:echo_compliments_memories_198_a/m/kampliment.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KamplimentProv extends ChangeNotifier {
  List<Kampliment> _kampliments = [];

  KamplimentProv() {
    _loadKampliments();
  }

  List<Kampliment> get kampliments => List.unmodifiable(_kampliments);

  Future<void> _loadKampliments() async {
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final kamplimentsJson = prefs.getStringList("kampliments") ?? [];
    _kampliments =
        kamplimentsJson.map((json) => Kampliment.fromJson(json)).toList();

    notifyListeners();
  }

  Future<void> addKampliment(Kampliment kampliment) async {
    final prefs = await SharedPreferences.getInstance();
    final kamplimentsJson = _kampliments.map((k) => k.toJson()).toList()
      ..add(kampliment.toJson());
    await prefs.setStringList("kampliments", kamplimentsJson);
    await _loadKampliments();
  }

  Future<void> updateKampliment(Kampliment kampliment) async {
    final prefs = await SharedPreferences.getInstance();
    final index = _kampliments.indexWhere((k) => k.id == kampliment.id);
    if (index != -1) {
      _kampliments[index] = kampliment;
      final kamplimentsJson = _kampliments.map((k) => k.toJson()).toList();
      await prefs.setStringList("kampliments", kamplimentsJson);
      await _loadKampliments();
    }
  }

  Future<void> deleteKampliment(int id) async {
    final prefs = await SharedPreferences.getInstance();
    _kampliments.removeWhere((k) => k.id == id);
    final kamplimentsJson = _kampliments.map((k) => k.toJson()).toList();
    await prefs.setStringList("kampliments", kamplimentsJson);
    await _loadKampliments();
  }

  List<Kampliment> getKamplimentsByType(KamplimentType type) {
    return _kampliments.where((k) => k.kampType == type).toList();
  }
}
