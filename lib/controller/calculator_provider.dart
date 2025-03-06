import 'package:flutter/cupertino.dart';
import 'package:materialcalculator/model/calculatemodels.dart';

class CalculateController extends ChangeNotifier {
  CalculateModel? result;

  void calculate(double height, double width, double length) {
    double volume = height * width * length;
    result = CalculateModel(
      cement: volume * 8,
      sand: volume * 10,
      aggregate: volume * 12,
    );
    notifyListeners();
  }
}
