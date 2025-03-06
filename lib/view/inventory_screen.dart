import 'package:flutter/material.dart';
import 'package:materialcalculator/controller/inventory_provider.dart';
import 'package:provider/provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<InventoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text("Inventory"),
        actions: [
          IconButton(
            onPressed: () {
              inventory.clearUsedHistory();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.pushNamed(
            context,
            'pastCalculations',
            arguments: inventory.usedItems,
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: inventory.items.length,
          itemBuilder: (context, index) {
            var item = inventory.items[index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item: ${item.name}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Quantity: ${item.quantity} ${item.unit}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController qtyController =
                            TextEditingController();
                            return AlertDialog(
                              title: Text("Use ${item.name}"),
                              content: TextField(
                                controller: qtyController,
                                decoration: const InputDecoration(
                                    labelText: "Enter quantity to use"),
                                keyboardType:
                                const TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    double qty = double.tryParse(
                                        qtyController.text) ??
                                        0;
                                    if (qty > 0 && qty <= item.quantity) {
                                      inventory.useItem(item.name, qty);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Use"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
