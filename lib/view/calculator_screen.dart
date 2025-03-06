import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/calculator_provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _lengthController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculateController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text("Material Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _lengthController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Length (m)", border: OutlineInputBorder())),
            SizedBox(
              height: 15,
            ),
            TextField(
                controller: _widthController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Width (m)", border: OutlineInputBorder())),
            SizedBox(
              height: 15,
            ),
            TextField(
                controller: _heightController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Height (m)", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black),
              onPressed: () {
                calculator.calculate(
                  double.parse(_lengthController.text),
                  double.parse(_widthController.text),
                  double.parse(_heightController.text),
                );
              },
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 20),
            calculator.result != null
                ? Text("Cement: ${calculator.result!.cement} bags\n"
                    "Sand: ${calculator.result!.sand} kg\n"
                    "Aggregate: ${calculator.result!.aggregate} kg")
                : const Text("Enter dimensions to calculate :"),
          ],
        ),
      ),
    );
  }
}
