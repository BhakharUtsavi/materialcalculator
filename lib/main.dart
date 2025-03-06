import 'package:flutter/material.dart';
import 'package:materialcalculator/controller/home_provider.dart';
import 'package:materialcalculator/view/calculator_screen.dart';
import 'package:materialcalculator/view/home_screen.dart';
import 'package:materialcalculator/view/inventory_screen.dart';
import 'package:materialcalculator/view/past_calculations_screen.dart';
import 'package:provider/provider.dart';
import 'controller/calculator_provider.dart';
import 'controller/inventory_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculateController()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomeScreen(),
        "calculator": (context) => CalculatorScreen(),
        "inventory": (context) => InventoryScreen(),
        "pastCalculations": (context) => PastCalculationsScreen(),
      },
    );
  }
}
