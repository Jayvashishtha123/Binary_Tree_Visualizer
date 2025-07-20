import 'package:flutter/foundation.dart';

class TreeModel extends ChangeNotifier {
  List<int> _values = [1,2,3,4,5,6,7];
  List<int> get values => _values;

  void setValues(List<int> v) { _values = v; notifyListeners(); }
  void reset() { _values = [1,2,3,4,5,6,7]; notifyListeners(); }
  void clear() { _values = []; notifyListeners(); }
  void shuffle() { _values.shuffle(); notifyListeners(); }
  void addNode() {
    int next = (_values.isEmpty ? 1 : (_values.reduce((a,b)=>a>b?a:b)) + 1);
    _values.add(next);
    notifyListeners();
  }
  void removeLast() {
    if (_values.isNotEmpty) _values.removeLast();
    notifyListeners();
  }
}